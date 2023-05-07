import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.selectedAnswers});

  final List<String> selectedAnswers;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('AAAAAAAAAAA'),
          TextButton(
            onPressed: () {},
            child: const Text('Restart Quiz'),
          )
        ],
      ),
    );
  }
}
