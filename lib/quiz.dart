import 'package:flutter/material.dart';
import 'package:udemy_lessons/custom_decorated_box.dart';
import 'package:udemy_lessons/questions_scrren.dart';
import 'package:udemy_lessons/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  Widget? activeScreen;

  void switchScreen() {
    setState(() {
      activeScreen = const QuestionsScreen();
    });
  }

  @override
  void initState() {
    super.initState();
    activeScreen = StartScreen(startQuiz: switchScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: CustomDecoratedBox(
          child: activeScreen!,
        ),
      ),
    );
  }
}
