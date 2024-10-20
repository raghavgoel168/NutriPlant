import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../disease_data.dart';

// class DetailedDiagnosisScreen extends StatelessWidget {
//   final String predictedClass;
//
//   DetailedDiagnosisScreen({required this.predictedClass});
//
//   @override
//   Widget build(BuildContext context) {
//     // Fetch details for the predicted class
//     Map<String, dynamic>? details = diseaseDetails[predictedClass];
//     String description = details?['description'] ?? 'No details available.';
//     List<String> characteristics = List<String>.from(details?['characteristics'] ?? []);
//     List<String> conditions = List<String>.from(details?['conditions'] ?? []);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detailed Diagnosis', style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.green,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Diagnosis: ${predictedClass.replaceAll('_', ' ')}',
//                 style: GoogleFonts.lato(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green.shade900,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Description',
//                 style: GoogleFonts.lato(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green.shade700,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 description,
//                 style: GoogleFonts.lato(
//                   fontSize: 18,
//                   color: Colors.black87,
//                   height: 1.5,
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // Using _buildSection for Characteristics
//               if (characteristics.isNotEmpty)
//                 _buildSection(title: 'Characteristics', items: characteristics),
//
//               SizedBox(height: 20),
//
//               // Using _buildSection for Ideal Growing Conditions
//               if (conditions.isNotEmpty)
//                 _buildSection(title: 'Ideal Growing Conditions', items: conditions),
//
//               SizedBox(height: 20),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Optionally add a function to set reminders or navigate elsewhere.
//                   },
//                   child: Text('Learn More / Set Reminder'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // The reusable section-building widget
//   Widget _buildSection({required String title, List<String>? items}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 20.0,
//             fontWeight: FontWeight.bold,
//             color: Colors.green[700],
//           ),
//         ),
//         SizedBox(height: 8.0),
//         if (items != null) ...items.map((item) => Text(
//           '- $item',
//           style: TextStyle(fontSize: 16.0, height: 1.5),
//         )).toList(),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Assuming you moved your disease data to a separate file

class DetailedDiagnosisScreen extends StatelessWidget {
  final String predictedClass;

  DetailedDiagnosisScreen({required this.predictedClass});

  @override
  Widget build(BuildContext context) {
    // Fetch details for the predicted class
    Map<String, dynamic>? details = diseaseDetails[predictedClass];
    String description = details?['description'] ?? 'No details available.';
    List<String> characteristics = List<String>.from(details?['characteristics'] ?? []);
    List<String> conditions = List<String>.from(details?['conditions'] ?? []);
    List<String> maintenance = List<String>.from(details?['maintenance'] ?? []);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detailed Diagnosis', style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Diagnosis: ${predictedClass.replaceAll('_', ' ')}',
                style: GoogleFonts.lato(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                ),
              ),
              SizedBox(height: 20),

              Text(
                'Description',
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20),

              // Characteristics Section
              if (characteristics.isNotEmpty)
                _buildSection(title: 'Characteristics', items: characteristics),
              SizedBox(height: 20),

              // Ideal Growing Conditions Section
              if (conditions.isNotEmpty)
                _buildSection(title: 'Ideal Growing Conditions', items: conditions),
              SizedBox(height: 20),

              // Maintenance Section
              if (maintenance.isNotEmpty)
                _buildSection(title: 'Maintenance Tips', items: maintenance),

              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Optionally add a function to set reminders or navigate elsewhere.
                  },
                  child: Text('Learn More / Set Reminder'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // The reusable section-building widget
  Widget _buildSection({required String title, List<String>? items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.green[700],
          ),
        ),
        SizedBox(height: 8.0),
        if (items != null) ...items.map((item) => Text(
          '- $item',
          style: TextStyle(fontSize: 16.0, height: 1.5),
        )).toList(),
      ],
    );
  }
}


// detailed_diagnosis_screen.dart

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../disease_data.dart'; // Import the file where diseaseDetails is stored
//
// class DetailedDiagnosisScreen extends StatelessWidget {
//   final String predictedClass;
//
//   DetailedDiagnosisScreen({required this.predictedClass});
//
//   @override
//   Widget build(BuildContext context) {
//     // Get the details for the predicted class from the imported diseaseDetails map
//     Map<String, dynamic>? details = diseaseDetails[predictedClass];
//     String description = details?['description'] ?? 'No details available.';
//     List<String> characteristics = List<String>.from(details?['characteristics'] ?? []);
//     List<String> conditions = List<String>.from(details?['conditions'] ?? []);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Detailed Diagnosis',
//           style: GoogleFonts.lato(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.green,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Diagnosis: ${predictedClass.replaceAll('_', ' ')}',
//                 style: GoogleFonts.lato(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green.shade900,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Description',
//                 style: GoogleFonts.lato(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green.shade700,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 description,
//                 style: GoogleFonts.lato(
//                   fontSize: 18,
//                   color: Colors.black87,
//                   height: 1.5,
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               if (characteristics.isNotEmpty) ...[
//                 Text(
//                   'Characteristics',
//                   style: GoogleFonts.lato(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green.shade700,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 for (var characteristic in characteristics)
//                   Text(
//                     '- $characteristic',
//                     style: GoogleFonts.lato(
//                       fontSize: 18,
//                       color: Colors.black87,
//                       height: 1.5,
//                     ),
//                   ),
//                 SizedBox(height: 20),
//               ],
//
//               if (conditions.isNotEmpty) ...[
//                 Text(
//                   'Ideal Growing Conditions',
//                   style: GoogleFonts.lato(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green.shade700,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 for (var condition in conditions)
//                   Text(
//                     '- $condition',
//                     style: GoogleFonts.lato(
//                       fontSize: 18,
//                       color: Colors.black87,
//                       height: 1.5,
//                     ),
//                   ),
//                 SizedBox(height: 20),
//               ],
//
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Optionally add a function to set reminders or navigate elsewhere.
//                   },
//                   child: Text('Learn More / Set Reminder'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

