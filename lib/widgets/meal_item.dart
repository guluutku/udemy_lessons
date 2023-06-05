import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:udemy_lessons/model/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge, // Cut the overflowed image to show shape
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(
                kTransparentImage, // Imported from transparent image package
              ),
              image: NetworkImage(meal.imageUrl),
            ),
            Positioned(
              bottom: 0, // Widget ends 0 pixels before widget ends in bottom
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
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
                      children: [],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
