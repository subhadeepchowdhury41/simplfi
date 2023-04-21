import 'package:hive/hive.dart';

import '../../models/budget_model.dart';
import '../../models/category_model.dart';
import '../../models/expense_model.dart';
import 'boxes.dart';

class HiveServices {
  /// <---------------------------- Budget ------------------------------------>
  static Future<void> saveBudget(Budget budget) async {
    Box budgetBox = Boxes.getBudgetsBox();
    await budgetBox.put('budget', budget);
  }

  static Future<Category?> getBudget() async {
    Box budgetBox = Boxes.getBudgetsBox();
    try {
      return budgetBox.get('budget');
    } catch (e) {
      return null;
    }
  }

  /// <-------------------------- Categories ---------------------------------->
  static Future<void> saveCategory(Category category) async {
    Box categoryBox = Boxes.getCategoriesBox();
    await categoryBox.put('category', category);
  }

  static Future<Category?> getCategory() async {
    Box categoryBox = Boxes.getCategoriesBox();
    try {
      return categoryBox.get('category');
    } catch (e) {
      return null;
    }
  }

  /// <---------------------------- Expenses ---------------------------------->
  static Future<void> saveExpense(Expense expense) async {
    Box expenseBox = Boxes.getExpensesBox();
    await expenseBox.put('expense', expense);
  }

  static Future<Expense?> getExpense(String id) async {
    Box expenseBox = Boxes.getExpensesBox();
    try {
      return expenseBox.get(id);
    } catch (e) {
      return null;
    }
  }
}
