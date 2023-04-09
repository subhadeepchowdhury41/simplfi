import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'category_model.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 5, adapterName: "ExpenseAdapter")
class Expense extends HiveObject {
  
  Expense({
    this.id,
    this.amount,
    this.category,
    this.created,
    this.item
  });

  @HiveField(0)
  Category? category;

  @HiveField(1)
  CategoryItem? item;

  @HiveField(3)
  double? amount;

  @HiveField(4)
  DateTime? created;

  @HiveField(5)
  String? id = const Uuid().v4();

  Expense copyWith({
    Category? category,
    CategoryItem? item,
    double? amount,
    DateTime? created,
  }) {
    return Expense(
      category: category ?? this.category,
      item: item ?? this.item,
      amount: amount ?? this.amount,
      created: created ?? this.created,
    );
  }
}
