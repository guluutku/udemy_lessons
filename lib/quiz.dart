import 'package:flutter/material.dart';
import 'package:udemy_lessons/custom_decorated_box.dart';
import 'package:udemy_lessons/data/questions.dart';
import 'package:udemy_lessons/result_screen.dart';
import 'package:udemy_lessons/questions_screen.dart';
import 'package:udemy_lessons/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final List<String> selectedAnswer = [];
  Widget? activeScreen;

  void switchScreen() {
    setState(() {
      activeScreen = QuestionsScreen(
        chosenAnswer: chosenAnswer,
      );
    });
  }

  void chosenAnswer(String answer) {
    selectedAnswer.add(answer);

    if (selectedAnswer.length == questions.length) {
      setState(() {
        activeScreen = const ResultScreen();
      });
    }
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
          child: activeScreen!
        ),
      ),
    );
  }
}
