import 'package:flutter/material.dart';

class RecyclingCategory {
  final String name;
  final String description;
  final IconData icon;
  final String recyclingInfo;

  RecyclingCategory({
    required this.name,
    required this.description,
    required this.icon,
    required this.recyclingInfo,
  });
}

class RecyclingCategoriesView extends StatelessWidget {
  const RecyclingCategoriesView({Key? key}) : super(key: key);

  List<RecyclingCategory> get categories => [
        RecyclingCategory(
          name: 'Plastics',
          description: 'Bottles, containers, packaging, etc.',
          icon: Icons.recycling,
          recyclingInfo:
              'Ensure plastic is clean and dry. Remove any labels if possible.',
        ),
        RecyclingCategory(
          name: 'Metals',
          description: 'Aluminum cans, steel products, etc.',
          icon: Icons.kitchen,
          recyclingInfo: 'Rinse and clean metal items before recycling.',
        ),
        RecyclingCategory(
          name: 'Paper',
          description: 'Newspapers, cardboard, mail, etc.',
          icon: Icons.description,
          recyclingInfo:
              'Remove any plastic coating and ensure paper is not soiled.',
        ),
        RecyclingCategory(
          name: 'Electronics',
          description: 'Phones, computers, electronic devices, etc.',
          icon: Icons.phonelink,
          recyclingInfo: 'Wipe data and remove any batteries before recycling.',
        ),
        RecyclingCategory(
          name: 'Glass',
          description: 'Bottles, jars, etc.',
          icon: Icons.broken_image,
          recyclingInfo: 'Clean thoroughly and separate by color.',
        ),
        RecyclingCategory(
          name: 'Textiles',
          description: 'Clothing, bags, fabric scraps, etc.',
          icon: Icons.texture,
          recyclingInfo:
              'Donate usable clothing or recycle fabric scraps at designated facilities.',
        ),
      ];

  void _navigateToCategoryDetail(
      BuildContext context, RecyclingCategory category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryDetailPage(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recycling Categories'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(category.icon, size: 40.0),
              title: Text(category.name),
              subtitle: Text(category.description),
              onTap: () {
                _navigateToCategoryDetail(context, category);
              },
            ),
          );
        },
      ),
    );
  }
}

class CategoryDetailPage extends StatelessWidget {
  final RecyclingCategory category;

  const CategoryDetailPage({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(category.icon, size: 80.0),
            const SizedBox(height: 20.0),
            Text('Category: ${category.name}',
                style: const TextStyle(fontSize: 20.0)),
            Text('Description: ${category.description}',
                style: const TextStyle(fontSize: 18.0)),
            const SizedBox(height: 20.0),
            const Text('Recycling Information:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            Text(category.recyclingInfo,
                style: const TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}
