import 'dart:convert'; // For JSON decoding
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'DetailedDiagnosisScreen.dart';
import 'diagnosis.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image;
  String _uploadMessage = ''; // Variable to hold upload status message
  String? _predictedClass; // Variable to hold predicted class

  // Method to pick image (either from camera or gallery)
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    // Show a dialog to select from gallery or camera
    final pickedSource = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Choose Image Source', style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.green),
              title: Text('Camera', style: GoogleFonts.lato(color: Colors.green)),
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.photo_album, color: Colors.green),
              title: Text('Gallery', style: GoogleFonts.lato(color: Colors.green)),
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    // If a source was selected, pick the image
    if (pickedSource != null) {
      final pickedFile = await picker.pickImage(source: pickedSource);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          _uploadMessage = ''; // Reset the message when picking a new image
          _predictedClass = null; // Reset the prediction when picking a new image
        });
      }
    }
  }

  // Method to upload image to Flask API
  Future<void> _uploadImage() async {
    if (_image == null) {
      _showMessage('No image selected');
      return;
    }

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.29.24:5000/upload'), // Use your Flask API URL
    );

    // Attach the image file to the request
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

    // Send the request and get the response
    final response = await request.send();

    if (response.statusCode == 200) {
      // Decode the response body to get the prediction result
      final responseData = await http.Response.fromStream(response);
      final responseJson = jsonDecode(responseData.body);
      final predictedClass = responseJson['predicted_class'];

      setState(() {
        _predictedClass = predictedClass; // Store the prediction
        _uploadMessage = 'Prediction: $predictedClass'; // Update the message
      });

      // Store the data in DiagnosisScreen
      DiagnosisScreen.addDiagnosis(_image!, _predictedClass!);
    } else {
      _showMessage('Failed to upload image');
    }
  }

  // Method to show a Snackbar message
  void _showMessage(String message) {
    setState(() {
      _uploadMessage = message; // Update the upload status message
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.lato()),
        duration: Duration(seconds: 3), // Controls how long the message will be visible
      ),
    );
  }

  // Method to navigate to the DetailedDiagnosisScreen
  void _navigateToDiagnosis() {
    if (_image != null && _predictedClass != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailedDiagnosisScreen(
            predictedClass: _predictedClass!, // Passing the predicted class
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upload Image',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold, // Bold text style
            fontSize: 25.0,             // Optional: Adjust font size for better readability
          ),
        ),
        automaticallyImplyLeading: false, // Removes the back button
        centerTitle: true,                // Centers the title
        backgroundColor: Colors.green,    // Nature-inspired color
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white70, Colors.green.shade300], // Nature-inspired background
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _image != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _image!,
                    width: 315,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                )
                    : Text(
                  'No image selected.',
                  style: GoogleFonts.lato(fontSize: 18, color: Colors.green),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text(
                    'Pick Image (Camera or Gallery)',
                    style: GoogleFonts.lato(fontSize: 16, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700, // Darker green for button
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _uploadImage,
                  child: Text(
                    'Upload Image',
                    style: GoogleFonts.lato(fontSize: 16, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade900, // Darker green for button
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Display upload message or prediction result
                Text(
                  _uploadMessage,
                  style: GoogleFonts.lato(fontSize: 16, color: Colors.green.shade800, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                // Show "View Diagnosis" button if there's a prediction
                if (_predictedClass != null)
                  ElevatedButton(
                    onPressed: _navigateToDiagnosis,
                    child: Text(
                      'View Diagnosis',
                      style: GoogleFonts.lato(fontSize: 16, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade800, // Darker green for button
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Rounded corners
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

