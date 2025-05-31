import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class VerifyEmailScreen extends StatefulWidget {
  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  Timer? _timer;
  bool _emailSent = false;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;

    _checkEmailSentStatus();

    if (_user != null && !_user!.emailVerified && !_emailSent) {
      _user?.sendEmailVerification();
      _setEmailSentStatus(true);
    }

    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      await _user?.reload();
      if (_auth.currentUser?.emailVerified ?? false) {
        timer.cancel();
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  Future<void> _checkEmailSentStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailSent = prefs.getBool('emailSent') ?? false;
    });
  }

  Future<void> _setEmailSentStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('emailSent', status);
    setState(() {
      _emailSent = status;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Email'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.email_outlined,
                size: 100,
                color: Colors.green,
              ),
              SizedBox(height: 30),
              Text(
                'A verification email has been sent to',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${_user?.email}.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Please check your inbox to verify.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Once verified, you’ll be redirected to the \n",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    TextSpan(
                      text: "Home Screen",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade500,
                      ),
                    ),
                    TextSpan(
                      text: ".",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  if (!_emailSent) {
                    await _user?.sendEmailVerification();
                    _setEmailSentStatus(true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow.shade800,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Resend Verification Email',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  _auth.signOut();
                  Navigator.pushReplacementNamed(context, '/sign_up_login');
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.green,
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
