import 'package:flutter/material.dart';
import 'package:udemy_lessons/data/dummy_data.dart';
import 'package:udemy_lessons/model/category.dart';
import 'package:udemy_lessons/widgets/category_grid_item.dart';
import 'package:udemy_lessons/screens/meals.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _selectedCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals.where((element) {
      return element.categories.contains(category.id);
    }).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: 'New Title',
          meals: filteredMeals,
        ),
      ),
    ); // Navigator.push(context, route,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category'),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () => _selectedCategory(context, category),
            ),
        ],
      ),
    );
  }
}
