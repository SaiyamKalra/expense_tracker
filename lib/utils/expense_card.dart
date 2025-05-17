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
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: const Color.fromARGB(255, 196, 51, 209))],
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 33, 229, 243).withAlpha(100),
            const Color.fromARGB(255, 14, 196, 246).withAlpha(100),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ExpansionTile(
        title: Column(
          children: [
            Text(amount.toUpperCase()),
            SizedBox(height: 10),
            Text(date),
            Row(children: [Text(amount)]),
          ],
        ),
      ),
    );
  }
}
