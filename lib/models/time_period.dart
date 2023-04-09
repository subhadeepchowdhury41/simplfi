import 'package:hive/hive.dart';

part 'time_period.g.dart';

@HiveType(typeId: 2)
enum TimePeriod {
  @HiveField(0)
  weekly,

  @HiveField(1)
  monthly,

  @HiveField(2)
  quaterly,

  @HiveField(3)
  halfyearly,

  @HiveField(4)
  annualy
}