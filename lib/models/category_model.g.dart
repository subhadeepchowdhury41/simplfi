// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAdapter extends TypeAdapter<CategoryModel> {
  @override
  final int typeId = 0;

  @override
  CategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryModel(
      budget: fields[3] as double?,
      expense: fields[2] as double?,
      id: fields[4] as String?,
      item: fields[1] == null ? [] : (fields[1] as List?)?.cast<CategoryItem>(),
      name: fields[0] as String?,
      created: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.created)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.item)
      ..writeByte(2)
      ..write(obj.expense)
      ..writeByte(3)
      ..write(obj.budget);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ItemsAdapter extends TypeAdapter<CategoryItem> {
  @override
  final int typeId = 1;

  @override
  CategoryItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryItem()
      ..id = fields[3] as String?
      ..name = fields[0] as String?
      ..expense = fields[1] as double?
      ..budget = fields[2] as double?;
  }

  @override
  void write(BinaryWriter writer, CategoryItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.expense)
      ..writeByte(2)
      ..write(obj.budget);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
