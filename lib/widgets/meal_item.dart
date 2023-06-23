import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:udemy_lessons/model/meal.dart';
import 'package:udemy_lessons/screens/meal_details.dart';
import 'package:udemy_lessons/widgets/meal_item_trait.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
  });

  final Meal meal;

  String get complexityText {
    // Make only first character is upper case
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    // Make only first character is upper case
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge, // Cut the overflowed image to show shape
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => MealDetailsScreen(
                meal: meal,
              ),
            ),
          ); // Navigator.push(context, route,);;
        },
        child: Stack(
          children: [
            Hero(
              child: FadeInImage(
                placeholder: MemoryImage(
                  kTransparentImage, // Imported from transparent image package
                ),
                image: NetworkImage(meal.imageUrl),
              ),
            ),
            Positioned(
              bottom: 0, // Widget ends 0 pixels before widget ends in bottom
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: MealsExplanation(
                  meal: meal,
                  complexityText: complexityText,
                  affordabilityText: affordabilityText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MealsExplanation extends StatelessWidget {
  const MealsExplanation({
    super.key,
    required this.meal,
    required this.complexityText,
    required this.affordabilityText,
  });

  final Meal meal;
  final String complexityText;
  final String affordabilityText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          meal.title,
          maxLines: 2,
          textAlign: TextAlign.center,
          softWrap: true,
          overflow: TextOverflow.clip,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 11,
        ),
        Row(
          children: [
            MealItemTrait(
              icon: Icons.schedule,
              label: meal.duration.toString(), // '${meal.duration}'
            ),
            const SizedBox(
              width: 12,
            ),
            MealItemTrait(
              icon: Icons.work,
              label: complexityText,
            ),
            const SizedBox(
              width: 12,
            ),
            MealItemTrait(
              icon: Icons.attach_money,
              label: affordabilityText,
            ),
          ],
        ),
      ],
    );
  }
}
