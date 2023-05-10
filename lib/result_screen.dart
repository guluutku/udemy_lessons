import 'package:flutter/material.dart';
import 'package:udemy_lessons/data/questions.dart';
import 'package:udemy_lessons/questions_summary.dart';
import 'package:udemy_lessons/quiz.dart';

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
        'is_correct': chosenAnswers[i] == questions[i].answers[0],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['chosen_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Correct: $numCorrectQuestions. Total: $numTotalQuestions',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summaryData: getSummaryData()),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        const Quiz(),
                  ),
                );
              },
              child: const Text('Restart Quiz'),
            )
          ],
        ),
      ),
    );
  }
}
