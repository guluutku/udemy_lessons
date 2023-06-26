import 'package:flutter/material.dart';
import 'package:udemy_lessons/models/favorite_place.dart';
import 'package:udemy_lessons/screens/place_details_screen.dart';

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
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return FavoritePlaceDetailsScreen(
                    favoritePlace: favoritePlaces[index],
                  );
                }));
              },
              title: Text(
                favoritePlaces[index].title,
                style: textTheme,
              ),
            ),
          );
  }
}
