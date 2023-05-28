import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/models/category_model.dart';
import 'package:simplfi/screens/dashboard/provider/budget_provider.dart';
import 'package:uuid/uuid.dart';

class AddCategoryScreen extends ConsumerWidget {
  AddCategoryScreen({super.key});

  final TextEditingController _categoryName = TextEditingController();
  final TextEditingController _categoryBudget = TextEditingController();
  final TextEditingController _notifyInterval = TextEditingController();

  Future<void> onSubmit(WidgetRef ref) async {
    final catId = const Uuid().v4();
    print(catId);
    await ref.read(budgetProvider.notifier).addCategory(
          CategoryModel(
            budget: double.parse(_categoryBudget.text),
            expense: 0.0,
            name: _categoryName.text,
            id: catId,
          ),
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => onSubmit(ref),
        child: const Text('Save'),
      ),
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: _categoryName,
                style: const TextStyle(fontSize: 17),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    hintText: 'Category Name',
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: _categoryBudget,
                decoration: const InputDecoration(hintText: 'Budget Amount'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
