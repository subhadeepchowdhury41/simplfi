import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:simplfi/models/category_model.dart';
import 'package:simplfi/models/expense_model.dart';
import 'package:simplfi/providers/budget_riverpod.dart';
import 'package:simplfi/screens/expense/repo/expense_repository.dart';
import 'package:simplfi/screens/expense/views/widgets/category_selector.dart';
import 'package:uuid/uuid.dart';

import '../../../dashboard/repo/budget_repository.dart';

class AddExpenseScreen extends ConsumerStatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final ExpenseRepository _repository = ExpenseRepository();
  late Expense _expense;
  late CategoryModel _selectedCategory;

  @override
  void initState() {
    super.initState();
    _expense = Expense(
      id: const Uuid().v4(),
      amount: 0,
      categoryId: '',
      categoryName: '',
      dateTime: DateTime.now(),
    );
    _selectedCategory = CategoryModel(
      id: const Uuid().v4(),
      budget: 0,
      expense: 0,
      name: '',
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _submitExpense() async {
    final double amount = double.parse(_amountController.text.trim());
    final String note = _noteController.text.trim();
    final DateTime dateTime = DateTime.now();

    final Expense expense = Expense(
      id: const Uuid().v4(),
      amount: amount,
      categoryId: _selectedCategory.id,
      categoryName: _selectedCategory.name,
      dateTime: dateTime,
    );

    // Update category expense
    _selectedCategory.expense = (_selectedCategory.expense! + amount);
    // await _repository.updateCategory(_selectedCategory);

    // Add expense
    await _repository.addExpense(expense);
  }

  Future<void> initializeCategoriesList() async {
    try {
      await HiveServices;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoriesList =
        ref.watch(budgetProvider.notifier).getCategoryList() ?? [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16.0),
              const Text(
                'Select category',
              ),
              const SizedBox(height: 8.0),
              FormField(
                initialValue: _selectedCategory,
                validator: (value) {},
                builder: (FormFieldState fieldState) {
                  return Column(
                    children: [
                      Card(
                        child: CategorySelector(
                          onCategorySelected: (category) {
                            setState(() {
                              _selectedCategory = category;
                            });
                            fieldState.didChange(_selectedCategory);
                          },
                          categories: categoriesList,
                        ),
                      ),
                      if (fieldState.hasError)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            fieldState.errorText!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                validator: (value) {
                  if (_amountController.text.isEmpty) {
                    return 'Please enter some Amount';
                  }
                  return null;
                },
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                validator: (value) {
                  if (_amountController.text.isEmpty) {
                    return 'Please enter some description';
                  }
                  return null;
                },
                controller: _noteController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Note',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // await _submitExpense();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
