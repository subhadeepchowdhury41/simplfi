import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simplfi/models/budget_model.dart';
import 'package:simplfi/models/category_model.dart';
import 'package:simplfi/models/expense_model.dart';
import 'package:simplfi/screens/dashboard/views/dashboard.dart';

Future<void> main() async {
  final appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);

  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(BudgetAdapter());
  Hive.registerAdapter(ExpenseAdapter());

  await Hive.openBox<CategoryAdapter>('categoryBox');
  await Hive.openBox<BudgetAdapter>('budgetBox');
  await Hive.openBox<ExpenseAdapter>('expenseBox');

  runApp(const SimplFi());
}

class SimplFi extends StatelessWidget {
  const SimplFi({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SimplFi',
      home: Dashboard(),
    );
  }
}

