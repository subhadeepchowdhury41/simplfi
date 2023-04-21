// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BudgetAdapter extends TypeAdapter<Budget> {
  @override
  final int typeId = 4;

  @override
  Budget read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Budget()
      ..category = fields[0] as Category?
      ..amount = fields[1] as double?
      ..period = fields[2] as CustomTimePeriod?
      ..salary = fields[7] as double?
      ..categories = (fields[6] as List?)?.cast<Category>()
      ..startDate = fields[4] as DateTime?
      ..endDate = fields[5] as DateTime?
      ..created = fields[3] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, Budget obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.period)
      ..writeByte(7)
      ..write(obj.salary)
      ..writeByte(6)
      ..write(obj.categories)
      ..writeByte(4)
      ..write(obj.startDate)
      ..writeByte(5)
      ..write(obj.endDate)
      ..writeByte(3)
      ..write(obj.created);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BudgetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}