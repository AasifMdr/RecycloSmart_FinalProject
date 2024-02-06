import 'package:flutter/material.dart';

class RecyclingTipsPage extends StatelessWidget {
  const RecyclingTipsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tips = [
      'Rinse all bottles before recycling.',
      'Flatten cardboard boxes to save space.',
      'Do not recycle greasy pizza boxes.',
      'Recycle electronics at special drop-off locations.',
      'Reuse glass containers for storage.',
      'Recycle plastic bags at designated collection points.',
      'Separate recyclables from trash to avoid contamination.',
      'Recycle old newspapers and magazines.',
      'Donate gently used clothing and furniture instead of disposing of them.',
      'Compost food scraps to reduce waste.',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recycling Tips'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: tips.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tips[index]),
          );
        },
      ),
    );
  }
}
