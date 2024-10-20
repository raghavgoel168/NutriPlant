import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        backgroundColor: Colors.green[400],
      ),
      body: Center(
        child: Text('Account Screen Content'),
      ),
    );
  }
}
