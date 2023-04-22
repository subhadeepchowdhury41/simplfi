import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simplfi/models/budget_model.dart';
import 'package:simplfi/models/category_model.dart';
import 'package:simplfi/models/expense_model.dart';
import 'package:simplfi/providers/budget_riverpod.dart';
import 'package:simplfi/screens/dashboard/views/dashboard.dart';
import 'package:simplfi/services/hive_db/boxes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);

  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(BudgetAdapter());
  Hive.registerAdapter(ExpenseAdapter());

  await Boxes.openAllBoxes();

  runApp(
    const ProviderScope(
      child: SimplFi(),
    ),
  );
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
