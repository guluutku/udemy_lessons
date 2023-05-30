import 'package:flutter/material.dart';
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
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kDarkColorScheme.onPrimaryContainer,
          foregroundColor: kDarkColorScheme.primaryContainer,
        ), // Set AppBar theme: colors and other UI elements
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
        ), // Override all Card Widgets' theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer),
        ), // Override all Elevated Button Widgets' theme
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                color: kDarkColorScheme
                    .onSecondaryContainer, // not working as we have made a color in line 31
                fontWeight: FontWeight.bold,
              ),
            ),
      ), // Dark Mode Theme
      //
      theme: ThemeData().copyWith(
        useMaterial3: true,
        // scaffoldBackgroundColor: const Color.fromARGB(255, 220, 189, 252),
        colorScheme:
            kColorScheme, // Can override selected parts of the theme based on color scheme
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ), // Set AppBar theme: colors and other UI elements
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
        ), // Override all Card Widgets' theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer),
        ), // Override all Elevated Button Widgets' theme
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                color: kColorScheme
                    .onSecondaryContainer, // not working as we have made a color in line 31
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      themeMode: ThemeMode.system, // Check user's default mode
      home: const Expenses(),
    );
  }
}
