import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nutri_plant/screens/authentication_screens/sign_up_login_screen.dart'; // Import your login screen

class AccountScreen extends StatelessWidget {
  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // Navigate to the SignUpLoginScreen after signing out
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignUpLoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Makes the text bold
            fontSize: 25.0,             // Optional: Adjust the font size
          ),
        ),
        centerTitle: true,              // Centers the title
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green[400],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => signOut(context), // Pass context to the signOut method
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Red color for sign-out button
          ),
          child: Text('Sign Out'),
        ),
      ),
    );
  }
}
