import 'package:flutter/material.dart';

class AddRecyclableItemPage extends StatefulWidget {
  const AddRecyclableItemPage({Key? key}) : super(key: key);

  @override
  State<AddRecyclableItemPage> createState() => _AddRecyclableItemPageState();
}

class _AddRecyclableItemPageState extends State<AddRecyclableItemPage> {
  final _formKey = GlobalKey<FormState>();
  String _itemName = '';
  String _itemCategory = '';
  String _itemDescription = '';
  String _itemCondition = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recyclable Item'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFormField(
                    labelText: 'Item Name',
                    onSave: (value) => _itemName = value!),
                const SizedBox(height: 20),
                _buildTextFormField(
                    labelText: 'Category',
                    onSave: (value) => _itemCategory = value!),
                const SizedBox(height: 20),
                _buildTextFormField(
                    labelText: 'Description',
                    onSave: (value) => _itemDescription = value!),
                const SizedBox(height: 20),
                _buildItemConditionDropdown(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final itemData = {
                        'itemName': _itemName,
                        'itemCategory': _itemCategory,
                        'itemDescription': _itemDescription,
                        'itemCondition': _itemCondition,
                      };
                      Navigator.pop(context, itemData);
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextFormField(
      {required String labelText, required Function(String?) onSave}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        fillColor: Colors.grey[200],
        filled: true,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!, width: 2.0)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2.0)),
        floatingLabelStyle: const TextStyle(color: Colors.black),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Please enter $labelText' : null,
      onSaved: onSave,
    );
  }

  Widget _buildItemConditionDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Item Condition',
            style: TextStyle(color: Colors.black, fontSize: 20)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            fillColor: Color.fromARGB(255, 228, 222, 222),
            filled: true,
            border: OutlineInputBorder(),
          ),
          value: _itemCondition.isNotEmpty ? _itemCondition : null,
          items: <String>['New', 'Good', 'Fair', 'Poor']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (String? newValue) =>
              setState(() => _itemCondition = newValue!),
          validator: (value) =>
              value == null ? 'Please select item condition' : null,
        ),
      ],
    );
  }
}
