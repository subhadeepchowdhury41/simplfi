import 'package:hive/hive.dart';
part 'time_period.g.dart';

@HiveType(typeId: 7, adapterName: "TimePeriodAdapter")
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
