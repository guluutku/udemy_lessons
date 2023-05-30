import 'package:flutter/material.dart';
import 'package:udemy_lessons/themes.dart';
import 'package:udemy_lessons/widgets/expenses.dart';

void main() {
  runApp(const MyApp());
}

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(
    255,
    96,
    59,
    181,
  ),
); // Automatically creates color scheme based on seed color

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(
    255,
    5,
    99,
    125,
  ),
); // Color Scheme seed for Dark Mode

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: darkModeTheme(), // Dark Mode Theme
      //
      theme: lightModeTheme(),
      themeMode: ThemeMode.system, // Check user's default mode
      home: const Expenses(),
    );
  }
}
