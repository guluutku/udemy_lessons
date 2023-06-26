import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_lessons/provider/favorite_places_provider.dart';

class AddNewPlaceScreen extends ConsumerStatefulWidget {
  const AddNewPlaceScreen({super.key});

  @override
  ConsumerState<AddNewPlaceScreen> createState() => _AddNewPlaceScreenState();
}

class _AddNewPlaceScreenState extends ConsumerState<AddNewPlaceScreen> {
  final _titleEditorController = TextEditingController();

  void _addNewFavoritePlace() {
    final inputText = _titleEditorController.text;
    if (inputText.isEmpty) {
      return;
    }
    ref.read(favoritesProvider.notifier).addFavoritePlaces(inputText);
    Navigator.of(context).pop();
  }

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
