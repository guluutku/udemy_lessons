import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      /*
      drawer: MainDrawer(onSelectedScreen: ((identifier) {
        if (identifier == 'meals') {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const TabsScreen()));
        }
      })),
      */
      body: Column(
        children: [
          glutenFilter(context),
          lactoseFreeFilter(context),
          vegetarianFilter(context),
          veganFilter(context),
        ],
      ),
    );
  }

  SwitchListTile veganFilter(BuildContext context) {
    return SwitchListTile(
          value: _veganFilterSet,
          onChanged: (value) {
            setState(() {
              _veganFilterSet = value;
            });
          },
          title: Text(
            'Vegan',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        );
  }

  SwitchListTile vegetarianFilter(BuildContext context) {
    return SwitchListTile(
          value: _vegetarianFilterSet,
          onChanged: (value) {
            setState(() {
              _vegetarianFilterSet = value;
            });
          },
          title: Text(
            'Vegetarian',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        );
  }

  SwitchListTile lactoseFreeFilter(BuildContext context) {
    return SwitchListTile(
          value: _lactoseFreeFilterSet,
          onChanged: (value) {
            setState(() {
              _lactoseFreeFilterSet = value;
            });
          },
          title: Text(
            'Lactose Free',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        );
  }

  SwitchListTile glutenFilter(BuildContext context) {
    return SwitchListTile(
          value: _glutenFreeFilterSet,
          onChanged: (value) {
            setState(() {
              _glutenFreeFilterSet = value;
            });
          },
          title: Text(
            'Gluten Free',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        );
  }
}
