import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:udemy_lessons/data/categories.dart';
import 'package:udemy_lessons/models/categories.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredItemName = '';
  var _enteredItemQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables];

  void saveNewItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final url = Uri.https(
        'udemy-project-7bedb-default-rtdb.europe-west1.firebasedatabase.app',
        'shopping-list.json',
      );
      http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': _enteredItemName,
          'quantity': _enteredItemQuantity,
          'category': _selectedCategory!.name,
        }),
      );

      
    }
  }

  @override
  Widget build(BuildContext context) {
    var itemNameTextFormField = TextFormField(
      maxLength: 50,
      decoration: const InputDecoration(
        label: Text('Item Name'),
      ),
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            value.trim().length <= 1 ||
            value.trim().length >= 50) {
          return 'Characters must be between 1 and 50';
        }
        return null;
      },
      onSaved: (newValue) => _enteredItemName = newValue!,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              itemNameTextFormField,
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  itemQuantityTextFormField(),
                  const SizedBox(
                    width: 5,
                  ),
                  dropDownForm(),
                ],
              ),
              buttons(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded itemQuantityTextFormField() {
    return Expanded(
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          label: Text('Quantity'),
        ),
        initialValue: _enteredItemQuantity.toString(),
        validator: (value) {
          if (value == null ||
              value.isEmpty ||
              int.tryParse(value) == null ||
              int.tryParse(value)! <= 0) {
            return 'Must be Valid Positive Number';
          }
          return null;
        },
        onSaved: (newValue) => _enteredItemQuantity = int.parse(newValue!),
      ),
    );
  }

  Row buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            // Resets all inputs in the form
            _formKey.currentState!.reset();
          },
          child: const Text('Reset'),
        ),
        ElevatedButton(
          onPressed: saveNewItem,
          child: const Text('Save Item'),
        ),
      ],
    );
  }

  Expanded dropDownForm() {
    return Expanded(
      child: DropdownButtonFormField(
        value: _selectedCategory,
        items: [
          for (final category in categories.entries)
            DropdownMenuItem(
              value: category.value,
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    color: category.value.color,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(category.value.name),
                ],
              ),
            ),
        ],
        onChanged: (value) {
          setState(() {
            _selectedCategory = value;
          });
        },
      ),
    );
  }
}
