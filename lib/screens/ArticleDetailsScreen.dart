import 'package:flutter/material.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final String title;
  final String image;
  final String content;

  ArticleDetailsScreen({
    required this.title,
    required this.image,
    required this.content, required Map article,
  });

  // Method to parse content and format bold text
  List<TextSpan> _parseContent(String content) {
    final regex = RegExp(r'\*\*(.*?)\*\*');
    List<TextSpan> textSpans = [];
    int lastIndex = 0;

    // Find all matches of bold text
    for (final match in regex.allMatches(content)) {
      if (match.start > lastIndex) {
        textSpans.add(TextSpan(
          text: content.substring(lastIndex, match.start),
          style: TextStyle(fontSize: 16.0, height: 1.8, color: Colors.black),
        ));
      }
      textSpans.add(TextSpan(
        text: match.group(1), // The bold text
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
      ));
      lastIndex = match.end;
    }

    // Add the remaining content after the last match
    if (lastIndex < content.length) {
      textSpans.add(TextSpan(
        text: content.substring(lastIndex),
        style: TextStyle(fontSize: 16.0, height: 1.8, color: Colors.black),
      ));
    }

    return textSpans;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue[400],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://st.depositphotos.com/55493816/59286/i/380/depositphotos_592860642-stock-photo-background-graphics-light-purple-white.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Article image with rounded corners
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                SizedBox(height: 16.0),

                // Article title with a larger font size and bold styling
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 16.0),

                // Article content with parsed bold text
                RichText(
                  text: TextSpan(
                    children: _parseContent(content),
                  ),
                ),
                SizedBox(height: 20.0),

                // Adding a section for related articles or tips
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Related Tips:',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• Choose the right succulents for your space.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        '• Learn about different types of soil and containers.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        '• Keep an eye on light and temperature conditions.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
