import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/providers/budget_riverpod.dart';
import 'package:simplfi/screens/category/views/screens/add_categories_screen.dart';
import 'package:simplfi/screens/expense/views/screens/add_expense_screen.dart';
import 'package:simplfi/widgets/budget_expense_card.dart';
import 'package:simplfi/widgets/chart.dart';

import '../../expense/views/screens/expenses_screen.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});
  Future<void> _initializeBudget(WidgetRef ref) async {
    await ref.read(budgetProvider.notifier).initialize().then((value) {
      return;
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SimplFi'),
        actions: [],
      ),
      body: FutureBuilder(
        future: _initializeBudget(ref),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              /// Budget Graph -------- update button(Go to update budget screen)
              /// Expenses  --------- add expenses button

              // BarChartSample2(ref: ref),

              // Expanded(
              //   flex: 2,
              //   child: ListView(
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     children: [
              //       const BudgetExpenseCard(
              //           budget: 0.0,
              //           categoryName: 'categoryName',
              //           expense: 0.0),
              //
              //     ],
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddCategoryScreen()));
                    },
                    child: const Text('Add Category'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExpensesScreen()));
                      },
                      child: Text('Expenses')),
                ],
              ),
              Expanded(
                flex: 7,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
