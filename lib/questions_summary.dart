import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary({super.key, required this.summaryData});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: summaryData.map((data) {
              return Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: data['is_correct'] == true
                              ? Colors.green
                              : Colors.red,
                        ),
                        child: Text(
                          '${(data['question_index'] as int) + 1}',
                          style: customTextStyle(),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '${data['question_text']}',
                              style: customTextStyle(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${data['correct_answer']}',
                              style: customTextStyle(),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${data['chosen_answer']}',
                              style: TextStyle(
                                color: data['is_correct'] == true
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.amber,
                    height: 30,
                  ),
                ],
              );
            }).toList(),
          ),
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
