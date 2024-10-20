import 'package:flutter/material.dart';
import 'package:nutri_plant/screens/plant_list_screen.dart';

Widget buildCategoryCard(BuildContext context, Map<String, String> category) {
  List<Map<String, String>> plants = [];

  switch (category['name']) {
    case 'Succulents & Cacti':
      plants = [
        {
          'name': 'Aloe Vera',
          'image': 'https://example.com/images/aloe.jpg',
          'description': 'Aloe Vera is a succulent plant species known for its medicinal properties.',
        },
        {
          'name': 'Cactus',
          'image': 'https://example.com/images/cactus.jpg',
          'description': 'Cacti are resilient desert plants that require minimal water.',
        },
      ];
      break;
    case 'Foliage Plants':
      plants = [
        {'name': 'Fern', 'image': 'https://example.com/images/fern.jpg'},
        {'name': 'Monstera', 'image': 'https://example.com/images/monstera.jpg'},
      ];
      break;
    case 'Flowering Plants':
      plants = [
        {'name': 'Rose', 'image': 'https://example.com/images/rose.jpg'},
        {'name': 'Tulip', 'image': 'https://example.com/images/tulip.jpg'},
      ];
      break;
    case 'Trees':
      plants = [
        {'name': 'Oak', 'image': 'https://example.com/images/oak.jpg'},
        {'name': 'Pine', 'image': 'https://example.com/images/pine.jpg'},
      ];
      break;
    case 'Herbs':
      plants = [
        {'name': 'Basil', 'image': 'https://example.com/images/basil.jpg'},
        {'name': 'Mint', 'image': 'https://example.com/images/mint.jpg'},
      ];
      break;
  }

  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlantListScreen(
            categories: plants, // Pass the plants list associated with the category
          ),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.network(
                category['image']!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              category['name']!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    ),
  );
}
