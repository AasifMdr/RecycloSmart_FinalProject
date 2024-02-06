import 'package:flutter/material.dart';

import 'item_details_page.dart';
import 'recycling_categories_view.dart';
import 'recycling_tips_view.dart';

class HomeView extends StatefulWidget {
  final List<Map<String, String>> addedItems;

  const HomeView({Key? key, required this.addedItems}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Callback function to handle recycling action
  void _handleRecycle(Map<String, String> recycledItem) {
    setState(() {
      // Find the index of the item to be updated using its unique identifier
      int index = widget.addedItems
          .indexWhere((item) => item['id'] == recycledItem['id']);
      if (index != -1) {
        // Update the item at the correct index
        widget.addedItems[index] = recycledItem;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 232, 245, 233), // Light green background
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 27, 206, 200), // Eco-friendly teal
        title: const Text(
          'RecycloSmart',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RecyclingTipsPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search recyclable items...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const RecyclingCategoriesView()));
                },
                icon: const Icon(Icons.category),
                label: const Text('Recycling Categories'),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecyclingTipsPage()));
                },
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recycling Tips',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Items Added',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              // Displaying the added items
              ...widget.addedItems
                  .map((item) => ListTile(
                        title: Text(item['itemName'] ?? 'No Name'),
                        subtitle: Text(
                            'Category: ${item['itemCategory']}, Condition: ${item['itemCondition']}'),
                        trailing: item['isRecycled'] == 'true'
                            ? const Icon(Icons.check, color: Colors.green)
                            : null,
                        onTap: () {
                          // Navigate to ItemDetailPage on tap, passing the item and the recycle handler
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ItemDetailPage(
                                item: item, onRecycle: _handleRecycle),
                          ));
                        },
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
