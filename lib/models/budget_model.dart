import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'custom_time_period.dart';

part 'budget_model.g.dart';

@HiveType(typeId: 4, adapterName: "BudgetAdapter")
class Budget extends HiveObject {
  @HiveField(0)
  Category? category;

  @HiveField(1)
  double? amount;

  @HiveField(2)
  CustomTimePeriod? period;

  @HiveField(7)
  double? salary;

  @HiveField(6)
  List<Category>? categories;

  @HiveField(4)
  DateTime? startDate;

  @HiveField(5)
  DateTime? endDate;

  @HiveField(3)
  DateTime? created;
}
