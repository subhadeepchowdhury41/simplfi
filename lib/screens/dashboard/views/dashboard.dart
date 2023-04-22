import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:simplfi/models/budget_model.dart';
import 'package:simplfi/screens/category/views/screens/add_categories_screen.dart';
import 'package:simplfi/screens/expense/views/screens/add_expense_screen.dart';
import 'package:simplfi/widgets/budget_expense_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          /// Budget Graph -------- update button(Go to update budget screen)
          /// Expenses  --------- add expenses button

          Expanded(
              flex: 2,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  StreamBuilder(
                    stream: Hive.box<Budget>('budgetBox').watch(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data.runtimeType.toString());
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddExpenseScreen()));
                      },
                      child: const Text('click'))
                ],
              )),
          Expanded(
              flex: 7,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [],
              ))
        ],
      ),
    );
  }
}
