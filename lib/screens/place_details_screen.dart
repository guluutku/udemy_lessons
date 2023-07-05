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
    final textTheme = Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(color: Theme.of(context).colorScheme.onBackground);
    return Scaffold(
      appBar: AppBar(
        title: Text(favoritePlace.title),
      ),
      body: Stack(
        children: [
          Image.file(
            favoritePlace.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Latitude: ${favoritePlace.locationModel.latitude}',
                    style: textTheme,
                  ),
                  Text(
                    'Longitude: ${favoritePlace.locationModel.longitude}',
                    style: textTheme,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
