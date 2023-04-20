import 'package:flutter/material.dart';
import 'package:simplfi/models/category_model.dart';
import 'package:simplfi/screens/category/repo/category_repository.dart';
import 'package:uuid/uuid.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController _categoryName = TextEditingController();
  final TextEditingController _categoryBudget = TextEditingController();
  final TextEditingController _categoryInterval = TextEditingController();

  final CategoryRepository _repo = CategoryRepository();

  Future<void> onSubmit() async {
    await _repo
        .addCategory(Category(
            budget: double.parse(_categoryBudget.text),
            expense: 0,
            name: _categoryName.text,
            id: const Uuid().v4()))
        .then((value) async {
      await _repo.getAllCategories().then((categories) {
        print(categories);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: onSubmit,
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
              child: DropdownButtonFormField(
                value: 'Weekly',
                onChanged: (val) {
                  _categoryInterval.text = val!;
                },
                items: ['Daily', 'Weekly', 'Monthy', 'Yearly', 'Custom']
                    .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(color: Colors.black),
                        )))
                    .toList(),
                style: const TextStyle(fontSize: 17),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    hintText: 'Category Type',
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
                )),
          ],
        ),
      ),
    );
  }
}
