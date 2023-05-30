import 'package:flutter/material.dart';
import 'package:udemy_lessons/models/expense.dart';
import 'package:udemy_lessons/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expense,
    required this.removeExpense,
  });

  final List<Expense> expense;

  final void Function(Expense expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: (context, index) => Dismissible(
        background: ColoredBox(
          //color: Colors.red,
          color: Theme.of(context).colorScheme.error,
        ),
        key: ValueKey(expense[index]),
        onDismissed: (direction) {
          removeExpense(expense[index]);
        },
        child: ExpenseItem(
          expense: expense[index],
        ),
      ),
    );
  }
}
