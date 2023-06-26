import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_lessons/screens/add_new_place_screen.dart';
import 'package:udemy_lessons/widgets/places_list.dart';

import '../provider/favorite_places_provider.dart';

class YourPlacesScreen extends ConsumerWidget {
  const YourPlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritePlaces = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Places',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) {
                    return const AddNewPlaceScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: PlacesList(
        favoritePlaces: favoritePlaces,
      ),
    );
  }
}
