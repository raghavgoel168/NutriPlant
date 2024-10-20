import 'package:flutter/material.dart';
import 'package:nutri_plant/screens/plant_list_screen.dart';

import '../widgets/article_card.dart';
import '../widgets/category_card.dart';
import 'cart_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NutriPlant'),
        backgroundColor: Colors.green[400],
        actions: [
          // IconButton(
          //   icon: Icon(Icons.notifications),
          //   onPressed: () {
          //     // Handle notifications click here
          //   },
          // ),
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
            _buildPopularArticlesSection(),
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
    final categories = [
      {'name': 'Succulents & Cacti', 'image': 'https://s3-alpha-sig.figma.com/img/be6f/9fe6/91042f5a10e8a333e982fb090b719ba2?Expires=1729468800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mgntzBnBlBs9oZimrenTEMDVUN8NE3hNVKpLkrQ6NW8T-xIt6oG9yAel5nknq7Joe02ef3DEIodlCryMC9KUtAr8SKW4bQPHmEKR0NbU7twvIZHfhkElml14W5qrDrbujaBHt0Clduu5jcONTbZug3m1haO915dRiWCjJX1AfMIIX1KsMjnGd0zCC8nbhpR9R8APHW83FBI1VC4V-NQWLoqGaM77tAfQS4CI-s3-7E16j5E75ZRwDWvo1YNQ1m3ikeDtEXl3z9HBcBUrtyVF8fCzeNeGm2~tsf26RaMwDHWIj6n7FG6wq5hvLqHFIs3MQoXnBwpNFnNa1w7Wbm1Xaw__'},
      {'name': 'Foliage Plants', 'image': 'https://s3-alpha-sig.figma.com/img/20d1/817f/92aa5b286edb2625851e369e1b695bb6?Expires=1729468800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=kQGo1X3FWDT1o~2oX2xTLRMD3ZQ2AvV0vLUXXQ58VgPC2zuBEJReXrJrSaBAMnv4LYyazNeaVmum0-7PirL4csyVQlTaPl9Ur-LOchJifk~t32xFThwdj5uQo4e0Bd-WJBJVe6SkbKf8POg37C5k6WDTore96flZV5wcGaPd6gq0~D-S3q606KLY68gBcZcH51RnWFoVY7DJiYmUebzi3ixU-2Oa-S~wl9GJ4AZEeEgAq0UOwznjEgBBRwYp6VGSM9AS8RdfQP3BypsJIR-CcCjsN5anw6OzR2crBvKvIlr2zj9EmDjd9XLI8dsHj~bJJB~TFWvAaK-MMDcgd9IXsw__'},
      {'name': 'Flowering Plants', 'image': 'https://s3-alpha-sig.figma.com/img/bdbc/f2f0/ba99a2e2c03810b547ce9810ea92c19e?Expires=1729468800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=iVi5~kkOwdXA8tHgAVbD3FWEPR92S66ILHZeI0o8XffpKI0FiX9DQ2jXBT5K3oI1pC99-R1N3cSKKbIZxzslrfZkvFOR5ruKld219CYlHr9dZRgoJdjuV7QtB39Rp~k~nz1B8erQRteVry3we0YUA85~dPY~YoPm7WjADOIUdliuxe25rwNlpYQwI1WuKTIYSskuLK2hXHI6xTql4fcrMzEKiF344tPYvTVIr3Av4zUkLZkuVONUB9rOPT997QZCEQ1FU5AGQH81Q-YT~MWC-n59U1UhVqXgUpTwgPYy8CHITBJJSq3RMjxDmSiONHcrbRQZ38RkpF3yAkrqNAlE5Q__'},
      {'name': 'Trees', 'image': 'https://s3-alpha-sig.figma.com/img/8807/527b/45646f95fa945bf3c6228e2216f508b8?Expires=1729468800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=VfA63GQgcVQ3l4buhYyb~rMyXcfQWl4J24toe6SwB5zMd1n4sKN73ckYsPkFUxzXxJ~7JnOaw90pVRx4LhKwHOx59PSfGZXXqMej2sUEaNVDhRk0MtCfPMtMDw-AeflSVWk9n4jDsjEFqkyT~R6QGuWOxTLvxw-7LUVohNBEwTmP2tDM68TvFCq6eAGGh4X5ngkPFr7CrdGtCN5JM94yVbZ9aIRH9sIHyYFfA0lfu9QtC7CH7TYqNmHt6c9d1quKVaXKjJs-uAG3l6q~kHXznjmRhXngndioMG-Lz3dmk2wQW9eKFIqtQgoMkCXN6PCguKYb5CGNjirKSFz6dmA-bg__'},
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlantListScreen(categories: categories),
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
          height: 335, // Adjusted height
          child: GridView.builder(
            padding: const EdgeInsets.only(top: 10),
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items per row
              childAspectRatio: 1.2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return buildCategoryCard(context, categories[index]);
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
              return buildArticleCard(context, articles[index]);
            },
          ),
        ),
      ],
    );
  }
}
