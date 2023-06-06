import 'package:flutter/material.dart';
import 'package:udemy_lessons/model/meal.dart';
import 'package:udemy_lessons/screens/categories.dart';
import 'package:udemy_lessons/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _pageIndex = 0;

  final List<Meal> _favorites = [];

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favorites.contains(meal);
    setState(() {
      isExisting ? _favorites.remove(meal) : _favorites.add(meal);
    });
  }

  void selectedPage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    var activePageTitle = 'Categories';

    if (_pageIndex == 1) {
      activePageTitle = 'Favorites';
      activePage = MealsScreen(
        onToggleFavorite: _toggleMealFavoriteStatus,
        meals: _favorites,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          selectedPage(index);
        },
        currentIndex: _pageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          )
        ],
      ),
    );
  }
}
