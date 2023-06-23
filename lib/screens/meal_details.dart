import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_lessons/model/meal.dart';
import 'package:udemy_lessons/provider/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoritesProvider);

    final isFavorite = favoriteMeals.contains(meal);

    void showInfo(String message) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final favoriteState = ref
                  .read(favoritesProvider.notifier)
                  .toggleFavoritesState(meal);
              showInfo(favoriteState ? 'Meal Added' : 'Meal Removed');
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: animation,
                  child: child,
                );
              },
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(
                    isFavorite), // Make it so Flutter is aware of this change. AnimatedSwitcher takes key into account
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Vegan: ${meal.isVegan}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Vegetarian: ${meal.isVegetarian}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Gluten Free: ${meal.isGlutenFree}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Ingredients:',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(
              height: 6,
            ),
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Steps:',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(
              height: 6,
            ),
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  step,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
