import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text('Your cart is empty!', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
