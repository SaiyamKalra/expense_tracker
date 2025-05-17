import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({
    super.key,
    required this.amount,
    required this.date,
    required this.category,
  });

  final String amount;
  final String date;
  final String category;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
          borderRadius: BorderRadius.circular(16),
        ),
        child: ExpansionTile(
          title: Row(
            children: [
              Column(
                children: [
                  Text(
                    category.toUpperCase(),
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(date, style: TextStyle(color: Colors.white)),
                ],
              ),
              SizedBox(width: 7),
              Icon(Icons.currency_rupee_sharp, color: Colors.white),
              SizedBox(width: 2),
              Text(amount, style: TextStyle(color: Colors.white, fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
