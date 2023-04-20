// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_period.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimePeriodAdapter extends TypeAdapter<TimePeriod> {
  @override
  final int typeId = 7;

  @override
  TimePeriod read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TimePeriod.daily;
      case 1:
        return TimePeriod.weekly;
      case 2:
        return TimePeriod.monthly;
      case 3:
        return TimePeriod.quaterly;
      case 4:
        return TimePeriod.halfyearly;
      case 5:
        return TimePeriod.annual;
      default:
        return TimePeriod.daily;
    }
  }

  @override
  void write(BinaryWriter writer, TimePeriod obj) {
    switch (obj) {
      case TimePeriod.daily:
        writer.writeByte(0);
        break;
      case TimePeriod.weekly:
        writer.writeByte(1);
        break;
      case TimePeriod.monthly:
        writer.writeByte(2);
        break;
      case TimePeriod.quaterly:
        writer.writeByte(3);
        break;
      case TimePeriod.halfyearly:
        writer.writeByte(4);
        break;
      case TimePeriod.annual:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimePeriodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
