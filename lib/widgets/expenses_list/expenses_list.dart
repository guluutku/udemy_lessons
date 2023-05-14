import 'package:flutter/material.dart';
import 'package:udemy_lessons/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expense});

  final List<Expense> expense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
        itemBuilder: (context, index) => Text(expense[index].title));
  }
}
