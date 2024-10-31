import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../disease_data.dart';

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
      body: Container(
        constraints: BoxConstraints.expand(),  // Ensures the background covers the full screen
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/background_leaves.jpg'), // Replace with your image asset
            fit: BoxFit.cover,  // Ensures the image covers the full screen
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
          ),
        ),
        child: Padding(
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
                    color: Colors.yellow,
                  ),
                ),
                SizedBox(height: 20),

                Text(
                  'Description',
                  style: GoogleFonts.lato(
                    fontSize: 24,  // Increased font size for large text
                    fontWeight: FontWeight.bold,  // Bold text
                    color: Colors.orange,  // Dark brown color (Hex code for dark brown)
                  ),
                ),

                SizedBox(height: 8),
                Text(
                  description,
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
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
            color: Colors.orange,
          ),
        ),
        SizedBox(height: 8.0),
        if (items != null) ...items.map((item) => Text(
          '- $item',
          style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.white.withOpacity(0.9)),
        )).toList(),
      ],
    );
  }
}
