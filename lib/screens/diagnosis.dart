// import 'dart:io'; // For handling image files
// import 'package:flutter/material.dart';
// import 'DetailedDiagnosisScreen.dart';
// import 'chat_screen.dart';
//
// class Diagnosis {
//   final File image;
//   String title;
//   final String predictedClass;
//
//   Diagnosis({required this.image, required this.title, required this.predictedClass});
// }
//
// class DiagnosisScreen extends StatefulWidget {
//   @override
//   _DiagnosisScreenState createState() => _DiagnosisScreenState();
//
//   static List<Diagnosis> diagnoses = [];
//
//   static void addDiagnosis(File image, String predictedClass) {
//     int diagnosisNumber = diagnoses.length + 1;
//     String title = 'Diagnosis $diagnosisNumber';
//     diagnoses.add(Diagnosis(image: image, title: title, predictedClass: predictedClass));
//   }
// }
//
// class _DiagnosisScreenState extends State<DiagnosisScreen> {
//   void _deleteDiagnosis(int index) {
//     setState(() {
//       DiagnosisScreen.diagnoses.removeAt(index);
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Diagnosis deleted'),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }
//
//   void _editTitle(int index) {
//     final diagnosis = DiagnosisScreen.diagnoses[index];
//     TextEditingController titleController = TextEditingController(text: diagnosis.title);
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Edit Title'),
//           content: TextField(
//             controller: titleController,
//             decoration: InputDecoration(hintText: 'Enter new title'),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   diagnosis.title = titleController.text;
//                 });
//                 Navigator.of(context).pop();
//               },
//               child: Text('Save'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Diagnosis'),
//         backgroundColor: Colors.green,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 300,
//             width: double.infinity,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20.0), // Adjust the radius value as needed
//               child: Image.asset(
//                 'lib/images/diagnosis.png', // Placeholder image
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Expanded(
//             child: DiagnosisScreen.diagnoses.isEmpty
//                 ? Center(
//               child: Text(
//                 'No diagnoses available.\n Please upload an image to get started.',
//                 style: TextStyle(fontSize: 18, color: Colors.grey),
//                 textAlign: TextAlign.center,
//               ),
//             )
//                 : ListView.builder(
//               itemCount: DiagnosisScreen.diagnoses.length,
//               itemBuilder: (context, index) {
//                 final reversedIndex = DiagnosisScreen.diagnoses.length - 1 - index;
//                 final diagnosis = DiagnosisScreen.diagnoses[reversedIndex];
//                 return ProblemListItem(
//                   image: diagnosis.image,
//                   title: diagnosis.title, // Use the dynamic title
//                   description: diagnosis.predictedClass, // Display the predicted class
//                   onDelete: () => _deleteDiagnosis(reversedIndex),
//                   onEdit: () => _editTitle(reversedIndex),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DetailedDiagnosisScreen(
//                           predictedClass: diagnosis.predictedClass, // Pass detailed description
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SizedBox(
//               width: double.infinity, // Makes the button take the full width of its parent
//               child: ElevatedButton(
//                 onPressed: () {
//                   _navigateToChatScreen(context); // Navigate to the ChatScreen
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                 ),
//                 child: Text(
//                   'Ask Experts',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Function to navigate to the ChatScreen
//   void _navigateToChatScreen(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ChatScreen()), // Navigate to ChatScreen
//     );
//   }
// }
//
// class ProblemListItem extends StatelessWidget {
//   final File image;
//   final String title;
//   final String description;
//   final VoidCallback onTap;
//   final VoidCallback onDelete;
//   final VoidCallback onEdit;
//
//   const ProblemListItem({
//     required this.image,
//     required this.title,
//     required this.description,
//     required this.onTap,
//     required this.onDelete,
//     required this.onEdit,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(8.0),
//       child: ListTile(
//         leading: ClipRRect(
//           borderRadius: BorderRadius.circular(8.0),
//           child: Image.file(image, width: 50, height: 50, fit: BoxFit.cover),
//         ),
//         title: Text(title),
//         subtitle: Text(description),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             IconButton(
//               icon: Icon(Icons.edit, color: Colors.blue),
//               onPressed: onEdit,
//             ),
//             IconButton(
//               icon: Icon(Icons.delete, color: Colors.red),
//               onPressed: onDelete,
//             ),
//           ],
//         ),
//         onTap: onTap,
//       ),
//     );
//   }
// }



import 'dart:io'; // For handling image files
import 'package:flutter/material.dart';
import 'DetailedDiagnosisScreen.dart';
import 'chat_screen.dart';

class Diagnosis {
  final File image;
  String title;
  final String predictedClass;

  Diagnosis({required this.image, required this.title, required this.predictedClass});
}

class DiagnosisScreen extends StatefulWidget {
  @override
  _DiagnosisScreenState createState() => _DiagnosisScreenState();

  static List<Diagnosis> diagnoses = [];

  static void addDiagnosis(File image, String predictedClass) {
    int diagnosisNumber = diagnoses.length + 1;
    String title = 'Diagnosis $diagnosisNumber';
    diagnoses.add(Diagnosis(image: image, title: title, predictedClass: predictedClass));
  }
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  void _deleteDiagnosis(int index) {
    setState(() {
      DiagnosisScreen.diagnoses.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Diagnosis deleted'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _editTitle(int index) {
    final diagnosis = DiagnosisScreen.diagnoses[index];
    TextEditingController titleController = TextEditingController(text: diagnosis.title);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Title'),
          content: TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Enter new title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  diagnosis.title = titleController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Diagnosis',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Bold text style
            fontSize: 25.0,             // Optional: Adjust font size for better readability
          ),
        ),
        automaticallyImplyLeading: false, // Removes the back button
        centerTitle: true,                // Centers the title
        backgroundColor: Colors.green,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0), // Adjust the radius value as needed
              child: Image.asset(
                'lib/images/diagnosis.png', // Placeholder image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: DiagnosisScreen.diagnoses.isEmpty
                ? Center(
              child: Text(
                'No diagnoses available.\n Please upload an image to get started.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            )
                : ListView.builder(
              itemCount: DiagnosisScreen.diagnoses.length,
              itemBuilder: (context, index) {
                final reversedIndex = DiagnosisScreen.diagnoses.length - 1 - index;
                final diagnosis = DiagnosisScreen.diagnoses[reversedIndex];
                return ProblemListItem(
                  image: diagnosis.image,
                  title: diagnosis.title, // Use the dynamic title
                  description: diagnosis.predictedClass, // Display the predicted class
                  onDelete: () => _deleteDiagnosis(reversedIndex),
                  onEdit: () => _editTitle(reversedIndex),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailedDiagnosisScreen(
                          predictedClass: diagnosis.predictedClass, // Pass detailed description
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToChatScreen(context); // Navigate to the ChatScreen
        },
        backgroundColor: Colors.green,
        child: Image.asset(
          'lib/images/expert_logo.png', // Path to your custom logo
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Function to navigate to the ChatScreen
  void _navigateToChatScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatScreen()), // Navigate to ChatScreen
    );
  }
}

class ProblemListItem extends StatelessWidget {
  final File image;
  final String title;
  final String description;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ProblemListItem({
    required this.image,
    required this.title,
    required this.description,
    required this.onTap,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.file(image, width: 50, height: 50, fit: BoxFit.cover),
        ),
        title: Text(title),
        subtitle: Text(description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

























// import 'dart:io'; // For handling image files
// import 'package:flutter/material.dart';

// class DiagnosisScreen extends StatelessWidget {
//   static File? _image;  // Static variable to hold the image
//   static String? _predictedClass; // Static variable to hold the predicted class

  // Method to set the image and predicted class
  // static void setDiagnosisData(File image, String predictedClass) {
  //   _image = image;
  //   _predictedClass = predictedClass;
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Diagnosis'),
//         backgroundColor: Colors.green,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Display the selected image
//           Container(
//             height: 300,
//             width: double.infinity,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20.0),
//               child: _image != null
//                   ? Image.file(
//                 _image!,
//                 fit: BoxFit.cover,
//               )
//                   : Text('No image selected.'),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'Predicted Disease:', // Show the prediction result
//               style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                 color: Colors.green,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               _predictedClass ?? 'No prediction available', // Show the predicted disease class
//               style: TextStyle(fontSize: 18.0),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


