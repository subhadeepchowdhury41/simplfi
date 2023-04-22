import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/models/budget_model.dart';
import 'package:simplfi/screens/category/repo/category_repository.dart';
import 'package:simplfi/screens/dashboard/repo/budget_repository.dart';

import '../models/category_model.dart';

class BudgetRiverpod extends StateNotifier<Budget?> {
  BudgetRiverpod() : super(null);

  Future<void> initialize() async {
    await HiveServices.getBudget().then((budget) {
      if (budget != null) {
        state = budget;
      } else {
        state = Budget(
          amount: 0.0,
          categories: [],
          created: DateTime.now(),
        );
      }
    });
  }

  Future<void> saveBudgetInLocalDB() async {
    await HiveServices.saveBudget(state!);
  }

  List<CategoryModel>? getCategoryList() {
    return [...?state!.categories];
  }

  Future<void> addNewCategory(CategoryModel category) async {
    state = state!.copyWith(categories: [...?state!.categories, category]);
    await CategoryRepository().addCategory(category);
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

StateNotifierProvider<BudgetRiverpod, Budget?> budgetProvider =
    StateNotifierProvider<BudgetRiverpod, Budget?>((ref) {
  return BudgetRiverpod();
});
