import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/screens/expense/repo/expense_repository.dart';
import '../../../models/expense_model.dart';

class ExpenseRiverpod extends StateNotifier<List<Expense>?> {
  ExpenseRiverpod() : super(null);

  Future<void> initializeExpenses() async {
    await ExpenseRepository().getAllExpenses().then((expenseList) {
      state = expenseList ?? [];
    });
  }

  List<Expense> getExpenseList() {
    return [...state!];
  }

  Future<void> addExpense(Expense expense) async {
    List<Expense> list = state!;
    list.add(expense);
    state = list;

    try {
      await ExpenseRepository().addExpense(expense);
    } catch (e) {
      debugPrint('Problem in add expenses: $e');
    }
  }

  Future<void> updateExpense(Expense expense) async {
    int index = state!.indexWhere((element) => element.id == expense.id);
    if (index == -1) {
      return;
    }
    List<Expense> list = state!;
    list[index] = expense;
    state = list;

    try {
      await ExpenseRepository().updateExpense(expense.id!, expense);
    } catch (e) {
      debugPrint('Problem in update expenses: $e');
    }
  }

  void deleteExpense(Expense expense) async {
    List<Expense> list = state!;
    list.removeWhere((element) => element.id == expense.id);
    state = list;

    try {
      await ExpenseRepository().deleteExpense(expense.id!);
    } catch (e) {
      debugPrint('Problem in delete expenses: $e');
    }
  }

  // Future<void> saveExpenses
}
