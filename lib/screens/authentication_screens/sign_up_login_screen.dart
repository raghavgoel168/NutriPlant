import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpLoginScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Function to handle Google Sign-In
  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // The user canceled the sign-in

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      // Navigate to Home screen upon successful login
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In failed: $e')),
      );
    }
  }

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
              onPressed: () => _signInWithGoogle(context), // Use Google sign-in function
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
                // Handle Facebook login
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
        width: 355.0,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.white),
          label: Text(text),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            minimumSize: Size(double.infinity, 50),
          ),
        ),
      ),
    );
  }
}
