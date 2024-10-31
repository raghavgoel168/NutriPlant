// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../widgets/plantDetailsScreen_widget.dart';
//
// class PlantCategoryScreen extends StatelessWidget {
//   final String categoryName;
//   final List<Map<String, String>> plants;
//
//   PlantCategoryScreen({required this.categoryName, required this.plants});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(categoryName),
//         backgroundColor: Colors.green[400],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.builder(
//           padding: const EdgeInsets.only(top: 10),
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2, // 2 items per row
//             childAspectRatio: 1.2, // Adjust the ratio as needed
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//           ),
//           itemCount: plants.length,
//           itemBuilder: (context, index) {
//             return InkWell(
//               onTap: () {
//                 // Navigate to PlantDetailsScreen when a plant is tapped
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => PlantDetailsScreen(
//                       name: plants[index]['name']!,
//                       image: plants[index]['image']!,
//                       description: plants[index]['description'] ?? 'No description available.', // Add description
//                     ),
//                   ),
//                 );
//               },
//               child: _buildPlantCard(plants[index]),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPlantCard(Map<String, String> plant) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.green[100],
//         borderRadius: BorderRadius.circular(10.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             child: ClipRRect(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
//               child: Image.network(
//                 plant['image']!,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               plant['name']!,
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/plantDetailsScreen_widget.dart';

class PlantCategoryScreen extends StatelessWidget {
  final String categoryName;
  final List<Map<String, String>> plants;

  PlantCategoryScreen({required this.categoryName, required this.plants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: Colors.green[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          padding: const EdgeInsets.only(top: 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            childAspectRatio: 1.0, // Adjust the ratio as needed
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: plants.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // Navigate to PlantDetailsScreen when a plant is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlantDetailsScreen(
                      name: plants[index]['name']!,
                      image: plants[index]['image']!,
                      description: plants[index]['description'] ?? 'No description available.', // Add description
                    ),
                  ),
                );
              },
              child: _buildPlantCard(plants[index]),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlantCard(Map<String, String> plant) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.green[100],
        shape: BoxShape.circle,
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
            child: ClipOval(
              child: Image.network(
                plant['image']!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              plant['name']!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
