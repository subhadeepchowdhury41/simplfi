import 'package:hive/hive.dart';

import 'time_period.g.dart';

@HiveType(typeId: 0)
enum TimePeriod {
  @HiveField(0)
  daily,

  @HiveField(1)
  weekly,

  @HiveField(2)
  monthly,

  @HiveField(3)
  quaterly,

  @HiveField(4)
  halfyearly,

  @HiveField(5)
  annual
}
