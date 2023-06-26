import 'package:flutter/material.dart';
import 'package:udemy_lessons/models/favorite_place.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({
    super.key,
    required this.favoritePlaces,
  });

  final List<FavoritePlace> favoritePlaces;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(color: Theme.of(context).colorScheme.onBackground);
    return favoritePlaces.isEmpty
        ? Center(
            child: Text(
              'No places added',
              style: textTheme,
            ),
          )
        : ListView.builder(
            itemCount: favoritePlaces.length,
            itemBuilder: (BuildContext context, int index) => ListTile(
              title: Text(
                favoritePlaces[index].title,
                style: textTheme,
              ),
            ),
          );
  }
}
