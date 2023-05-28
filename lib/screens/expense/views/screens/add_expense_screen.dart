import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/models/category_model.dart';
import 'package:simplfi/models/expense_model.dart';
import 'package:simplfi/screens/dashboard/provider/budget_provider.dart';
import 'package:simplfi/screens/expense/provider/expense_provider.dart';
import 'package:simplfi/screens/expense/repo/expense_repository.dart';
import 'package:simplfi/screens/expense/views/widgets/category_selector.dart';
import 'package:uuid/uuid.dart';

class AddExpenseScreen extends ConsumerStatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  CategoryModel? _selectedCategory;

  @override
  void initState() {
    super.initState();
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
        categoryId: _selectedCategory!.id,
        categoryName: _selectedCategory!.name,
        dateTime: dateTime);
    await ref
        .read(expenseProvider.notifier)
        .addExpense(expense)
        .then((value) async {
      await ref.read(budgetProvider.notifier).addExpense(expense).then((value) {
        debugPrint('Done adding');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoriesList =
        ref.watch(budgetProvider.notifier).getCategoryList() ?? [];
    _selectedCategory = categoriesList[0];
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
                validator: (value) {
                  if (_selectedCategory == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
                builder: (FormFieldState fieldState) {
                  return Column(
                    children: [
                      Card(
                        child: CategorySelector(
                          onCategorySelected: (category) {
                              _selectedCategory = category;
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
                    await _submitExpense();
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
