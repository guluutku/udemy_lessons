import 'package:flutter/material.dart';
import 'package:udemy_lessons/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({
    super.key,
    required this.onExpenseAdded,
  });

  final void Function(Expense expense) onExpenseAdded;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _submitData() {
    final enteredAmount = double.tryParse(_amountController.text);
    if (_titleController.text.trim().isEmpty ||
        enteredAmount == null ||
        enteredAmount <= 0 ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please correct inputs are entered'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx), child: const Text('Close'))
          ],
        ),
      );
      return;
    }
    widget.onExpenseAdded(Expense(
      title: _titleController.text,
      amount: enteredAmount,
      purchasedDate: _selectedDate!,
      category: _selectedCategory,
    ));
  }

  void _presentDatePicker() async {
    final currentDate = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate == null ? currentDate : _selectedDate!,
      firstDate: DateTime(currentDate.year - 1),
      lastDate: currentDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _titleController;
    _amountController;
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom; // Contains extra data of overlapping UI elements. Now access bottom UI elements
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'No Date Selected'
                              : dateFormatter.format(_selectedDate!),
                        ),
                        IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(Icons.calendar_month),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  categorySelection(),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _submitData();
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownButton<Category> categorySelection() {
    return DropdownButton(
      value: _selectedCategory,
      items: Category.values
          .map((category) => DropdownMenuItem(
                value: category,
                child: Text(
                  category.name.toUpperCase(),
                ),
              ))
          .toList(),
      onChanged: (value) {
        if (value == null) {
          return;
        }
        setState(() {
          _selectedCategory = value;
        });
      },
    );
  }
}
