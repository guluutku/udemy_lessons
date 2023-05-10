import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary({super.key, required this.summaryData});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            return Row(
              children: [
                Text(
                  '${(data['question_index'] as int) + 1}',
                  style: customTextStyle(),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${data['question_text']}',
                        style: customTextStyle(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${data['correct_answer']}',
                        style: customTextStyle(),
                      ),
                      Text(
                        '${data['chosen_answer']}',
                        style: customTextStyle(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  TextStyle customTextStyle() {
    return TextStyle(
      color: Colors.white,
    );
  }
}
