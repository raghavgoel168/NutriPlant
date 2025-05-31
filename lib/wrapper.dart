import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutri_plant/screens/splash_screen.dart';
import 'package:nutri_plant/screens/authentication_screens/verifyEmail.dart';
import 'package:nutri_plant/screens/authentication_screens/sign_up_login_screen.dart';
import 'package:nutri_plant/screens/home_screen.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool _showSplashScreen = true;

  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  void _startSplashScreen() {
    Timer(Duration(seconds: 3), () { // Adjust the duration as needed
      setState(() {
        _showSplashScreen = false;
      });
    });
  }

  void _navigateToScreen(Widget screen) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplashScreen) {
      return SplashScreen();
    } else {
      return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;

            if (user != null) {
              if (!user.emailVerified) {
                _navigateToScreen(VerifyEmailScreen()); // Navigate without back button issue
              } else {
                _navigateToScreen(HomeScreen()); // Navigate without back button issue
              }
            } else {
              _navigateToScreen(SignUpLoginScreen()); // Navigate without back button issue
            }
            return Container(); // Return an empty container temporarily
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      );
    }
  }
}
