import 'package:flutter/material.dart';

enum Categories {
  dairy,
  vegetables,
  fruit,
  meat,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other,
}

class Category {
  Category(
    this.name,
    this.color,
  );

  final String name;
  final Color color;
}
