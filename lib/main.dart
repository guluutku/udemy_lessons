import 'package:flutter/material.dart';
import 'package:udemy_lessons/widgets/expenses.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(
          255,
          220,
          189,
          252,
        ),
      ),
      home: const Expenses(),
    );
  }
}
