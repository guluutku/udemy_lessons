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
  final List<String> selectedAnswersList = [];
  Widget? activeScreen;

  void switchScreen() {
    setState(() {
      activeScreen = QuestionsScreen(
        chosenAnswer: chosenAnswer,
      );
    });
  }

  void chosenAnswer(String answer) {
    selectedAnswersList.add(answer);

    if (selectedAnswersList.length == questions.length) {
      setState(() {
        activeScreen = ResultScreen(
          selectedAnswers: selectedAnswersList,
        );
        selectedAnswersList.clear();
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
        body: CustomDecoratedBox(child: activeScreen!),
      ),
    );
  }
}
