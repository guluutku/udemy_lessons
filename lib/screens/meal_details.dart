import 'package:flutter/material.dart';
import 'package:udemy_lessons/model/meal.dart';

class MealDetails extends StatelessWidget {
  const MealDetails({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      // TODO: Put details from dummy data
      body: const Column(
        children: [
          Text('Ingredients'),
          Text('Steps'),
          Text('isGlutenFree'),
          Text('isVegan'),
          Text('isVegetarian'),
          Text('isLactoseFree'),
        ],
      ),
    );
  }
}
