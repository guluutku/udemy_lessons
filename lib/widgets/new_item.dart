import 'package:flutter/material.dart';
import 'package:udemy_lessons/data/categories.dart';
import 'package:udemy_lessons/models/categories.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Item Name'),
                ),
                validator: (value) {
                  return 'Validtion';
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      initialValue: '1',
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: dropDownForm(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  DropdownButtonFormField<Category> dropDownForm() {
    return DropdownButtonFormField(
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
    );
  }
}
