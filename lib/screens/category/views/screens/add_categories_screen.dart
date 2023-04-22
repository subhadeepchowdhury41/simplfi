import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/models/category_model.dart';
import 'package:simplfi/providers/budget_riverpod.dart';
import 'package:simplfi/screens/category/repo/category_repository.dart';
import 'package:uuid/uuid.dart';

import '../../../../models/expense_model.dart';
import '../../../expense/repo/expense_repository.dart';

class AddCategoryScreen extends ConsumerWidget {
  AddCategoryScreen({super.key});

  final TextEditingController _categoryName = TextEditingController();

  final TextEditingController _categoryBudget = TextEditingController();

  final TextEditingController _categoryInterval = TextEditingController();

  final CategoryRepository _repo = CategoryRepository();

  Future<void> onSubmit(WidgetRef ref) async {
    await ref
        .read(budgetProvider.notifier)
        .addNewCategory(
          CategoryModel(
            budget: double.parse(_categoryBudget.text),
            expense: 0,
            name: _categoryName.text,
            id: const Uuid().v4(),
          ),
        )
        .then(
      (value) async {
        // List<CategoryModel>? list =
        //     ref.read(budgetProvider.notifier).getCategoryList();
        // for (CategoryModel model in list!) {
        //   debugPrint('${model.id}/ ${model.name}/ ${model.budget}');
        // }
      },
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
