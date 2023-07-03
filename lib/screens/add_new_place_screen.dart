import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_lessons/provider/favorite_places_provider.dart';
import 'package:udemy_lessons/widgets/camera_input.dart';

class AddNewPlaceScreen extends ConsumerStatefulWidget {
  const AddNewPlaceScreen({super.key});

  @override
  ConsumerState<AddNewPlaceScreen> createState() => _AddNewPlaceScreenState();
}

class _AddNewPlaceScreenState extends ConsumerState<AddNewPlaceScreen> {
  final _titleEditorController = TextEditingController();
  File? _selectedImage;

  void _addNewFavoritePlace() {
    final inputText = _titleEditorController.text;
    if (inputText.isEmpty) {
      return;
    }
    ref.read(favoritesProvider.notifier).addFavoritePlaces(
          inputText,
          _selectedImage!,
        );
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
              titleTextFormField(context),
              const SizedBox(
                height: 15,
              ),
              // Image Input widget
              CameraInputWidget(
                onPickedImage: (image) {
                  _selectedImage = image;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: _addNewFavoritePlace,
                icon: const Icon(Icons.add),
                label: const Text('Add Place'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField titleTextFormField(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
      ),
      controller: _titleEditorController,
      decoration: const InputDecoration(
        label: Text('Title'),
      ),
    );
  }
}
