import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Text(
                'NutriPlant',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              Container(
                width: 150,
                height: 150,
                color: Colors.white, // Placeholder for the square image area
                child: Image.asset(
                  'lib/images/logo.png', // Path to your image
                  fit: BoxFit.cover, // Adjusts the image to cover the container
                ),
              ),

              SizedBox(height: 50),
              Text(
                'Select Your Language',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                items: <String>[
                  'English',
                  'Hindi',
                  'Bangla',
                  'Urdu',
                  'Japanese'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Add your language selection logic here
                },
                hint: Text('Select a Language'),
              ),
              SizedBox(height: 10),
              Text(
                'English  Hindi  Bangla  Urdu  Japanese',
                style: TextStyle(fontSize: 15.0, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 80),
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: _isButtonPressed ? 220.0 : 240.0, // Button size change on press
                height: _isButtonPressed ? 60.0 : 70.0,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isButtonPressed = !_isButtonPressed; // Toggle button press state
                    });
                    // Perform the navigation after a small delay
                    Future.delayed(Duration(milliseconds: 100), () {
                      Navigator.pushNamed(context, '/onboarding');
                    });
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
