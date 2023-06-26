import 'package:flutter/material.dart';

class AddNewPlaceScreen extends StatefulWidget {
  const AddNewPlaceScreen({super.key});

  @override
  State<AddNewPlaceScreen> createState() => _AddNewPlaceScreenState();
}

class _AddNewPlaceScreenState extends State<AddNewPlaceScreen> {
  final _titleEditorController = TextEditingController();

  @override
  void dispose() {
    _titleEditorController;
    super.dispose();
  }

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
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                controller: _titleEditorController,
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
