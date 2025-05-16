import 'package:expense_tracker/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                child: Row(
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
                          size: 75,
                        ),
                      ),
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
        ],
      ),
    );
  }
}
