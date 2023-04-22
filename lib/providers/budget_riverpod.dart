import 'package:flutter/src/foundation/annotations.dart';
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
        state = Budget();
      }
    });
  }

  List<Category>? getCategoryList() {
    return state!.categories;
  }
}
