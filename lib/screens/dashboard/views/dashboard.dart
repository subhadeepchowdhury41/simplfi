import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/providers/budget_provider.dart';
import 'package:simplfi/providers/expense_provider.dart';
import 'package:simplfi/screens/category/views/screens/add_categories_screen.dart';
import '../../expense/views/screens/expenses_screen.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseList = ref.watch(expenseProvider);
    int index = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SimplFi'),
        actions: [],
      ),
      body: Column(
            children: [
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
                                builder: (context) => const ExpensesScreen()));
                      },
                      child: const Text('Expenses')),
                ],
              ),
              Expanded(
                flex: 7,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    AspectRatio(
                      aspectRatio: 2,
                      child: BarChart(BarChartData(
                        barGroups: expenseList.map<BarChartGroupData>((exp) {
                          return BarChartGroupData(
                              x: index++,
                              barRods: [BarChartRodData(toY: exp.amount!)]);
                        }).toList(),
                      )),
                    )
                  ],
                ),
              ),
            ],
          )
    );
  }
}
