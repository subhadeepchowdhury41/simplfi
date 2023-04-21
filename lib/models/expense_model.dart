import 'package:hive/hive.dart';
part 'expense_model.g.dart';

@HiveType(typeId: 5, adapterName: "ExpenseAdapter")
class Expense extends HiveObject {
  Expense(
      {this.id,
      this.amount,
      this.categoryId,
      this.categoryName,
      this.dateTime});

  @HiveField(0)
  String? categoryId;

  @HiveField(6)
  String? categoryName;

  @HiveField(3)
  double? amount;

  @HiveField(4)
  DateTime? dateTime;

  @HiveField(5)
  String? id;
}
