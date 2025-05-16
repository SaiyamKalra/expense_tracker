import 'package:expense_tracker/cubit/expense_cubit.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final List<String> category = ['Food', 'Transport', 'Bills', 'Shopping'];
  String? selectedCategory;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Text(
            'A D D  E X P E N S E',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 60,
              child: DropdownButton<String>(
                hint: Text('Select Category'),
                value: selectedCategory,
                items:
                    category.map((String categories) {
                      return DropdownMenuItem<String>(
                        value: categories,
                        child: Text(categories),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  final amountText = _amountController.text.trim();
                  final descriptionText = _descriptionController.text.trim();
                  if (selectedCategory == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select a Category')),
                    );
                  } else if (amountText.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter the Amount.')),
                    );
                  } else if (descriptionText.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter a Description.')),
                    );
                  } else {
                    final newExpense = Expense(
                      amount: amountText,
                      description: descriptionText,
                      category: selectedCategory!,
                      date: DateTime.now(),
                    );
                    BlocProvider.of<ExpenseCubit>(
                      context,
                    ).addExpense(newExpense);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Expense'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
