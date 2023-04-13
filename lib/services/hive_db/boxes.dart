import 'package:hive/hive.dart';
import 'package:simplfi/models/budget_model.dart';
import 'package:simplfi/models/category_model.dart';
import 'package:simplfi/models/expense_model.dart';

class Boxes {
  static const String _categoryBox = 'categoryBox';
  static const String _budgetBox = 'budgetBox';
  static const String _expenseBox = 'expenseBox';

  Future<void> openAllBoxes() async {
    await Hive.openBox(_categoryBox);
    await Hive.openBox(_budgetBox);
    await Hive.openBox(_expenseBox);
  }

  static Box<Category> getCategories()
    => Hive.box<Category>(_categoryBox);
  static Box<Budget> getBudgets()
    => Hive.box<Budget>(_budgetBox);
  static Box<Expense> getExpenses()
    => Hive.box<Expense>(_expenseBox);

  
}