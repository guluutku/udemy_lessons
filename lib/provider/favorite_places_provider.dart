import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_lessons/models/favorite_place.dart';

class FavoritePlacesNotifier extends StateNotifier<List<FavoritePlace>> {
  FavoritePlacesNotifier() : super([]);
  void addFavoritePlaces(FavoritePlace favoritePlace){
    state = state.where((fP) => fP.title != favoritePlace.title).toList();
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritePlacesNotifier, List<FavoritePlace>>((ref) {
  return FavoritePlacesNotifier();
});
