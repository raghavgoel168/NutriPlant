import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DiagnosisScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnosis'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: 576,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0), // Adjust the radius value as needed
              child: Image.asset(
                'lib/images/3.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Possible Disease Problems',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ProblemListItem(
                  imagePath: 'lib/images/4.jpg',
                  title: 'Problem 1',
                  description: 'Description of problem 1...',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailedProblemScreen(
                          title: 'Problem 1',
                          description: 'Detailed description of problem 1...',
                        ),
                      ),
                    );
                  },
                ),
                ProblemListItem(
                  imagePath: 'lib/images/5.jpg',
                  title: 'Problem 2',
                  description: 'Description of problem 2...',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailedProblemScreen(
                          title: 'Problem 2',
                          description: 'Detailed description of problem 2...',
                        ),
                      ),
                    );
                  },
                ),
                ProblemListItem(
                  imagePath: 'lib/images/6.JPG',
                  title: 'Problem 3',
                  description: 'Description of problem 3...',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailedProblemScreen(
                          title: 'Problem 3',
                          description: 'Detailed description of problem 3...',
                        ),
                      ),
                    );
                  },
                ),
                ProblemListItem(
                  imagePath: 'lib/images/5.jpg',
                  title: 'Problem 4',
                  description: 'Description of problem 4...',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailedProblemScreen(
                          title: 'Problem 4',
                          description: 'Detailed description of problem 4...',
                        ),
                      ),
                    );
                  },
                ),
                ProblemListItem(
                  imagePath: 'lib/images/4.jpg',
                  title: 'Problem 5',
                  description: 'Description of problem 5...',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailedProblemScreen(
                          title: 'Problem 5',
                          description: 'Detailed description of problem 5...',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity, // Makes the button take the full width of its parent
              child: ElevatedButton(
                onPressed: () {
                  const link='https://chatbot-nauu6cpaqzab2gcbv2dafp.streamlit.app/';
                  launchUrl(Uri.parse(link),
                    mode: LaunchMode.externalApplication
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text(
                  'Ask Experts',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class ProblemListItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final VoidCallback onTap;

  ProblemListItem({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 100, // Set the desired width
        height: 100, // Set the desired height
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
      title: Text(title),
      subtitle: Text(description),
      onTap: onTap,
    );
  }
}

class DetailedProblemScreen extends StatelessWidget {
  final String title;
  final String description;

  DetailedProblemScreen({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(description),
      ),
    );
  }
}
