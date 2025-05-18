import 'package:expense_tracker/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _ExpenseSearchPageState();
}

class _ExpenseSearchPageState extends State<SearchPage> {
  final TextEditingController _searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExpenseBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'S E A R C H  P A G E',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 25.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 33, 229, 243).withAlpha(100),
                      const Color.fromARGB(255, 14, 196, 246).withAlpha(100),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(color: const Color.fromARGB(255, 196, 51, 209)),
                  ],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _searchcontroller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onChanged: (query) {
                    context.read<ExpenseBloc>().add(
                      ExpenseSearchQueryCharged(query),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
