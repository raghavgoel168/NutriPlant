import 'package:flutter/material.dart';
import '../screens/plant_category_screen.dart';

Widget buildPlantCategoryCard(BuildContext context, Map<String, String> category) {
  // Define the list of plants based on the category selected
  List<Map<String, String>> plants = _getPlantsForCategory(category['name']!);

  return InkWell(
    onTap: () {
      // Navigate to the PlantCategoryScreen and pass the category name and plants list
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlantCategoryScreen(
            categoryName: category['name']!, // Pass the selected category name
            plants: plants, // Pass the list of plants associated with the category
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
          // Display the category image
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
          // Display the category name
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

// Helper function to return a list of plants for the selected category
List<Map<String, String>> _getPlantsForCategory(String categoryName) {
  switch (categoryName) {
    case 'Succulents & Cacti':
      return [
        {
          'name': 'Aloe Vera',
          'image': 'https://m.media-amazon.com/images/I/61vM5XmrW2L._AC_UF1000,1000_QL80_.jpg',
          'description': 'Aloe Vera is a succulent plant species known for its medicinal properties.',
        },
        {
          'name': 'Cactus',
          'image': 'https://www.juneflowers.com/wp-content/uploads/2022/08/Cactus-Plant.jpg',
          'description': 'Cacti are resilient desert plants that require minimal water.',
        },
      ];
    case 'Foliage Plants':
      return [
        {
          'name': 'Fern',
          'image': 'https://peppyflora.com/wp-content/uploads/2021/07/Tree-Fern-3x4-Product-Peppyflora-01-b-Moz.jpg',
          'description': 'Ferns are shade-loving plants with delicate leaves.',
        },
        {
          'name': 'Monstera',
          'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyBkFKUToyN-pMnlx66Oyz6XtowV_FAD-EiA&s',
          'description': 'Monstera plants are famous for their large, split leaves.',
        },
      ];
    case 'Flowering Plants':
      return [
        {
          'name': 'Rose',
          'image': 'https://images.pexels.com/photos/15239/flower-roses-red-roses-bloom.jpg?cs=srgb&dl=pexels-pixabay-15239.jpg&fm=jpg',
          'description': 'Roses are fragrant flowering plants known for their beauty.',
        },
        {
          'name': 'Tulip',
          'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ925uNjWUHdvY2RTlv9a67wOCrRK8BX5sCMQ&s',
          'description': 'Tulips are vibrant, seasonal flowers that bloom in spring.',
        },
      ];
    case 'Trees':
      return [
        {
          'name': 'Oak',
          'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyiNKS0uJqM6w-ELtsgGNMoRBeZxLpWLcXJA&s',
          'description': 'Oak trees are large, strong trees that live for hundreds of years.',
        },
        {
          'name': 'Pine',
          'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPue2pP5gWEd_aSJzq4-4Z2LDe17MyhInaUw&s',
          'description': 'Pine trees are evergreens known for their needle-like leaves.',
        },
      ];
    case 'Weeds & Shrubs':
      return [
        {
          'name': 'Dandelion',
          'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/DandelionFlower.jpg/1200px-DandelionFlower.jpg',
          'description': 'Dandelions are common weeds known for their bright yellow flowers.',
        },
        {
          'name': 'Blackberry Bush',
          'image': 'https://gardenerspath.com/wp-content/uploads/2023/04/How-to-Grow-Blackberries-Featured.jpg',
          'description': 'Blackberry bushes are thorny shrubs that produce edible berries.',
        },
      ];
    case 'Fruits':
      return [
        {
          'name': 'Apple',
          'image': 'https://cdn.britannica.com/22/187222-050-07B17FB6/apples-on-a-tree-branch.jpg',
          'description': 'Apple trees produce sweet, edible fruits and are grown worldwide.',
        },
        {
          'name': 'Strawberry',
          'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhY7E3c4qF3h4W42xBZ1B7lt__0gDcqeZrVwOT5_fSbM-E1jArLNmx7IdzqW9edqBdNkE&usqp=CAU',
          'description': 'Strawberries are popular fruits with a sweet flavor and red color.',
        },
      ];
    case 'Vegetables':
      return [
        {
          'name': 'Carrot',
          'image': 'https://m.media-amazon.com/images/I/71S6oQqVa5L.jpg',
          'description': 'Carrots are root vegetables that are typically orange in color.',
        },
        {
          'name': 'Tomato',
          'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/Tomato_je.jpg/1200px-Tomato_je.jpg',
          'description': 'Tomatoes are juicy fruits commonly used in cooking and salads.',
        },
      ];
    case 'Herbs':
      return [
        {
          'name': 'Basil',
          'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-Yw3l0E-ue9SPWE_OIrCF6u4XIzyaUDFjFQ&s',
          'description': 'Basil is a fragrant herb commonly used in Italian and Asian cuisine.',
        },
        {
          'name': 'Mint',
          'image': 'https://www.ugaoo.com/cdn/shop/articles/82b18b332c.jpg?v=1724319641',
          'description': 'Mint is a refreshing herb known for its aromatic leaves.',
        },
      ];
    case 'Mushrooms':
      return [
        {
          'name': 'Shiitake',
          'image': 'https://www.stylecraze.com/wp-content/uploads/2022/03/Shiitake-Mushrooms-Nutritional-Information-Benefits-And-Side-Effects.jpg',
          'description': 'Shiitake mushrooms are popular in Asian cuisine and have a rich, earthy flavor.',
        },
        {
          'name': 'Portobello',
          'image': 'https://shroomery.in/cdn/shop/products/DSC03715_1981x.jpg?v=1646163005',
          'description': 'Portobello mushrooms are large, meaty mushrooms often used as a meat substitute.',
        },
      ];
    case 'Toxic Plants':
      return [
        {
          'name': 'Oleander',
          'image': 'https://vajiram-prod.s3.ap-south-1.amazonaws.com/Oleander_a66b47fb37.webp',
          'description': 'Oleander is a beautiful but highly toxic plant with pink or white flowers.',
        },
        {
          'name': 'Belladonna',
          'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbIVOTfJb5RS2r_rHjhrUUDHVVtU0AjKP4_g&s',
          'description': 'Also known as deadly nightshade, belladonna is a highly poisonous plant.',
        },
      ];
    default:
      return [];
  }
}
