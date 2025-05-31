import 'package:flutter/material.dart';
import 'package:nutri_plant/screens/plant_list_screen.dart';
import 'package:nutri_plant/screens/set_notification.dart';

import '../plant_data.dart';
import '../widgets/article_card.dart';
import '../widgets/plant_category_card.dart';
import 'ArticleDetailsScreen.dart';
import 'article_list_screen.dart';
import 'cart_screen.dart';
import '../article_data.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NutriPlant'),
        backgroundColor: Colors.green[400],
        automaticallyImplyLeading: false, // Removes the back button
        actions: [
          IconButton(
            icon: Icon(Icons.notification_add_rounded),
            onPressed: () {
              Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => SetNotification())
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ],
      ),
      body: buildBodyContent(context),
    );
  }

  Widget buildBodyContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchField(),
            SizedBox(height: 20),
            _buildExplorePlantsSection(context),
            SizedBox(height: 20),
            _buildPopularArticlesSection(context),
          ],
        ),
      ),
    );
  }

  // Example methods for building sections, replace with your actual implementations
  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search plants...',
        prefixIcon: Icon(Icons.search),
        filled: true,
        fillColor: Colors.green[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      ),
    );
  }

  Widget _buildExplorePlantsSection(BuildContext context) {

    // Limit display to 4 categories
    final displayedCategories = categories.sublist(0, 4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Explore Plants',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PlantListScreen(categories: categories),
                  ),
                );
              },
              child: Text(
                'View All',
                style: TextStyle(color: Colors.green[700]),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 345, // Adjusted height
          child: GridView.builder(
            padding: const EdgeInsets.only(top: 10),
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items per row
              childAspectRatio: 1.2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: displayedCategories.length,
            itemBuilder: (context, index) {
              return buildPlantCategoryCard(
                  context, displayedCategories[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopularArticlesSection(BuildContext context) {
    final displayedArticles = articles.sublist(0, 5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Popular Articles',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleListScreen(articles: articles),
                  ),
                );
              },
              child: Text(
                'View All',
                style: TextStyle(color: Colors.green[700]),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: displayedArticles.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArticleDetailsScreen(
                        title: displayedArticles[index]['title']!,
                        image: displayedArticles[index]['image']!,
                        content: displayedArticles[index]['content']!,
                      ),
                    ),
                  );
                },
                child: buildArticleCard(context, displayedArticles[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}