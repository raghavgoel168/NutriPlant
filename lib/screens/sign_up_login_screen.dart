import 'package:flutter/material.dart';

class SignUpLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 25),
            Icon(
              Icons.eco,
              size: 80.0,
              color: Colors.green,
            ),
            SizedBox(height: 30),
            Text(
              "Let's Get Started!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Let's dive into your account",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 50),
            SocialLoginButton(
              text: 'Continue with Google',
              icon: Icons.g_translate,
              onPressed: () {
                // Handle Google login
              },
            ),
            SocialLoginButton(
              text: 'Continue with Apple',
              icon: Icons.apple,
              onPressed: () {
                // Handle Apple login
              },
            ),
            SocialLoginButton(
              text: 'Continue with Facebook',
              icon: Icons.facebook,
              onPressed: () {
                // Handle Twitter login
              },
            ),
            SizedBox(height: 60),
            SizedBox(
              width: 355.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('Sign up'),
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              width: 355.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Log in'),
              ),
            ),
            SizedBox(height: 80),
            Text(
              'Privacy Policy · Terms of Service',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  SocialLoginButton({required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: 355.0, // Adjust this value to set the width of the button
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.white),
          label: Text(text),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            minimumSize: Size(double.infinity, 50), // Maintain minimum height
          ),
        ),
      ),
    );
  }
}
