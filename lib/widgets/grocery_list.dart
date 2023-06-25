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
  late Future<List<GroceryItem>> _fetchedData;

  @override
  void initState() {
    super.initState();
    _fetchedData = _fetchData();
  }

  Future<List<GroceryItem>> _fetchData() async {
    final url = Uri.https(
      'udemy-project-7bedb-default-rtdb.europe-west1.firebasedatabase.app',
      'shopping-list.json',
    );

    final response = await http.get(url);
    if (response.statusCode >= 400) {
      throw Exception('Have problem with back end');
    }
    if (response.body == 'null') {
      return [];
    }

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
    return _groceryItems;
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

  void _deleteGrocery(GroceryItem groceryItem) {
    setState(() {
      _groceryItems.remove(groceryItem);
      _deleteFromDatabase(groceryItem);
    });
  }

  void _deleteFromDatabase(GroceryItem groceryItem) async {
    final index = _groceryItems.indexOf(groceryItem);
    final url = Uri.https(
      'udemy-project-7bedb-default-rtdb.europe-west1.firebasedatabase.app',
      'shopping-list/${groceryItem.id}.json',
    );
    final response = await http.delete(url);
    // If user can not delete because of any of the problems
    // Show the problem. NOT SHOWN FOR NOW
    // If there is any problem with deletion ,only inserts deleted item again
    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, groceryItem);
      });
    }
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
      //
      body: FutureBuilder(
        future: _fetchedData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No grocery added'),
            );
          }
          return _groceryListWidget();
        },
      ),
    );
  }

  ListView _groceryListWidget() {
    return ListView.builder(
      itemCount: _groceryItems.length,
      itemBuilder: (context, index) => Dismissible(
        onDismissed: (direction) {
          _deleteGrocery(_groceryItems[index]);
        },
        key: ValueKey(_groceryItems[index].id),
        child: ListTile(
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
      ),
    );
  }
}
