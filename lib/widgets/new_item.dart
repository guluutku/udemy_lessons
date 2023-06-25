import 'package:flutter/material.dart';
import 'package:udemy_lessons/data/categories.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredItemName = '';

  void saveNewItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
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
      onSaved: (newValue) {
        _enteredItemName = newValue!;
      },
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
        initialValue: '1',
        validator: (value) {
          if (value == null ||
              value.isEmpty ||
              int.tryParse(value) == null ||
              int.tryParse(value)! <= 0) {
            return 'Must be Valid Positive Number';
          }
          return null;
        },
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
        onChanged: (value) {},
      ),
    );
  }
}
