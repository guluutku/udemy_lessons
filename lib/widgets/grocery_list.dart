import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:udemy_lessons/data/categories.dart';
import 'package:udemy_lessons/models/grocery_item.dart';
import 'package:udemy_lessons/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    final url = Uri.https(
      'udemy-project-7bedb-default-rtdb.europe-west1.firebasedatabase.app',
      'shopping-list.json',
    );
    final response = await http.get(url);
    final Map<String, dynamic> listData = json.decode(response.body);
    for (final data in listData.entries) {
      final category = categories.entries
          .firstWhere(
            (element) => element.value.name == data.value['category'],
          )
          .value;
      _groceryItems.add(
        GroceryItem(
          id: data.key,
          name: data.value['name'],
          quantity: data.value['quantity'],
          category: category,
        ),
      );
    }
    setState(() {
      _groceryItems;
    });
  }

  void _addItemPage() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (context) => const NewItem()),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groceries'),
        actions: [
          IconButton(
            onPressed: _addItemPage,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: _groceryItems.isNotEmpty
          ? ListView.builder(
              itemCount: _groceryItems.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(_groceryItems[index].name),
                leading: Container(
                  height: 24,
                  width: 24,
                  color: _groceryItems[index].category.color,
                ),
                trailing: Text(
                  _groceryItems[index].quantity.toString(),
                ),
              ),
            )
          : const Center(
              child: Text('No grocery added'),
            ),
    );
  }
}
