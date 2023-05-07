import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:udemy_lessons/data/questions.dart';
import 'package:udemy_lessons/questions_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.chosenAnswers});

  final List<String> chosenAnswers;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question_text': questions[i].questionText,
        'correct_answer': questions[i].answers[0],
        'chosen_answer': chosenAnswers[i],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QuestionsSummary(summaryData: getSummaryData()),
          TextButton(
            onPressed: () {},
            child: const Text('Restart Quiz'),
          )
        ],
      ),
    );
  }
}
