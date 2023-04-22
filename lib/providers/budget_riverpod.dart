import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/models/budget_model.dart';
import 'package:simplfi/services/hive_db/hive_services.dart';

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

  void addNewCategoryList(List<CategoryModel> catList) {
    Budget nBudget = state!;
    nBudget.categories = catList;
    state = nBudget;
  }

  void updateCategory(CategoryModel categoryModel) {
    int? index = state!.categories
        ?.indexWhere((element) => element.id == categoryModel.id);
    if (index == null) {
      return;
    }
    List<CategoryModel> list = state!.categories!;
    // state.copyWith();
  }

  List<CategoryModel>? getCategoryList() {
    return state!.categories;
  }
}

StateNotifierProvider<BudgetRiverpod, Budget?> budgetProvider =
    StateNotifierProvider<BudgetRiverpod, Budget?>((ref) {
  return BudgetRiverpod();
});
