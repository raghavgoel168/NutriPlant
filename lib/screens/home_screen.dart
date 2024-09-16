import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'diagnosis.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NutriPlant',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[400],
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchField(),
              SizedBox(height: 20),
              _buildExplorePlantsSection(),
              SizedBox(height: 20),
              _buildPopularArticlesSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Handle navigation based on the index
          switch (index) {
            case 0:
            // Navigate to Home
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DiagnosisScreen()),
              );
              break;
            case 2:
              _launchURL('https://7350-14-97-132-203.ngrok-free.app/');
              break;
            case 3:
            // Navigate to My Plants
              break;
            case 4:
            // Navigate to Account
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Diagnose',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: 'My Plants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        selectedItemColor: Colors.green[700],
        unselectedItemColor: Colors.grey,
      ),
    );
  }

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

  Widget _buildExplorePlantsSection() {
    final categories = [
      {'name': 'Succulents & Cacti', 'image': 'https://s3-alpha-sig.figma.com/img/be6f/9fe6/91042f5a10e8a333e982fb090b719ba2?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=BZ2T38ANd3b-A2F4-8YWXuETrDUJ2nu2hHFMIzE6cT01qBkxretWP02r-45YeC5VsCeexY1SH5~iszqJLXXabmzD6nWe30EwYod-PTiyolzPA9-BkLU1nUBEX1ANUipQOBjXhaOuFQid7oLt~fk0QsanL7f0ArJocWEaAyIpvmffnMixHO3t0K~rlwoqqnMfrgR~EztDu0iBmz8bRtVQyO5zqVYvctiAL9A7wPot1415pcLlgzTCIncC7gTISqGfnZclI9DRlvpA4JfhNSnb9UZ4xEgqEazpmH948KiJ3rTEPwIK0L2G7DO-ECUEWMKPwud1lJPiOTrUXCK4nW8koQ__'},
      {'name': 'Foliage Plants', 'image': 'https://s3-alpha-sig.figma.com/img/bdbc/f2f0/ba99a2e2c03810b547ce9810ea92c19e?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=gX4LW46IXHhqCTvaUdKwY8y66mJ2iQ5E1eC4zIoW0VUxOYJddEZKhstpoRK3vkdYdYm5il~2f3Zo6ST91tR-1V5iScztXgfhug78A5LBbkc9Uu4ym9P0E0xdb04TLylERkvg8zZ7MFADIMyO4dY1GLPMZZXAVJqRhz19Tppw0GeB1cnSBlm-D0ACXXIQ0cJ2mv6M8sLbKAn1T8t48f47kDj06jblkfcH7TIZTeeGF38g3qJr4xrHwtMDRLHfjLBjY2KtmslUd6vgL1eM96O4dj1hTIqOLMrIoAHTZG~SAZWzafV46xANVUvXU6wNSNAr0w3cG08m6MOcw9PtDPsuBA__'},
      {'name': 'Flowering Plants', 'image': 'https://s3-alpha-sig.figma.com/img/20d1/817f/92aa5b286edb2625851e369e1b695bb6?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=YCazIojNNM8VGhunKFV-wx01XYZRQvBYbVOoPLu2QsDxa2ADNB0zhnmGy8tuM1CkuXkuA7dOYQkYC9mAuyg4RhjP7XqdhJGB3RZOPzxxmf8H6YQJtWsRhEd0b3Wa9ZcWB5XqFHl1WhJYVnUGIFM6YeULpDdYkKTjW0HsvPVmES1R7zhur2-QN1Ai8NJkZkcKzXaQ-PU8FDCeJK6c4djIQ~BYjNTWO2uNtVMmdaKta1cnafIh8xsoPuzGF3gy-jlY7UkZKz4PrIuN1XSGWw4mDOvwZbBJKGqtIbefhk~8TihvyV06wjky7v6s6IZ-wBMsXyzNVFDwxbL39jNIg4CtGQ__'},
      {'name': 'Trees', 'image': 'https://s3-alpha-sig.figma.com/img/8807/527b/45646f95fa945bf3c6228e2216f508b8?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=G2x1axUqW5EJY1iqtPHviflnu3WxL0nka66~QZD1qDmlVVISt0IqMya6107Otwn0v~vH27IswrYhV03aZk3C90HX1N-HnCz7dhyrgrc7yVctaH-qLN1hj4SuqiDVlVvjXhVnsaYVFXov2yGuxQPtDUV2vZ8P~sWoMmzNuJ77qAiL2cZK86JrDzirFaNPjoJH~MhCmiAmP7OEc9IxVdVzbwPlkkVVeqa932-2b2IWvTA9EoMThaAoVgJ8lrzaTQLeYShtMH3Dl2NFk6bJbG9uIBnJspkUwoF0QigeQQk-95dQFWh~Keb97goMoELJWA3DZmx4CQvvzHn6poBBXYImKA__'},
      {'name': 'Weeds & Shrubs', 'image': 'https://example.com/images/weeds.jpg'},
      {'name': 'Vegetables', 'image': 'https://example.com/images/vegetables.jpg'},
      {'name': 'Herbs', 'image': 'https://example.com/images/herbs.jpg'},
      {'name': 'Mushrooms', 'image': 'https://example.com/images/mushrooms.jpg'},
      {'name': 'Toxic Plants', 'image': 'https://example.com/images/toxic.jpg'},
    ];

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
              onPressed: () {},
              child: Text(
                'View All',
                style: TextStyle(color: Colors.green[700]),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 335, // Reduced height for a grid view
          child: GridView.builder(
            padding: const EdgeInsets.only(top: 10),
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items per row
              childAspectRatio: 1.2, // Adjusted aspect ratio to make cards shorter
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return _buildCategoryCard(categories[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopularArticlesSection() {
    final articles = [
      {'title': 'Unlock the Secrets of Succulents', 'image': 'https://www.marthastewart.com/thmb/1r0K4i4pVGdqQDqZ_bJ36BIg0YI=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/plants-look-beautiful-when-not-blooming-coleus-lead-getty-0623-c6efce0847fc421fab5f394fe02cda51.jpg'},
      {'title': 'Indoor Plants: Care Tips', 'image': 'https://media.hswstatic.com/eyJidWNrZXQiOiJjb250ZW50Lmhzd3N0YXRpYy5jb20iLCJrZXkiOiJnaWZcL3BsYXlcL2M2ZGYwY2E2LWY1YTAtNDAwMS1hZjM2LWE1MTFkZmVjOWE1MS0xMjEwLTY4MC5qcGciLCJlZGl0cyI6eyJyZXNpemUiOnsid2lkdGgiOiIxMjAwIn19fQ=='},
      {'title': 'The Best Houseplants for Clean Air', 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRt6dERq1DrjKHNxKURrBlowGO0PO44WQ8YHA&s'},
      {'title': 'How to Grow Your Own Herbs', 'image': 'https://media.wired.com/photos/5d8aab8bef84070009028d31/master/pass/Plant-Music-1162975190.jpg'},
      {'title': 'Top 10 Gardening Tips', 'image': 'https://gardenerspath.com/wp-content/uploads/2023/07/Get-Started-Gardening-Feature.jpg'},
    ];

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
              onPressed: () {},
              child: Text(
                'View All',
                style: TextStyle(color: Colors.green[700]),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 140, // Increased height for larger article cards
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return _buildArticleCard(articles[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(Map<String, String> category) {
    return Container(
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
    );
  }

  Widget _buildArticleCard(Map<String, String> article) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 200, // Adjusted width for larger article cards
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
      ),
    );
  }
}
