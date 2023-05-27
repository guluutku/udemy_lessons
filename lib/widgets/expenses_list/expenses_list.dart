import 'package:flutter/material.dart';
import 'package:udemy_lessons/models/expense.dart';
import 'package:udemy_lessons/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expense});

  final List<Expense> expense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: (context, index) => ExpenseItem(expense: expense[index]),
    );
  }
}
