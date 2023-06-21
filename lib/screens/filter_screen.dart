import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_lessons/provider/filter_provider.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilter = ref.watch(filterProvider);

    veganFilter() {
      return SwitchListTile(
        value: activeFilter[Filter.vegan]!,
        onChanged: (value) {
          ref.read(filterProvider.notifier).setFilter(Filter.vegan, value);
        },
        title: Text(
          'Vegan',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }

    vegetarianFilter() {
      return SwitchListTile(
        value: activeFilter[Filter.vegetarian]!,
        onChanged: (value) {
          ref.read(filterProvider.notifier).setFilter(Filter.vegetarian, value);
        },
        title: Text(
          'Vegetarian',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }

    lactoseFreeFilter() {
      return SwitchListTile(
        value: activeFilter[Filter.lactoseFree]!,
        onChanged: (value) {
          ref
              .read(filterProvider.notifier)
              .setFilter(Filter.lactoseFree, value);
        },
        title: Text(
          'Lactose Free',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }

    glutenFilter() {
      return SwitchListTile(
        value: activeFilter[Filter.glutenFree]!,
        onChanged: (value) {
          ref.read(filterProvider.notifier).setFilter(Filter.glutenFree, value);
        },
        title: Text(
          'Gluten Free',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }

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
          glutenFilter(),
          lactoseFreeFilter(),
          vegetarianFilter(),
          veganFilter(),
        ],
      ),
    );
  }
}
