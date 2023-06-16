import 'package:riverpod/riverpod.dart';
import 'package:udemy_lessons/data/dummy_data.dart';

final mealsProvider = Provider(
  (ref) {
    return dummyMeals;
  },
);
