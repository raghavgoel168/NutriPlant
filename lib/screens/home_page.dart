import 'package:flutter/material.dart';
import 'package:nutri_plant/screens/plant_list_screen.dart';

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
    final categories = [
      {
        'name': 'Succulents & Cacti',
        'image': 'https://s3-alpha-sig.figma.com/img/be6f/9fe6/91042f5a10e8a333e982fb090b719ba2?Expires=1730678400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=VD1~hkPnanwGtBMlmj5HEsuu9f4efRivqr8eMZc6TfpjwCyu9KJqFtABiH-gRPFFFrhUD4UxN1ap93G35ImmWbduvl0QuY6ESMupCFxvrVoGJoG-9kgacAHJP9CWTnkdjsw9X00spA6rWt7cYv6HFF35dvUHNPE0Zp0nJ4O1Q1f3SplNXAWdvysNEOY49L8-uxWddB-kph2p12IEDJ861JglGiLhOVsv5bZFGobZfmSlxkFA4b57DG3BJde8BhXbM~SPkxsqvJS5V-De7Vsxc8bJ333m0LXHggdU1IurQTrUQVm-P8tXaWRIwseZQElFbzr0YJwlmYhNhVvCJwgY6Q__'
      },
      {
        'name': 'Foliage Plants',
        'image': 'https://s3-alpha-sig.figma.com/img/20d1/817f/92aa5b286edb2625851e369e1b695bb6?Expires=1730678400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=CDbXH~qq1fNROoQZOHHLdGJS098UVCmwqkMBK~BbhphjBX2nCRd6Bqc9r9wuli6Q-LQw4j-FQCGzOi-HPPcG5KnAd8cLhyPFBeOpU~9HRRtxiY8AActVHBZqyvm3paH-Orciq1y6fyrCTchKy5OUsjCK3lW0POitTsiCx4IbzleG2m8DCcphY3iSFZP16WJ64nKGVumLASb4tJWFH41DUIi2BOObRpdKBzbJTnXEOE1idMaWPfNcyagRZOsuIy~K2a-Uumlv2q1ZZCVRhFPMkI~fqdeVI1muqhNXlG1i5-tlxzz0xYYv7J3mZIG6v-2SFMJT~lYfgZ83~kFiyBKD6A__'
      },
      {
        'name': 'Flowering Plants',
        'image': 'https://s3-alpha-sig.figma.com/img/bdbc/f2f0/ba99a2e2c03810b547ce9810ea92c19e?Expires=1730678400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=VznIMJImLe-PplKJplVdxEmnP0n2MEhg8SBoDoSI5PQAYTYFnc3k4NQlvJF4aBUUysPqYBmoxQRWpRbFji3-dG9PGb5A-2MHZ5l8hP0gAqjdBa4pJ0IadMpbXY0yASRMwfI5CvjaEce16qYQq3YJSNgaSgDgc8v78H~BwZSeABcEmqldAiZAWM-C6C0gOFXXqv6ktNKPbgGGlyRdMIWxicXfLMiooNRnvwexpGo3CCaXHU7uT8f0OKFHKIpiWzN-d04Xz-x0pLTow5~yuRb-MKTXYuT2g39T4-x0yf0jw6VSAQ94PqSKlJteEv1LwuYn-uOkSiX0BoCuoWXl6AzQeA__'
      },
      {
        'name': 'Trees',
        'image': 'https://s3-alpha-sig.figma.com/img/8807/527b/45646f95fa945bf3c6228e2216f508b8?Expires=1730678400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=CChd0AAaT50tyBVERqEt7F5i05z8gF7HRMC5vzlFyLw2VgclTCkB8yXvffW8MeI967b1GAWSPqPfbMIsIG-z8uBNlSVGVEJcqa3qUBa~XPrm73Wqu4A0brIW9JQz3trW2FKf-rEu5IMMxn~7CWuawR54kEw-35w4iyNW3UwVQXUIp241H45iTby1zuIw9R7cF~LkIeigl882RwcVBfSgqHEtQK3L3YuUW1Op91nJOVmSUm-EBCgpwBe2YmRhAEiih3JeCI08x~DXL5PAH30WSsur2AQsLUMDNK2zUXCNEEUAC41tGiZQMsnkW1ZMnsmy25Pt15r0~3Ht5FMSqsNUTA__'
      },
      {
        'name': 'Weeds & Shrubs',
        'image': 'https://s3-alpha-sig.figma.com/img/1672/87f8/b97ddcee581edf7e065f70d2b0419ab1?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=W04WefcDEoU5gSSDuQ9jKlsk2X4IuOZ4f-n9EH83fhUOrE~BsrrbuMDEi3cgmYrhg5V3hT~7x6KB~JfZEMqii8B2PfmeQjFdRIyehj73pRRbSnXg3lcwTKN94NaFTuAB~OS~g438fI~QBLsBRk8eE-L0Cz~7TJ1yof~uUzincbZ0QuNn2tB5czYM1yy4YKZ7Y3cTfw8B6RdoMs28d~MFX3hWn1XtehfqRGw34XsrHQLi5ZY2qzaBQB4OZUlTIVZmNbJHVHR5Bcy11Gnp1~~HeFwik5Lj1dVWdqCKlmtKtxtpK23izyxupmrVJr61faR4vGUv0d-3lfAkFOvrixc9mw__'
      },
      {
        'name': 'Fruits',
        'image':'https://s3-alpha-sig.figma.com/img/3d6b/2411/dd3a2fa2d0a5da051a11498bf9265925?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=XRPgikswlNHn2tOnSWeJanfprm3FLeA3drhHxlkq2sFDG4DSvLFIN~~JQ3GrD-7J1TdsIHtu0yVVxhWi1R4k7XITuIpwUrO150jRZmAdaFLdfvHO9lNVxgDuo2qVCrbpLaGlpOGfv5Hqnx8M8b5S1qgQbRb-6jqDFiZnA8DFHnZGAv255nKjddx7zOWhpsszoW77UnnsaF1BA5uA0oBxdf-eZ254jrceU~6tAKczvCzkBwWskDldC5TqJMXK6BQL~rZksw285QOWYINAvmBUmV8LhsE82IZKGjU-NCIpCNvH1KeRBVxyypCdVJ-l~~N32mIIbBkBHjOGtZL0waxJJA__'
      },
      {
        'name': 'Vegetables',
        'image': 'https://s3-alpha-sig.figma.com/img/e7d4/b13f/382ce7742792b405609ac0ec2a7c9df6?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=o~dfH0~19nEUCR0b3yccCMjhwdta7sEwOgZNIXG3lYKLBGaTp9P56KKBIuU7oN30dHWNb2K8VUHsgRGkrht6NNARYbxRUUPOlQADEOmLSnyOwYcOcKsaPRUUNw0DbNPvh7h9jtwfw6F-Eww1xe0cktTrXRMpt7TumZY4UMQtiDAQ94cHt8uWdW-enMG5sOocGJm5Dnh4R38v0vjNWJrteGIbQ94I0Z41~V2ZlQVNVNjjY4WgdL~-YlcTnbp7yCHmublRyjj9BcNt-cw6Ker6W0PuH7C~qNemf~hDNzovlVHYkNGYR1xkNO7ui9adQo4O~3XQeo7tsLYy2AhwVbGmgQ__'
      },
      {
        'name': 'Herbs',
        'image': 'https://s3-alpha-sig.figma.com/img/1d93/6884/9755f22adb9d46a5c99078ce6a852483?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=dQrBWLS3szo~pX7qFgvmieObDnPNMrrXx0WoZFP00HrEMBS8yxYFNDv7U4MRb-WTmU~jcmK3C2~6S8UvFmCnEhTissJBxTlEQq0y5ZoL~ZABa0kXHidQf8l6fZS1vfVjQWeayCAHKjUsO3Xk3luKAjuIlLxgfmPOWSTvc6zQ0MpZXulpj1imlyW0do6kGt3aXEqoYkkSHhRqipsZtD917ThYjcqhhsIE8IMPdQGeg-7kHKFbNOQRgPkqvCrnT50lV47zqBavP89krdqCxe25CbcmPsMqaOZyPbacPOjFXLXPfCK190HcvSoKUAdbThJ15vnCn3CLUCEP5T6g6fKhnw__'
      },
      {
        'name': 'Mushrooms',
        'image': 'https://s3-alpha-sig.figma.com/img/0e69/c865/d5e3bbc523459cea1e9c1c3fda5d1bf6?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oLZEpdu-zpDBm8pkHxDmCkM1SlEdN3oU2nQcl4YUPBwL5yb1rMN9bO0I8qooogJJ7WAMjuj9kVgCyd~Xe-JuXKUEdlJtpq2ZYrAG5SR68Fc4WqBjcmdPphh8v5OLBoVJfHKGysoxuVUOPghgohJiuWgxqIo5ny1PLBQTUnS-vVcPRO37GCrnO3pPFD3puOExDsu917~oT2qkWqliGlHC8bZlynOOg~1KuBCqSTItNC4JXtcFj88axR4ZAYZvPq8GOlxIpZ4rmxuYkiVmZv4lsn3h2uyIVBR7DsGo1y72nfpGGA9MF6b6oq0O~TOoIf1Nju0K44Wwk24lr6k5Pz4Bkw__'
      },
      {
        'name': 'Toxic Plants',
        'image': 'https://s3-alpha-sig.figma.com/img/bd60/a8c1/d9a0b08f7024435dc60c0abb15874fbd?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Exn-G22U7lM9Yj8oF2hUcOFLCPC0c9Ph038B1W7GEwFDeV0auCMNTxUqsm1RsZ8cZYfANSIMCzhoR4YSi3eJl6Gc~fLgQcjHGz1iy0sknsnTkbeMiR7xkSaHd2uBBEGvLZ4fUQ5ifaHwYtEACZG2QTvVL84BFbtj63kyJIDA-qltTE9jTdNvNGTJVrl0E-TMWMiGxIJnD82h1LTUrGNftTR20pyi7D4ZNicb6lQ6axGGLk0aSI6DSs5FarSBYVki82c2~NuiEesjeS4gtDWwUQvQ2t8P9Egt40cOcA6qhw7PAXqZK5joFuozBNL8~5cWEtCB7fh2tshiLz0mw0DRrg__'
      },
    ];

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
    final articles = [
      {
        'title': 'Unlock the Secrets of Succulents',
        'image': 'https://www.marthastewart.com/thmb/1r0K4i4pVGdqQDqZ_bJ36BIg0YI=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/plants-look-beautiful-when-not-blooming-coleus-lead-getty-0623-c6efce0847fc421fab5f394fe02cda51.jpg',
        'content': '''
Succulents are a diverse group of plants known for their thick, fleshy leaves and stems that store water. They are popular for their unique appearance and low maintenance requirements. Here’s how you can care for succulents and keep them thriving:

1. **Choosing the Right Succulents**
   - **Variety**: There are many types of succulents, including Echeveria, Aloe, and Sedum. Choose varieties that suit your environment and aesthetic preferences.
   - **Health**: Select healthy plants with firm, plump leaves. Avoid succulents with soft, mushy, or discolored leaves.

2. **Planting Succulents**
   - **Soil**: Use well-draining soil specifically designed for succulents and cacti. You can also mix regular potting soil with sand or perlite to improve drainage.
   - **Containers**: Choose pots with drainage holes to prevent water from accumulating at the bottom. Terracotta pots are ideal as they allow excess moisture to evaporate.

3. **Watering Succulents**
   - **Frequency**: Water succulents thoroughly but infrequently. Allow the soil to dry out completely between waterings. Overwatering is the most common cause of succulent death.
   - **Method**: Water the soil directly rather than misting the leaves. Ensure water drains out of the pot to avoid root rot.

4. **Light Requirements**
   - **Sunlight**: Most succulents need plenty of bright, indirect sunlight. Place them near a south or east-facing window. Some varieties can tolerate direct sunlight, but be cautious of sunburn.
   - **Artificial Light**: If natural light is insufficient, use grow lights to supplement. LED grow lights are energy-efficient and effective for indoor succulents.

5. **Temperature and Humidity**
   - **Temperature**: Succulents prefer warm temperatures between 60°F and 80°F (15°C to 27°C). Protect them from frost and extreme heat.
   - **Humidity**: These plants thrive in low humidity environments. Avoid placing them in overly humid areas like bathrooms.

6. **Fertilizing Succulents**
   - **Type**: Use a balanced, water-soluble fertilizer diluted to half strength. Fertilize during the growing season (spring and summer) and reduce feeding in the dormant period (fall and winter).
   - **Frequency**: Fertilize once a month during the growing season.

7. **Pest Control**
   - **Common Pests**: Watch out for pests like mealybugs, aphids, and spider mites. Inspect your plants regularly and treat infestations promptly.
   - **Treatment**: Use insecticidal soap or neem oil to treat pests. Isolate affected plants to prevent the spread of pests.

8. **Propagation**
   - **Methods**: Succulents can be propagated from leaves, cuttings, or offsets. Allow cuttings to callous over before planting them in soil.
   - **Care**: Keep the soil slightly moist until new roots develop, then follow regular care guidelines.

By following these tips, you can enjoy the beauty and resilience of succulents in your home or garden. Happy gardening!
'''
      },


        {
          "title": "Indoor Plants: Care Tips",
          "image": "https://media.hswstatic.com/eyJidWNrZXQiOiJjb250ZW50Lmhzd3N0YXRpYy5jb20iLCJrZXkiOiJnaWZcL3BsYXlcL2M2ZGYwY2E2LWY1YTAtNDAwMS1hZjM2LWE1MTFkZmVjOWE1MS0xMjEwLTY4MC5qcGciLCJlZGl0cyI6eyJyZXNpemUiOnsid2lkdGgiOiIxMjAwIn19fQ==",
          "content": "Indoor plants bring beauty and freshness to your home while purifying the air. Here are some key tips to care for them:\n\n1. **Choosing the Right Plants**\n   - Consider light, humidity, and temperature requirements.\n2. **Watering**\n   - Water regularly but ensure drainage.\n3. **Light**\n   - Place them in bright, indirect light.\n4. **Soil and Fertilizer**\n   - Use well-draining soil and a balanced fertilizer.\n5. **Pests**\n   - Keep an eye out for pests and treat them quickly."
        },
        {
          "title": "The Best Houseplants for Clean Air",
          "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRt6dERq1DrjKHNxKURrBlowGO0PO44WQ8YHA&s",
          "content": "Houseplants are excellent for improving indoor air quality. Here are the best ones for clean air:\n\n1. **Spider Plant**\n   - Known for removing toxins like formaldehyde.\n2. **Snake Plant**\n   - Great for filtering out VOCs and carbon dioxide.\n3. **Peace Lily**\n   - Removes ammonia, benzene, and formaldehyde.\n4. **Aloe Vera**\n   - Purifies the air and also has medicinal properties.\n\nEnsure that your plants receive adequate light and water for optimal air-purifying benefits."
        },
        {
          "title": "How to Grow Your Own Herbs",
          "image": "https://media.wired.com/photos/5d8aab8bef84070009028d31/master/pass/Plant-Music-1162975190.jpg",
          "content": "Growing your own herbs is rewarding and easy. Here’s how to start:\n\n1. **Choose Your Herbs**\n   - Common options include basil, mint, thyme, and parsley.\n2. **Planting**\n   - Plant herbs in well-drained soil with good sunlight.\n3. **Watering**\n   - Water regularly but ensure soil isn’t waterlogged.\n4. **Harvesting**\n   - Pick leaves regularly to encourage more growth.\n\nWith minimal effort, you’ll have fresh herbs for cooking year-round."
        },
        {
          "title": "Top 10 Gardening Tips",
          "image": "https://gardenerspath.com/wp-content/uploads/2023/07/Get-Started-Gardening-Feature.jpg",
          "content": "Here are 10 essential gardening tips to ensure your garden flourishes:\n\n1. **Plan Ahead**\n   - Start with a plan that includes plant types and their spacing.\n2. **Soil Health**\n   - Enrich your soil with compost for healthy plants.\n3. **Watering**\n   - Water deeply and early in the morning.\n4. **Mulch**\n   - Use mulch to conserve moisture and reduce weeds.\n5. **Pruning**\n   - Regularly prune dead or overgrown plants.\n6. **Weeding**\n   - Stay on top of weeds to prevent competition for nutrients.\n7. **Fertilize**\n   - Feed your plants regularly with a balanced fertilizer.\n8. **Pest Control**\n   - Use organic methods to keep pests away.\n9. **Support Plants**\n   - Use stakes or trellises for taller plants.\n10. **Enjoy the Process**\n   - Gardening should be fun, so relax and enjoy the growth!"
        },
        {
          "title": "Top 5 Low-Maintenance Indoor Plants",
          "image": "https://nurserynisarga.in/wp-content/uploads/2019/09/1.jpg",
          "content": "If you're looking for low-maintenance indoor plants, here are five great options:\n\n1. **Snake Plant**\n   - Needs little water and can tolerate low light.\n2. **ZZ Plant**\n   - Very drought-tolerant and thrives in indirect light.\n3. **Aloe Vera**\n   - Requires minimal care and is great for your skin.\n4. **Spider Plant**\n   - Easy to grow and can handle neglect.\n5. **Pothos**\n   - Low-light tolerant and can grow in a variety of environments.\n\nThese plants are perfect for beginners or busy individuals."
        },
        {
          "title": "Essential Tools for Your Garden",
          "image": "https://www.bombaygreens.com/cdn/shop/articles/Composition_Garden_Tools.jpg?v=1710920084",
          "content": "Having the right tools makes gardening much easier. Here are some essentials:\n\n1. **Trowel**\n   - For digging and planting.\n2. **Pruning Shears**\n   - To trim dead or overgrown plants.\n3. **Garden Gloves**\n   - Protect your hands from dirt and sharp tools.\n4. **Watering Can**\n   - For precise watering.\n5. **Hoe**\n   - To break up soil and remove weeds.\n\nThese tools will help make your gardening experience more efficient and enjoyable."
        },
        {
          "title": "How to Repot Your Plants",
          "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyXzOUjZTzxRsV7pirIMTpERykAqvvml9XlQ&s",
          "content": "Repotting your plants ensures they have enough room to grow. Here’s how to do it:\n\n1. **Choose the Right Pot**\n   - Pick a pot that is 1-2 inches larger than the current one.\n2. **Remove the Plant**\n   - Gently remove the plant from the old pot.\n3. **Prepare the New Pot**\n   - Add a layer of fresh soil and place the plant in the center.\n4. **Fill with Soil**\n   - Add soil around the plant and water lightly.\n\nRepot every 1-2 years to ensure your plants stay healthy."
        },
        {
          "title": "10 Best Plants for Beginners",
          "image": "https://environment.co/wp-content/uploads/sites/4/2020/02/houseplants_1580927889-e1580927910230.jpg.webp",
          "content": "If you're new to gardening, these 10 plants are easy to grow:\n\n1. **Aloe Vera**\n   - Hardy and needs minimal care.\n2. **Spider Plant**\n   - Grows well in a variety of conditions.\n3. **Snake Plant**\n   - Tolerates low light and requires little watering.\n4. **Pothos**\n   - Fast-growing and can handle neglect.\n5. **Basil**\n   - Great for cooking and easy to grow indoors.\n6. **Peace Lily**\n   - Beautiful and requires little sunlight.\n7. **Zinnia**\n   - Perfect for beginners with their bright colors.\n8. **Cactus**\n   - Very low-maintenance, perfect for sunny spots.\n9. **Mint**\n   - Thrives in pots and is great for teas.\n10. **Marigold**\n   - Easy to grow and repels pests.\n\nThese plants require little care but provide great rewards."
        },
        {
          "title": "The Science of Plant Growth",
          "image": "https://www.mrgscience.com/uploads/2/0/7/9/20796234/download_33_orig.jpg",
          "content": "Plants grow through a process called photosynthesis, where they convert sunlight into energy. Here’s the science behind it:\n\n1. **Photosynthesis**\n   - Plants use chlorophyll to absorb light energy from the sun, converting carbon dioxide and water into glucose.\n2. **Cell Division**\n   - Plants grow by dividing cells in their meristematic regions.\n3. **Nutrient Uptake**\n   - Roots absorb essential nutrients like nitrogen, phosphorus, and potassium from the soil.\n\nThe combination of these processes helps plants grow taller, produce flowers, and develop fruits."
        },
        {
          "title": "How to Build a Vertical Garden at Home",
          "image": "https://i0.wp.com/growingorganic.com/wp-content/uploads/2018/03/How-to-Start-a-Vertical-Garden-1.jpg?fit=1024%2C683&ssl=1",
          "content": "Building a vertical garden is a space-saving way to grow plants. Here’s how you can do it:\n\n1. **Choose the Right Plants**\n   - Pick compact, climbing, or trailing plants like ivy, lettuce, or strawberries.\n2. **Select a Structure**\n   - Use a wooden frame, trellis, or wall-mounted planters.\n3. **Prepare the Soil**\n   - Use well-draining soil and make sure the plants have enough space to grow.\n4. **Watering**\n   - Water regularly, but ensure the soil doesn't become waterlogged.\n\nWith a vertical garden, you can enjoy a garden even in small spaces!"
        },
        {
          "title": "How to Start an Indoor Herb Garden",
          "image": "https://www.bhg.com/thmb/zaK9syyN1jvbWnZWc73UuYbMgCc=/1334x0/filters:no_upscale():strip_icc()/window-hanging-herb-planter-05014de0-c912aa196673407ea37d5ff6dbc7bcda.jpg",
          "content": "Starting an indoor herb garden is easy and rewarding. Follow these steps:\n\n1. **Select Your Herbs**\n   - Choose herbs like basil, parsley, or rosemary that thrive indoors.\n2. **Pick the Right Containers**\n   - Use small pots or containers with drainage holes.\n3. **Provide Light**\n   - Place the herbs near a sunny window or use grow lights.\n4. **Watering**\n   - Keep the soil moist but not soggy.\n\nWith a little care, you'll have fresh herbs all year round!"
        }

    ];

    // Display only 5 articles
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
          height: 140, // Adjusted height for article cards
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: displayedArticles.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigate to ArticleDetailsScreen when the article card is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ArticleDetailsScreen(
                            title: displayedArticles[index]['title']!,
                            image: displayedArticles[index]['image']!,
                            content: displayedArticles[index]['content'] ??
                                'No content available.', article: {},
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