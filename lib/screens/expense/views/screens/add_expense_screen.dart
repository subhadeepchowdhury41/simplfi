import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simplfi/models/category_model.dart';
import 'package:simplfi/models/expense_model.dart';
import 'package:simplfi/screens/expense/repo/expense_repository.dart';
import 'package:simplfi/screens/expense/views/widgets/category_selector.dart';
import 'package:uuid/uuid.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final ExpenseRepository _repository = ExpenseRepository();
  late Expense _expense;
  late Category _selectedCategory;

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
    _selectedCategory = Category(
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
    _selectedCategory.expense += amount;
    await _repository.updateCategory(_selectedCategory);

    // Add expense
    await _repository.addExpense(expense);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16.0),
            const Text(
              'Select category',
            ),
            const SizedBox(height: 8.0),
            CategorySelector(
              onCategorySelected: (category) {
                setState(() {
                  _selectedCategory = category;
                });
              }, categories: [],
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _noteController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Note',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _submitExpense();
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
