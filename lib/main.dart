import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:udemy_lessons/themes.dart';
import 'package:udemy_lessons/widgets/expenses.dart';

void main() {
  // Locks Portrait MOde
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((value) {
  //   runApp(const MyApp());
  // });
  //
  runApp(const MyApp());
}

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
