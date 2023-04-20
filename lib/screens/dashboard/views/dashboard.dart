import 'package:flutter/material.dart';
import 'package:simplfi/screens/category/views/screens/add_category_screen.dart';
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
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  BudgetExpenseCard(
                      budget: 0.0, categoryName: 'categoryName', expense: 0.0),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddCategoryScreen()));
                      },
                      child: Text('Add'))
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
