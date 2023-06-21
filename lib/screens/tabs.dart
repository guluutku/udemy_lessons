import 'package:flutter/material.dart';
import 'package:udemy_lessons/provider/favorites_provider.dart';
import 'package:udemy_lessons/provider/filter_provider.dart';
import 'package:udemy_lessons/provider/meals_provider.dart';
import 'package:udemy_lessons/screens/categories.dart';
import 'package:udemy_lessons/screens/filter_screen.dart';
import 'package:udemy_lessons/screens/meals.dart';
import 'package:udemy_lessons/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _pageIndex = 0;

  // final List<Meal> _favorites = [];
  /* Using Providers
  Map<Filter, bool> _selectedFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };*/
/*
  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favorites.contains(meal);
    if (isExisting) {
      setState(() {
        _favorites.remove(meal);
      });
      _showInfo('Meal is removed from favorites');
    } else {
      setState(() {
        _favorites.add(meal);
      });
      _showInfo('Meal is added to favorites');
    }
    /*
    setState(() {
      isExisting ? _favorites.remove(meal) : _favorites.add(meal);
    });
    */
  }
*/

  void selectedPage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => const FilterScreen(),
        ),
      );
      /* Removed because using provider instead
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });*/
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final activeFilter = ref.watch(filterProvider);
    final availableMeals = meals.where((meal) {
      if (activeFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilter[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilter[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_pageIndex == 1) {
      final favoriteMeals = ref.watch(favoritesProvider);
      activePageTitle = 'Favorites';
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectedScreen: _setScreen,
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
