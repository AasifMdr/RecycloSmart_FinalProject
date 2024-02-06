import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemTypeController =
      TextEditingController(); // New controller
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  void _verifyItem(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final item = Item(
        itemName: _itemNameController.text,
        itemType: _itemTypeController.text, // New item type
        phoneNumber: _phoneNumberController.text,
        location: _locationController.text,
        image: _selectedImage,
      );

      // Show a snackbar to indicate successful item addition
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item added successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemTypeController.dispose(); // Dispose the new controller
    _phoneNumberController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
        backgroundColor: const Color.fromARGB(255, 27, 206, 200),
      ),
      body: SingleChildScrollView(
        // Add SingleChildScrollView to prevent bottom overflow
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _itemNameController,
                  decoration: const InputDecoration(
                    labelText: 'Item Name',
                    labelStyle: TextStyle(fontSize: 16),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter item name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _itemTypeController, // New controller
                  decoration: const InputDecoration(
                    labelText: 'Item Type', // New label
                    labelStyle: TextStyle(fontSize: 16),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter item type'; // New validation message
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(fontSize: 16),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus(); // Hide keyboard
                    _pickImage();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 27, 206, 200),
                    ),
                  ),
                  child: const Text(
                    'Pick Image from Gallery',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                if (_selectedImage != null) Image.file(_selectedImage!),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    labelStyle: TextStyle(fontSize: 16),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _verifyItem(context); // Pass the context here
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 27, 206, 200),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add Item',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Item {
  final String itemName;
  final String itemType; // New field
  final String phoneNumber;
  final String location;
  final File? image;

  Item({
    required this.itemName,
    required this.itemType, // New parameter
    required this.phoneNumber,
    required this.location,
    this.image,
  });
}

// Define your addedItemsProvider and related code here...
