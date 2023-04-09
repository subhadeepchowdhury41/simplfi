import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simplfi/models/budget_model.dart';
import 'package:simplfi/models/category_model.dart';
import 'package:simplfi/models/expense_model.dart';
import 'package:simplfi/screens/dashboard/views/dashboard.dart';

Future<void> main() async {
  await Hive.initFlutter();

  
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(BudgetAdapter());
  Hive.registerAdapter(ExpenseAdapter());

  runApp(const SimplFi());
}

class SimplFi extends StatelessWidget {
  const SimplFi({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SimplFi',
      home: Dashboard(),
    );
  }
}

