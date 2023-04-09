import 'package:flutter/foundation.dart';
import 'package:simplfi/models/time_period.dart';
import 'package:hive/hive.dart';

part 'budget_model.g.dart';

@HiveType(typeId: 4, adapterName: "BudgetAdapter")
class Budget extends HiveObject {
  @HiveField(0)
  Category? category;

  @HiveField(1)
  double? amount;

  @HiveField(2)
  TimePeriod? period;

  @HiveField(3)
  DateTime? created;
}