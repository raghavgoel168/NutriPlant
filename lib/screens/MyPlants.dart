// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class Plant {
//   String name;  // Remove 'final' to make it mutable
//   final String imagePath;
//   Map<String, dynamic>? reminder;
//
//   Plant({required this.name, required this.imagePath, this.reminder});
// }
//
// class MyPlantsScreen extends StatefulWidget {
//   @override
//   _MyPlantsScreenState createState() => _MyPlantsScreenState();
//
//   static List<Plant> plants = [];
//
//   static Future<void> loadPlants() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? plantsData = prefs.getString('plants');
//     if (plantsData != null) {
//       plants = List<Map<String, dynamic>>.from(json.decode(plantsData))
//           .map((plantData) => Plant(
//         name: plantData['name'],
//         imagePath: plantData['image'],
//         reminder: plantData['reminder'],
//       ))
//           .toList();
//     }
//   }
//
//   static Future<void> savePlants() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String plantsData = json.encode(plants.map((plant) => {
//       'name': plant.name,
//       'image': plant.imagePath,
//       'reminder': plant.reminder,
//     }).toList());
//     prefs.setString('plants', plantsData);
//   }
// }
//
// class _MyPlantsScreenState extends State<MyPlantsScreen> {
//   final ImagePicker _picker = ImagePicker();
//   FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeNotifications();
//     MyPlantsScreen.loadPlants().then((_) {
//       setState(() {});
//       _restoreReminders();
//     });
//   }
//
//   void _initializeNotifications() {
//     var androidInitSettings = AndroidInitializationSettings('app_icon');
//     var initSettings = InitializationSettings(android: androidInitSettings);
//     _notificationsPlugin.initialize(initSettings);
//   }
//
//   Future<void> _addPlant() async {
//     // Show a dialog to select either camera or gallery
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Select Image Source'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: Icon(Icons.camera),
//                 title: Text('Camera'),
//                 onTap: () async {
//                   Navigator.pop(context); // Close the dialog
//                   PickedFile? image = await _picker.getImage(source: ImageSource.camera);
//                   if (image != null && image.path.isNotEmpty) {
//                     await _processNewPlant(image);
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Failed to capture image')));
//                   }
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.photo_library),
//                 title: Text('Gallery'),
//                 onTap: () async {
//                   Navigator.pop(context); // Close the dialog
//                   PickedFile? image = await _picker.getImage(source: ImageSource.gallery);
//                   if (image != null && image.path.isNotEmpty) {
//                     await _processNewPlant(image);
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Failed to load image')));
//                   }
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> _processNewPlant(PickedFile image) async {
//     String plantName = await _getPlantNameDialog();
//     setState(() {
//       MyPlantsScreen.plants.add(Plant(name: plantName, imagePath: image.path));
//     });
//     MyPlantsScreen.savePlants(); // Save plants after adding
//   }
//
//
//   Future<String> _getPlantNameDialog() async {
//     String plantName = '';
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Enter Plant Name'),
//           content: TextField(
//             onChanged: (value) => plantName = value,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//     return plantName;
//   }
//
//   Future<void> _setReminder(int index) async {
//     DateTime? selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//
//     if (selectedDate != null) {
//       TimeOfDay? selectedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//       );
//
//       if (selectedTime != null) {
//         DateTime scheduledNotificationDateTime = DateTime(
//           selectedDate.year,
//           selectedDate.month,
//           selectedDate.day,
//           selectedTime.hour,
//           selectedTime.minute,
//         );
//
//         // Get message and frequency
//         String message = await _getReminderMessageDialog();
//         String frequency = await _getReminderFrequencyDialog();
//
//         // Unique notification ID
//         int notificationId = DateTime.now().millisecondsSinceEpoch.remainder(100000);
//
//         var androidDetails = AndroidNotificationDetails('reminder_channel', 'Reminders');
//         var notificationDetails = NotificationDetails(android: androidDetails);
//
//         // Schedule based on frequency
//         switch (frequency) {
//           case 'Once':
//             _notificationsPlugin.schedule(
//               notificationId,
//               'Reminder for ${MyPlantsScreen.plants[index].name}',
//               message,
//               scheduledNotificationDateTime,
//               notificationDetails,
//             );
//             break;
//           case 'Daily':
//             _notificationsPlugin.periodicallyShow(
//               notificationId,
//               'Daily Reminder for ${MyPlantsScreen.plants[index].name}',
//               message,
//               RepeatInterval.daily,
//               notificationDetails,
//             );
//             break;
//           case 'Once a week':
//             _notificationsPlugin.periodicallyShow(
//               notificationId,
//               'Weekly Reminder for ${MyPlantsScreen.plants[index].name}',
//               message,
//               RepeatInterval.weekly,
//               notificationDetails,
//             );
//             break;
//         }
//
//         setState(() {
//           MyPlantsScreen.plants[index].reminder = {
//             'id': notificationId,
//             'dateTime': scheduledNotificationDateTime.toIso8601String(),
//             'message': message,
//             'frequency': frequency,
//           };
//         });
//         MyPlantsScreen.savePlants(); // Save the reminder details after setting
//       }
//     }
//   }
//
//   Future<String> _getReminderFrequencyDialog() async {
//     String selectedFrequency = 'Once'; // Default option
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Select Reminder Frequency'),
//           content: StatefulBuilder(
//             builder: (context, setState) {
//               return DropdownButton<String>(
//                 value: selectedFrequency,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedFrequency = newValue!;
//                   });
//                 },
//                 items: <String>['Once', 'Daily', 'Once a week']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               );
//             },
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//     return selectedFrequency;
//   }
//
//
//   Future<String> _getReminderMessageDialog() async {
//     String message = '';
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Enter Reminder Message'),
//           content: TextField(
//             onChanged: (value) => message = value,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//     return message;
//   }
//
//   Future<void> _deletePlant(int index) async {
//     bool? confirmed = await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Confirm Delete'),
//           content: Text('Are you sure you want to delete this plant?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context, false),
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pop(context, true),
//               child: Text('Delete', style: TextStyle(color: Colors.red)),
//             ),
//           ],
//         );
//       },
//     );
//
//     if (confirmed ?? false) {
//       int? notificationId = MyPlantsScreen.plants[index].reminder?['id'];
//       if (notificationId != null) {
//         _notificationsPlugin.cancel(notificationId); // Cancel the notification
//       }
//       setState(() {
//         MyPlantsScreen.plants.removeAt(index);
//       });
//       MyPlantsScreen.savePlants(); // Save plants after deletion
//     }
//   }
//
//   Future<void> _restoreReminders() async {
//     for (var plant in MyPlantsScreen.plants) {
//       if (plant.reminder != null) {
//         DateTime scheduledNotificationDateTime = DateTime.parse(plant.reminder!['dateTime']);
//         String message = plant.reminder!['message'];
//         int notificationId = plant.reminder!['id'];
//         var androidDetails = AndroidNotificationDetails('reminder_channel', 'Reminders');
//         var notificationDetails = NotificationDetails(android: androidDetails);
//         _notificationsPlugin.schedule(
//           notificationId,
//           'Reminder for ${plant.name}',
//           message,
//           scheduledNotificationDateTime,
//           notificationDetails,
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'My Plants',
//           style: TextStyle(
//             fontWeight: FontWeight.bold, // Bold text style
//             fontSize: 25.0,             // Optional: Adjust font size for better readability
//           ),
//         ),
//         automaticallyImplyLeading: false, // Removes the back button
//         centerTitle: true,                // Centers the title
//         backgroundColor: Colors.green,    // Keeps the green background
//       ),
//
//       body: MyPlantsScreen.plants.isEmpty
//           ? Center(child: Text('No plants added yet.', style: TextStyle(fontSize: 18)))
//           : GridView.builder(
//         padding: const EdgeInsets.all(8.0),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 8.0,
//           mainAxisSpacing: 8.0,
//           childAspectRatio: 0.65, // Adjusted ratio to give more vertical space
//         ),
//         itemCount: MyPlantsScreen.plants.length,
//         itemBuilder: (context, index) {
//           return _buildPlantCard(index);
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _addPlant,
//         child: Icon(Icons.add),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }
//
//   Widget _buildPlantCard(int index) {
//     Plant plant = MyPlantsScreen.plants[index];
//     DateTime? reminderDate = plant.reminder != null
//         ? DateTime.parse(plant.reminder!['dateTime'])
//         : null;
//     String? reminderFrequency = plant.reminder?['frequency'];
//
//     return Card(
//       elevation: 5,
//       margin: EdgeInsets.all(8.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(50.0),
//               child: Image.file(
//                 File(plant.imagePath),
//                 width: double.infinity,
//                 height: 150,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     plant.name,
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.edit, color: Colors.blue),
//                     onPressed: () => _editPlantName(index),
//                   ),
//                 ],
//               ),
//             ),
//             if (reminderDate != null)
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//                 child: Container(
//                   padding: EdgeInsets.all(12.0),
//                   decoration: BoxDecoration(
//                     color: Colors.green.shade50,
//                     borderRadius: BorderRadius.circular(8.0),
//                     border: Border.all(color: Colors.green, width: 1),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Reminder Set For:',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.brown,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         '${reminderDate.day}-${reminderDate.month}-${reminderDate.year} ${reminderDate.hour}:${reminderDate.minute}',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.green,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       if (reminderFrequency != null)
//                         RichText(
//                           text: TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: 'Frequency: ',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.brown, // Label "Frequency:" color
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: '$reminderFrequency',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.green, // Different color for frequency type
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                       SizedBox(height: 8),
//                       Text(
//                         'Message:',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.brown,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         plant.reminder!['message'],
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.green,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ButtonBar(
//               alignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Flexible(
//                   child: IconButton(
//                     icon: Icon(Icons.alarm, color: Colors.green),
//                     onPressed: () => _setReminder(index),
//                   ),
//                 ),
//                 Flexible(
//                   child: IconButton(
//                     icon: Icon(Icons.delete, color: Colors.red),
//                     onPressed: () => _deletePlant(index),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Future<void> _editPlantName(int index) async {
//     String newPlantName = MyPlantsScreen.plants[index].name;
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Edit Plant Name'),
//           content: TextField(
//             controller: TextEditingController(text: newPlantName),
//             onChanged: (value) => newPlantName = value,
//             autofocus: true,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   MyPlantsScreen.plants[index].name = newPlantName;
//                 });
//                 MyPlantsScreen.savePlants(); // Save the updated name
//                 Navigator.pop(context);
//               },
//               child: Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'PlantFolderScreen.dart';

class MyPlantScreen extends StatefulWidget {
  @override
  _MyPlantScreenState createState() => _MyPlantScreenState();
}

class _MyPlantScreenState extends State<MyPlantScreen> {
  List<String> plantFolders = [];
  Map<String, String> folderImages = {};

  @override
  void initState() {
    super.initState();
    _loadFolders();
  }

  Future<void> _loadFolders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      plantFolders = (prefs.getStringList('plantFolders') ?? []);
      String? folderImagesJson = prefs.getString('folderImages');
      if (folderImagesJson != null) {
        folderImages = Map<String, String>.from(json.decode(folderImagesJson));
      }
    });
  }

  Future<void> _saveFolders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('plantFolders', plantFolders);
    await prefs.setString('folderImages', json.encode(folderImages));
  }

  Future<void> _pickImage(String folderName) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        folderImages[folderName] = pickedFile.path;
      });
      await _saveFolders();
    }
  }

  void _createFolder() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController folderController = TextEditingController();
        return AlertDialog(
          title: Text('Create Folder'),
          content: TextField(
            controller: folderController,
            decoration: InputDecoration(hintText: 'Enter folder name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (folderController.text.isNotEmpty) {
                  setState(() {
                    plantFolders.add(folderController.text);
                  });
                  await _saveFolders();
                  Navigator.pop(context);
                }
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _renameFolder(int index) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController folderController = TextEditingController();
        folderController.text = plantFolders[index];
        return AlertDialog(
          title: Text('Rename Folder'),
          content: TextField(
            controller: folderController,
            decoration: InputDecoration(hintText: 'Enter new folder name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                String newFolderName = folderController.text;
                if (newFolderName.isNotEmpty && newFolderName != plantFolders[index]) {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  List<String> images = prefs.getStringList(plantFolders[index]) ?? [];
                  await prefs.setStringList(newFolderName, images);
                  await prefs.remove(plantFolders[index]);
                  setState(() {
                    plantFolders[index] = newFolderName;
                  });
                  await _saveFolders();
                  Navigator.pop(context);
                }
              },
              child: Text('Rename'),
            ),
          ],
        );
      },
    );
  }

  void _deleteFolder(int index) async {
    String folderName = plantFolders[index];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      plantFolders.removeAt(index);
      folderImages.remove(folderName);
    });
    await prefs.remove(folderName);
    await _saveFolders();
  }

  void _navigateToFolder(String folderName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlantFolderScreen(folderName: folderName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Plants',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: plantFolders.isEmpty
          ?
        Center(
          child: Text(
            'No folders created.\nTap the "+" to add a folder.',
            textAlign: TextAlign.center, // Centers text within the widget
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
      )
          : GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: plantFolders.length,
        itemBuilder: (context, index) {
          String folderName = plantFolders[index];
          return GestureDetector(
            onTap: () => _navigateToFolder(folderName),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  folderImages.containsKey(folderName)
                      ? Image.file(
                    File(folderImages[folderName]!),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  )
                      : Container(
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.image,
                      size: 80,
                      color: Colors.grey,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black.withOpacity(0.6),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        folderName,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 50, // Explicit width
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(1), // Adjust padding for smaller background
                          child: IconButton(
                            iconSize: 23, // Reduce icon size if needed
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _renameFolder(index),
                          ),
                        ),
                        SizedBox(height: 8), // Spacing between icons
                        Container(
                          width: 50, // Explicit width
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(1), // Adjust padding for smaller background
                          child: IconButton(
                            iconSize: 23, // Reduce icon size if needed
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteFolder(index),
                          ),
                        ),
                        SizedBox(height: 8), // Spacing between icons
                        Container(
                          width: 50, // Explicit width
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(1), // Adjust padding for smaller background
                          child: IconButton(
                            iconSize: 23, // Reduce icon size if needed
                            icon: Icon(Icons.camera_alt, color: Colors.green),
                            onPressed: () => _pickImage(folderName),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createFolder,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}



