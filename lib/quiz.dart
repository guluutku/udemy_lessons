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
  final List<String> selectedAnswer = [];
  String activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chosenAnswer(String answer) {
    selectedAnswer.add(answer);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: CustomDecoratedBox(
          child: activeScreen == 'start-screen'
              ? StartScreen(startQuiz: switchScreen)
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: QuestionsScreen(chosenAnswer: chosenAnswer,),
                ),
        ),
      ),
    );
  }
}
