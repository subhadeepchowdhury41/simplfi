import 'package:hive/hive.dart';
import 'package:simplfi/models/app_tokens.dart';
import 'package:simplfi/models/auth_user.dart';
import 'package:simplfi/models/budget_model.dart';
import 'package:simplfi/models/category_model.dart';
import 'package:simplfi/models/expense_model.dart';

class Boxes {
  static const String _categoryBox = 'categoryBox';
  static const String _budgetBox = 'budgetBox';
  static const String _expenseBox = 'expenseBox';
  static const String _authUserBox = 'authUserBox';
  static const String _appTokenBox = 'appTokenBox';

  static void registerBoxes() {
    Hive.registerAdapter(CategoryAdapter());
    Hive.registerAdapter(BudgetAdapter());
    Hive.registerAdapter(ExpenseAdapter());
    Hive.registerAdapter(AuthUserAdapter());
    Hive.registerAdapter(AppTokensAdapter());
  }

  static Future<void> openAllBoxes() async {
    await Hive.openBox<CategoryModel>(_categoryBox);
    await Hive.openBox<Budget>(_budgetBox);
    await Hive.openBox<Expense>(_expenseBox);
    await Hive.openBox<AuthUser>(_authUserBox);
    await Hive.openBox<AppTokens>(_appTokenBox);
  }

  static Box<CategoryModel> getCategoriesBox() =>
      Hive.box<CategoryModel>(_categoryBox);
  static Box<Budget> getBudgetsBox() => Hive.box<Budget>(_budgetBox);
  static Box<Expense> getExpensesBox() => Hive.box<Expense>(_expenseBox);
  static Box<AuthUser> getAuthUserBox() => Hive.box<AuthUser>(_authUserBox);
  static Box<AppTokens> getAppTokenBox() => Hive.box<AppTokens>(_appTokenBox);
}
