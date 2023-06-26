import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_lessons/models/favorite_place.dart';

class FavoritePlacesNotifier extends StateNotifier<List<FavoritePlace>> {
  FavoritePlacesNotifier() : super([]);
  void addFavoritePlaces(String title){
    final newFavoritePlace = FavoritePlace(title: title);
    state = [...state, newFavoritePlace];
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritePlacesNotifier, List<FavoritePlace>>((ref) {
  return FavoritePlacesNotifier();
});
