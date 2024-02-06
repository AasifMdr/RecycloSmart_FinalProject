import 'package:flutter/material.dart';

import 'login_view.dart'; // Import the login view

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future<void> _showLogoutConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevent dialog dismissal on tap outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout',
              style: TextStyle(color: Colors.black)),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to logout?',
                    style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: const Text('Yes', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
                _logout(); // Call the logout function
              },
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    // Implement your logout logic here
    // For example, you can navigate to the login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
      (Route<dynamic> route) => false, // Clear the navigation stack
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Change background color to white
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 206, 200),
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black, // Change title color to black
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Add onPressed functionality for the settings icon
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: Image.asset(
                  'assets/images/user.png', // Use local asset image
                  height: 120, // Adjust the image size as needed
                ).image,
              ),
              const SizedBox(height: 20),
              const Text(
                'aasif manandhar', // Replace with user's name
                style: TextStyle(
                  color: Colors.black, // Change text color to black
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'aasifmdr', // Replace with user's email
                style: TextStyle(
                  color: Colors.grey, // Change text color to grey
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.grey), // Change divider color to grey
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showLogoutConfirmationDialog(); // Show logout confirmation dialog
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.red, // Change button color to red
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              // Add more profile information here, like user's posts, followers, etc.
            ],
          ),
        ),
      ),
    );
  }
}
