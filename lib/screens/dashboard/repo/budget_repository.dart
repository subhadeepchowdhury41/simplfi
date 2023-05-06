import 'package:hive/hive.dart';
import '../../../models/budget_model.dart';
import '../../../services/hive_db/boxes.dart';

class BudgetRepo {
  static Future<void> saveBudget(Budget budget) async {
    Box budgetBox = Boxes.getBudgetsBox();
    await budgetBox.put('budget', budget);
  }

  static Future<Budget?> getBudget() async {
    Box budgetBox = Boxes.getBudgetsBox();
    try {
      return budgetBox.get('budget');
    } catch (e) {
      return null;
    }
  }
}
