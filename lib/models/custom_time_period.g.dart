// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_time_period.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomTimePeriodAdapter extends TypeAdapter<CustomTimePeriod> {
  @override
  final int typeId = 2;

  @override
  CustomTimePeriod read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomTimePeriod(
      interval: fields[0] as int?,
      period: fields[1] as TimePeriod?,
    );
  }

  @override
  void write(BinaryWriter writer, CustomTimePeriod obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.period)
      ..writeByte(0)
      ..write(obj.interval);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomTimePeriodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
