import 'package:hive/hive.dart';
import 'package:simplfi/models/time_period.dart';
part 'custom_time_period.g.dart';

@HiveType(typeId: 2)
class CustomTimePeriod {
  @HiveField(1)
  TimePeriod? period;

  CustomTimePeriod({this.interval, this.period});

  @HiveField(0)
  int? interval;
}
