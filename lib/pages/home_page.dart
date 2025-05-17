import 'package:expense_tracker/cubit/expense_cubit.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/pages/add_expense_page.dart';
import 'package:expense_tracker/pages/profile_page.dart';
import 'package:expense_tracker/utils/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> filters = const [
    'All',
    'Food',
    'Transport',
    'Bills',
    'Shopping',
  ];
  late String selectedState;

  @override
  void initState() {
    super.initState();
    selectedState = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 400,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: const Color.fromARGB(255, 196, 51, 209)),
                ],
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 33, 229, 243).withAlpha(100),
                    const Color.fromARGB(255, 14, 196, 246).withAlpha(100),
                  ],
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expense \n  Tracker',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 55,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 40,
                            horizontal: 20,
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProfilePage(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.person_2_outlined,
                              color: Colors.white,
                              size: 55,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Total',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    BlocBuilder<ExpenseCubit, List<Expense>>(
                      builder: (context, expenses) {
                        if (expenses.isEmpty) {
                          return Text(
                            '0',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        final totalAmount = expenses.fold<double>(
                          0.0,
                          (sum, expense) =>
                              sum + (double.tryParse(expense.amount) ?? 0.0),
                        );
                        return Text(
                          totalAmount.toStringAsFixed(2),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: filters.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedState = filter;
                      });
                    },
                    child: Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor:
                          selectedState == filter ? Colors.amber : Colors.white,
                      label: Text(filter),
                      labelStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ExpenseCubit, List<Expense>>(
              builder: (context, expenses) {
                if (expenses.isEmpty) {
                  return Text('Please Enter your daily Expenses');
                }
                return ListView.builder(
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    final expense = expenses[index];
                    return Dismissible(
                      key: Key(expense.amount),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        height: 20,
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.delete),
                      ),
                      child: ExpenseCard(
                        amount: expense.amount,
                        date: expense.date.toIso8601String(),
                        category: expense.category,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExpensePage()),
          );
        },
        backgroundColor: Colors.transparent,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 33, 229, 243).withAlpha(100),
                const Color.fromARGB(255, 14, 196, 246).withAlpha(100),
              ],
            ),
            boxShadow: [
              BoxShadow(color: const Color.fromARGB(255, 196, 51, 209)),
            ],
          ),
          alignment: Alignment.center,
          child: Text('+', style: TextStyle(fontSize: 30, color: Colors.white)),
        ),
      ),
    );
  }
}
