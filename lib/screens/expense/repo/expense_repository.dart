import 'package:simplfi/models/expense_model.dart';
import 'package:simplfi/services/hive_db/boxes.dart';

abstract class ExpenseRepositoryBluePrint {
  List<Expense> getAllExpenses();
  Future<Expense?> getExpense(String id);
  Future<void> addExpense(Expense expense);
  Future<void> deleteExpense(String id);
  Future<void> updateExpense(String id, Expense expense);
}

class ExpenseRepository implements ExpenseRepositoryBluePrint {
  final _expenseBox = Boxes.getExpensesBox();

  @override
  Future<void> addExpense(Expense expense) async {
    await _expenseBox.put(expense.id, expense);
  }

  @override
  Future<void> deleteExpense(String id) async {
    await _expenseBox.delete(id);
  }

  @override
  List<Expense> getAllExpenses() {
    return _expenseBox.values.toList();
  }

  @override
  Future<Expense?> getExpense(String id) async {
    return _expenseBox.get(id);
  }

  @override
  Future<void> updateExpense(String id, Expense expense) async {
    await _expenseBox.put(id, expense);
  }
}
