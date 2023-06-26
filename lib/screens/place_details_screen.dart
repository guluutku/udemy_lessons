import 'package:flutter/material.dart';
import 'package:udemy_lessons/models/favorite_place.dart';

class FavoritePlaceDetailsScreen extends StatelessWidget {
  const FavoritePlaceDetailsScreen({
    super.key,
    required this.favoritePlace,
  });

  final FavoritePlace favoritePlace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(favoritePlace.title),
        ),
        body: Center(
          child: Text(
            'No places added',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ));
  }
}
