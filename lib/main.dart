import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simplfi/providers/budget_provider.dart';
import 'package:simplfi/providers/expense_provider.dart';
import 'package:simplfi/screens/dashboard/views/dashboard.dart';
import 'package:simplfi/services/hive_db/boxes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);

  Boxes.registerBoxes();
  await Boxes.openAllBoxes();

  runApp(
    const ProviderScope(
      child: SimplFi(),
    ),
  );
}

class SimplFi extends ConsumerStatefulWidget {
  const SimplFi({super.key});

  @override
  ConsumerState<SimplFi> createState() => _SimplFiState();
}

class _SimplFiState extends ConsumerState<SimplFi> {
  Future<void> _initializeBudget() async {
    await ref.read(budgetProvider.notifier).initialize().then((value) {
      ref.read(expenseProvider.notifier).initializeExpenses();
    });
  }

  Future<void> _init() async {
    await _initializeBudget();
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SimplFi',
      home: Dashboard(),
    );
  }
}
