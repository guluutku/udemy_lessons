import 'package:flutter/material.dart';
import 'package:udemy_lessons/widgets/expenses_list/expenses_list.dart';
import 'package:udemy_lessons/models/expense.dart';
import 'package:udemy_lessons/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter',
      amount: 18,
      purchasedDate: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 180,
      purchasedDate: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _addExpenses(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  void _addExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onExpenseAdded: _addExpenses,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(
            onPressed: _addExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Text('The chart'),
            Expanded(
                child: ExpensesList(
              expense: _registeredExpenses,
              removeExpense: _removeExpense,
            )),
          ],
        ),
      ),
    );
  }
}
