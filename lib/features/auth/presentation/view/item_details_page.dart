import 'package:flutter/material.dart';

class ItemDetailPage extends StatefulWidget {
  final Map<String, String> item;
  final Function(Map<String, String>) onRecycle;

  const ItemDetailPage({Key? key, required this.item, required this.onRecycle})
      : super(key: key);

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  late bool isRecycled;

  @override
  void initState() {
    super.initState();
    // Initialize the recycled state based on the item's current state
    isRecycled = widget.item['isRecycled'] == 'true';
  }

  void toggleRecycled() {
    setState(() {
      isRecycled = !isRecycled;
      widget.item['isRecycled'] = isRecycled.toString();
    });
    widget.onRecycle(widget.item); // Notify the HomeView about the change.
  }

  String _getRecyclingGuidelines(String category) {
    switch (category) {
      case 'Plastics':
        return 'Ensure plastic is clean and dry. Remove any labels if possible.';
      case 'Paper':
        return 'Remove any plastic coating and ensure paper is not soiled.';
      case 'Electronics':
        return 'Wipe data and remove any batteries before recycling.';
      case 'Glass':
        return 'Clean thoroughly and separate by color.';
      default:
        return 'Check local guidelines for recycling this item.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final guidelines =
        _getRecyclingGuidelines(widget.item['itemCategory'] ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item['itemName'] ?? 'Item Detail'),
        backgroundColor:
            Colors.green, // You can adjust the color to fit your app theme
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${widget.item['itemName']}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Category: ${widget.item['itemCategory']}'),
            const SizedBox(height: 8),
            Text('Condition: ${widget.item['itemCondition']}'),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Recycled'),
              value: isRecycled,
              onChanged: (bool value) {
                toggleRecycled();
              },
            ),
            const SizedBox(height: 20),
            const Text('Recycling Guidelines:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(guidelines, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
