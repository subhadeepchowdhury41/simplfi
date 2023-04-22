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
      ..amount = fields[0] as double?
      ..period = fields[1] as CustomTimePeriod?
      ..salary = fields[2] as double?
      ..categories = (fields[3] as List?)?.cast<CategoryModel>()
      ..startDate = fields[4] as DateTime?
      ..endDate = fields[5] as DateTime?
      ..created = fields[6] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, Budget obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.period)
      ..writeByte(2)
      ..write(obj.salary)
      ..writeByte(3)
      ..write(obj.categories)
      ..writeByte(4)
      ..write(obj.startDate)
      ..writeByte(5)
      ..write(obj.endDate)
      ..writeByte(6)
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
