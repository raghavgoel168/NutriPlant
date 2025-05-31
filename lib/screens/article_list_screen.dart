import 'package:flutter/material.dart';
import 'ArticleDetailsScreen.dart';

class ArticleListScreen extends StatelessWidget {
  final List<Map<String, String>> articles;

  ArticleListScreen({required this.articles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Articles'),
        backgroundColor: Colors.blue[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          padding: const EdgeInsets.only(top: 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            childAspectRatio: 1.2, // Adjust the ratio as needed
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // Navigate to ArticleDetailsScreen when an article is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleDetailsScreen(
                      title: articles[index]['title']!,
                      image: articles[index]['image']!,
                      content: articles[index]['content'] ?? 'No content available.',
                    ),
                  ),
                );
              },
              child: _buildArticleCard(articles[index]),
            );
          },
        ),
      ),
    );
  }

  Widget _buildArticleCard(Map<String, String> article) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[100],
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
                article['image']!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              article['title']!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
