import 'package:flutter/material.dart';
import 'package:udemy_lessons/answer_button.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'The Question....',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          AnswerButton(
            answerText: 'Answer1..',
            onPressed: () {},
          ),
          AnswerButton(
            answerText: 'Answer2..',
            onPressed: () {},
          ),
          AnswerButton(
            answerText: 'Answer3..',
            onPressed: () {},
          ),
          AnswerButton(
            answerText: 'Answer4..',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
