import 'package:hive/hive.dart';
import 'category_model.dart';
import 'custom_time_period.dart';
part 'budget_model.g.dart';

@HiveType(typeId: 4, adapterName: "BudgetAdapter")
class Budget extends HiveObject {
  @HiveField(0)
  double? amount;

  @HiveField(8)
  double? expense;

  @HiveField(1)
  CustomTimePeriod? period;

  @HiveField(2)
  double? salary;

  @HiveField(3)
  List<CategoryModel>? categories;

  @HiveField(4)
  DateTime? startDate;

  @HiveField(5)
  DateTime? endDate;

  @HiveField(6)
  DateTime? created;

  @HiveField(7)
  CustomTimePeriod? notificationPeriod;

  Budget({
    this.amount,
    this.categories,
    this.endDate,
    this.created,
    this.period,
    this.salary,
    this.startDate,
    this.notificationPeriod,
    this.expense
  });

  Budget copyWith({
    double? amount,
    List<CategoryModel>? categories,
    DateTime? endDate,
    DateTime? created,
    CustomTimePeriod? period,
    double? salary,
    DateTime? startDate,
    double? expense,
    CustomTimePeriod? notificationPeriod,
  }) {
    return Budget(
      amount: amount ?? this.amount,
      categories: categories ?? this.categories,
      endDate: endDate ?? this.endDate,
      created: created ?? this.created,
      period: period ?? this.period,
      salary: salary ?? this.salary,
      startDate: startDate ?? this.startDate,
      notificationPeriod: notificationPeriod ?? this.notificationPeriod,
      expense: expense ?? this.expense
    );
  }
}
