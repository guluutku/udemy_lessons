import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.onSelectedScreen,
  });

  final void Function(String identifier) onSelectedScreen;

  @override
  Widget build(BuildContext context) {
    var mealsTile = ListTile(
      leading: Icon(
        Icons.restaurant,
        color: Theme.of(context).colorScheme.onBackground,
        size: 26,
      ),
      title: Text(
        'Meals',
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Theme.of(context).colorScheme.onBackground, fontSize: 24),
      ),
      onTap: () {
        onSelectedScreen('meals');
      },
    );

    var filterTile = ListTile(
      leading: Icon(
        Icons.settings,
        color: Theme.of(context).colorScheme.onBackground,
        size: 26,
      ),
      title: Text(
        'Filters',
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Theme.of(context).colorScheme.onBackground, fontSize: 24),
      ),
      onTap: () {
        onSelectedScreen('filters');
      },
    );

    return Drawer(
      child: Column(
        children: [
          const Header(),
          mealsTile,
          filterTile,
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.fastfood,
            size: 50,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(
            width: 18,
          ),
          Text(
            'Cooking Up',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
    );
  }
}
