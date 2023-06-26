import 'package:flutter/material.dart';

class AddNewPlaceScreen extends StatelessWidget {
  const AddNewPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Add Place'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
