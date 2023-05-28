import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/models/budget_model.dart';
import 'package:simplfi/models/expense_model.dart';
import 'package:simplfi/screens/dashboard/repo/budget_repository.dart';
import '../../../models/category_model.dart';

class BudgetNotifier extends StateNotifier<Budget?> {
  BudgetNotifier() : super(null);

  Future<void> initialize() async {
    await BudgetRepo.getBudget().then((budget) {
      if (budget != null) {
        state = budget;
      } else {
        state = Budget(
          amount: 0.0,
          expense: 0.0,
          categories: [],
          created: DateTime.now(),
        );
      }
    });
  }

  Future<void> saveBudgetInLocalDB() async {
    await BudgetRepo.saveBudget(state!);
  }

  List<CategoryModel>? getCategoryList() {
    return [...?state!.categories];
  }

  Future<void> addCategory(CategoryModel category) async {
    state = state!.copyWith(categories: [...?state!.categories, category]);
    await saveBudgetInLocalDB();
  }

  Future<void> addExpense(Expense expense) async {
    state = state!.copyWith(
      expense: state!.expense! + expense.amount!,
        categories: state!.categories!.map((cat) {
      if (cat.id == expense.categoryId) {
        cat.expense = cat.expense! + expense.amount!;
      }
      return cat;
    }).toList());
    await saveBudgetInLocalDB();
  }

  Future<void> updateCategory(CategoryModel categoryModel) async {
    int? index = state!.categories
        ?.indexWhere((element) => element.id == categoryModel.id);
    if (index == null || index == -1) {
      return;
    }
    List<CategoryModel> list = state!.categories!;
    list[index] = categoryModel;
    state?.copyWith(categories: list);

    await saveBudgetInLocalDB();
  }

  Future<void> deleteCategory(CategoryModel categoryModel) async {
    List<CategoryModel> list = state!.categories!;
    list.removeWhere((element) => element.id == categoryModel.id);
    state?.copyWith(categories: list);
    await saveBudgetInLocalDB();
  }
}

final budgetProvider = StateNotifierProvider<BudgetNotifier, Budget?>((ref) {
  return BudgetNotifier();
});
