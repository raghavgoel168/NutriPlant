import 'package:flutter/material.dart';

class PlantDetailsScreen extends StatelessWidget {
  final String name;
  final String image;
  final String description;

  PlantDetailsScreen({
    required this.name,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.green[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
            ),
            SizedBox(height: 20),
            Text(
              name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                // Logic for adding to cart
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('$name added to cart!'),
                ));
              },
              icon: Icon(Icons.shopping_cart),
              label: Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[400], // Background color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
