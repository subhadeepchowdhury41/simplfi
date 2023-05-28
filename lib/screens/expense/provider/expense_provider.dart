import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/screens/dashboard/repo/budget_repository.dart';
import 'package:simplfi/screens/expense/repo/expense_repository.dart';
import '../../../models/expense_model.dart';

class ExpenseNotifier extends StateNotifier<List<Expense>> {
  ExpenseNotifier() : super([]);

  final expenseRepo = ExpenseRepository();
  final budgetRepo = BudgetRepo();

  void initializeExpenses() {
    state = expenseRepo.getAllExpenses();
  }

  Future<void> addExpense(Expense expense) async {
    try {
      await expenseRepo.addExpense(expense).then((value) {
        state = [...state, expense];
      });
    } catch (e) {
      debugPrint('Problem in add expenses: $e');
    }
  }

  Future<void> updateExpense(Expense expense) async {
    int index = state.indexWhere((element) => element.id == expense.id);
    if (index == -1) {
      return;
    }
    List<Expense> list = state;
    list[index] = expense;
    state = list;

    try {
      await expenseRepo.updateExpense(expense.id!, expense);
    } catch (e) {
      debugPrint('Problem in update expenses: $e');
    }
  }

  void deleteExpense(Expense expense) async {
    List<Expense> list = state;
    list.removeWhere((element) => element.id == expense.id);
    state = list;

    try {
      await expenseRepo.deleteExpense(expense.id!);
    } catch (e) {
      debugPrint('Problem in delete expenses: $e');
    }
  }
}

final expenseProvider = StateNotifierProvider<ExpenseNotifier, List<Expense>>(
    (ref) => ExpenseNotifier());
