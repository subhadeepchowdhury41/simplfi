import 'package:hive/hive.dart';
import 'package:simplfi/models/budget_model.dart';
import 'package:simplfi/models/category_model.dart';
import 'package:simplfi/models/expense_model.dart';

class Boxes {
  static const String _categoryBox = 'categoryBox';
  static const String _budgetBox = 'budgetBox';
  static const String _expenseBox = 'expenseBox';

  static Future<void> openAllBoxes() async {
    await Hive.openBox<Category>(_categoryBox);
    await Hive.openBox<Budget>(_budgetBox);
    await Hive.openBox<Expense>(_expenseBox);
  }

  static Box<Category> getCategoriesBox()
    => Hive.box<Category>(_categoryBox);
  static Box<Budget> getBudgetsBox()
    => Hive.box<Budget>(_budgetBox);
  static Box<Expense> getExpensesBox()
    => Hive.box<Expense>(_expenseBox);
  
}