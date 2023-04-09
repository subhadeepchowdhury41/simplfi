// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_period.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimePeriodAdapter extends TypeAdapter<TimePeriod> {
  @override
  final int typeId = 2;

  @override
  TimePeriod read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TimePeriod.weekly;
      case 1:
        return TimePeriod.monthly;
      case 2:
        return TimePeriod.quaterly;
      case 3:
        return TimePeriod.halfyearly;
      case 4:
        return TimePeriod.annualy;
      default:
        return TimePeriod.weekly;
    }
  }

  @override
  void write(BinaryWriter writer, TimePeriod obj) {
    switch (obj) {
      case TimePeriod.weekly:
        writer.writeByte(0);
        break;
      case TimePeriod.monthly:
        writer.writeByte(1);
        break;
      case TimePeriod.quaterly:
        writer.writeByte(2);
        break;
      case TimePeriod.halfyearly:
        writer.writeByte(3);
        break;
      case TimePeriod.annualy:
        writer.writeByte(4);
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
