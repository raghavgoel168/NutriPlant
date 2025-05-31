import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Plant {
  String name;  // Remove 'final' to make it mutable
  final String imagePath;
  Map<String, dynamic>? reminder;

  Plant({required this.name, required this.imagePath, this.reminder});
}

class SetNotification extends StatefulWidget {
  @override
  _SetNotificationState createState() => _SetNotificationState();

  static List<Plant> plants = [];

  static Future<void> loadPlants() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? plantsData = prefs.getString('plants');
    if (plantsData != null) {
      plants = List<Map<String, dynamic>>.from(json.decode(plantsData))
          .map((plantData) => Plant(
        name: plantData['name'],
        imagePath: plantData['image'],
        reminder: plantData['reminder'],
      ))
          .toList();
    }
  }

  static Future<void> savePlants() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String plantsData = json.encode(plants.map((plant) => {
      'name': plant.name,
      'image': plant.imagePath,
      'reminder': plant.reminder,
    }).toList());
    prefs.setString('plants', plantsData);
  }
}

class _SetNotificationState extends State<SetNotification> {
  final ImagePicker _picker = ImagePicker();
  FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    SetNotification.loadPlants().then((_) {
      setState(() {});
      _restoreReminders();
    });
  }

  void _initializeNotifications() {
    var androidInitSettings = AndroidInitializationSettings('app_icon');
    var initSettings = InitializationSettings(android: androidInitSettings);
    _notificationsPlugin.initialize(initSettings);
  }

  Future<void> _addPlant() async {
    // Show a dialog to select either camera or gallery
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.pop(context); // Close the dialog
                  PickedFile? image = await _picker.getImage(source: ImageSource.camera);
                  if (image != null && image.path.isNotEmpty) {
                    await _processNewPlant(image);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to capture image')));
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context); // Close the dialog
                  PickedFile? image = await _picker.getImage(source: ImageSource.gallery);
                  if (image != null && image.path.isNotEmpty) {
                    await _processNewPlant(image);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to load image')));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _processNewPlant(PickedFile image) async {
    String plantName = await _getPlantNameDialog();
    setState(() {
      SetNotification.plants.add(Plant(name: plantName, imagePath: image.path));
    });
    SetNotification.savePlants(); // Save plants after adding
  }


  Future<String> _getPlantNameDialog() async {
    String plantName = '';
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Plant Name'),
          content: TextField(
            onChanged: (value) => plantName = value,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    return plantName;
  }

  Future<void> _setReminder(int index) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        DateTime scheduledNotificationDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        // Get message and frequency
        String message = await _getReminderMessageDialog();
        String frequency = await _getReminderFrequencyDialog();

        // Unique notification ID
        int notificationId = DateTime.now().millisecondsSinceEpoch.remainder(100000);

        var androidDetails = AndroidNotificationDetails('reminder_channel', 'Reminders');
        var notificationDetails = NotificationDetails(android: androidDetails);

        // Schedule based on frequency
        switch (frequency) {
          case 'Once':
            _notificationsPlugin.schedule(
              notificationId,
              'Reminder for ${SetNotification.plants[index].name}',
              message,
              scheduledNotificationDateTime,
              notificationDetails,
            );
            break;
          case 'Daily':
            _notificationsPlugin.periodicallyShow(
              notificationId,
              'Daily Reminder for ${SetNotification.plants[index].name}',
              message,
              RepeatInterval.daily,
              notificationDetails,
            );
            break;
          case 'Once a week':
            _notificationsPlugin.periodicallyShow(
              notificationId,
              'Weekly Reminder for ${SetNotification.plants[index].name}',
              message,
              RepeatInterval.weekly,
              notificationDetails,
            );
            break;
        }

        setState(() {
          SetNotification.plants[index].reminder = {
            'id': notificationId,
            'dateTime': scheduledNotificationDateTime.toIso8601String(),
            'message': message,
            'frequency': frequency,
          };
        });
        SetNotification.savePlants(); // Save the reminder details after setting
      }
    }
  }

  Future<String> _getReminderFrequencyDialog() async {
    String selectedFrequency = 'Once'; // Default option
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Reminder Frequency'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return DropdownButton<String>(
                value: selectedFrequency,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedFrequency = newValue!;
                  });
                },
                items: <String>['Once', 'Daily', 'Once a week']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    return selectedFrequency;
  }


  Future<String> _getReminderMessageDialog() async {
    String message = '';
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Reminder Message'),
          content: TextField(
            onChanged: (value) => message = value,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    return message;
  }

  Future<void> _deletePlant(int index) async {
    bool? confirmed = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this plant?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirmed ?? false) {
      int? notificationId = SetNotification.plants[index].reminder?['id'];
      if (notificationId != null) {
        _notificationsPlugin.cancel(notificationId); // Cancel the notification
      }
      setState(() {
        SetNotification.plants.removeAt(index);
      });
      SetNotification.savePlants(); // Save plants after deletion
    }
  }

  Future<void> _restoreReminders() async {
    for (var plant in SetNotification.plants) {
      if (plant.reminder != null) {
        DateTime scheduledNotificationDateTime = DateTime.parse(plant.reminder!['dateTime']);
        String message = plant.reminder!['message'];
        int notificationId = plant.reminder!['id'];
        var androidDetails = AndroidNotificationDetails('reminder_channel', 'Reminders');
        var notificationDetails = NotificationDetails(android: androidDetails);
        _notificationsPlugin.schedule(
          notificationId,
          'Reminder for ${plant.name}',
          message,
          scheduledNotificationDateTime,
          notificationDetails,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Set Reminder',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Bold text style
            fontSize: 25.0,             // Optional: Adjust font size for better readability
          ),
        ),
        automaticallyImplyLeading: true, // Removes the back button
        centerTitle: true,                // Centers the title
        backgroundColor: Colors.green,    // Keeps the green background
      ),

      body: SetNotification.plants.isEmpty
          ? Center(child: Text('No plants added yet.', style: TextStyle(fontSize: 18)))
          : GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.65, // Adjusted ratio to give more vertical space
        ),
        itemCount: SetNotification.plants.length,
        itemBuilder: (context, index) {
          return _buildPlantCard(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPlant,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildPlantCard(int index) {
    Plant plant = SetNotification.plants[index];
    DateTime? reminderDate = plant.reminder != null
        ? DateTime.parse(plant.reminder!['dateTime'])
        : null;
    String? reminderFrequency = plant.reminder?['frequency'];

    return Card(
      elevation: 5,
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.file(
                File(plant.imagePath),
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    plant.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _editPlantName(index),
                  ),
                ],
              ),
            ),
            if (reminderDate != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.green, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reminder Set For:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${reminderDate.day}-${reminderDate.month}-${reminderDate.year} ${reminderDate.hour}:${reminderDate.minute}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 8),
                      if (reminderFrequency != null)
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Frequency: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown, // Label "Frequency:" color
                                ),
                              ),
                              TextSpan(
                                text: '$reminderFrequency',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green, // Different color for frequency type
                                ),
                              ),
                            ],
                          ),
                        ),

                      SizedBox(height: 8),
                      Text(
                        'Message:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        plant.reminder!['message'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: IconButton(
                    icon: Icon(Icons.alarm, color: Colors.green),
                    onPressed: () => _setReminder(index),
                  ),
                ),
                Flexible(
                  child: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deletePlant(index),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Future<void> _editPlantName(int index) async {
    String newPlantName = SetNotification.plants[index].name;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Plant Name'),
          content: TextField(
            controller: TextEditingController(text: newPlantName),
            onChanged: (value) => newPlantName = value,
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  SetNotification.plants[index].name = newPlantName;
                });
                SetNotification.savePlants(); // Save the updated name
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
