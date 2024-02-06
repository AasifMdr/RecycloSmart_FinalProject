import 'package:flutter/material.dart';

import 'add_recyclable_item_view.dart'; // Adjust the import path as needed
import 'home_view.dart'; // Adjust the import path as needed
import 'profile_view.dart'; // Adjust the import path as needed

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  final List<Map<String, String>> _addedItems = [];

  void _navigateAndAddItem() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddRecyclableItemPage()),
    );

    if (result != null) {
      setState(() {
        _addedItems.add(result as Map<String, String>);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bottomScreens = [
      HomeView(addedItems: _addedItems),
      const ProfileView(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: bottomScreens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellowAccent,
        backgroundColor: Colors.teal, // Set the background color to teal
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: _navigateAndAddItem,
              backgroundColor: Colors.green,
              child: const Icon(Icons.recycling),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, // Position FAB in the center
    );
  }
}
