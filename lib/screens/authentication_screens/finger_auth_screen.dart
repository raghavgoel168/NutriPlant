import 'package:flutter/material.dart';
import 'fingerAuth.dart'; // Import your FingerAuth class
import 'package:nutri_plant/wrapper.dart'; // Import the Wrapper

class FingerAuthScreen extends StatefulWidget {
  @override
  _FingerAuthScreenState createState() => _FingerAuthScreenState();
}

class _FingerAuthScreenState extends State<FingerAuthScreen> {
  final FingerAuth fingerAuth = FingerAuth();
  bool _isAuthenticating = false;

  void _authenticate() async {
    setState(() {
      _isAuthenticating = true;
    });

    bool authenticated = await fingerAuth.authenticate(context);

    if (authenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Wrapper()),
      );
    } else {
      setState(() {
        _isAuthenticating = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authentication failed!')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fingerprint Authentication'),
      ),
      body: Center(
        child: _isAuthenticating
            ? CircularProgressIndicator()
            : Text('Touch the fingerprint sensor to authenticate'),
      ),
    );
  }
}
