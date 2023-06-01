import 'package:flutter/material.dart';
import 'package:udemy_lessons/widgets/chart/chart.dart';
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
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context)
        .clearSnackBars(); // Removes previous snackbar if a new snackbar shown
    // Shows snackbar
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 5),
      content: const Text('Expense Deleted'),
      // Snackbar Button
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        },
      ),
    ));
  }

  void _addExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true, // Safe area for bottom sheet
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onExpenseAdded: _addExpenses,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
      body: width < 600 ? portraitModeBody : landScapeModeBody,
    );
  }

  Widget get portraitModeBody {
    return _registeredExpenses.isNotEmpty
        ? Center(
            child: Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: ExpensesList(
                    expense: _registeredExpenses,
                    removeExpense: _removeExpense,
                  ),
                ),
              ],
            ),
          )
        : const Center(
            child: Text('No Expense'),
          );
  }

  Widget get landScapeModeBody {
    return _registeredExpenses.isNotEmpty
        ? Center(
            child: Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(
                  child: ExpensesList(
                    expense: _registeredExpenses,
                    removeExpense: _removeExpense,
                  ),
                ),
              ],
            ),
          )
        : const Center(
            child: Text('No Expense'),
          );
  }
}
