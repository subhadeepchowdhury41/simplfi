// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_tokens.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppTokensAdapter extends TypeAdapter<AppTokens> {
  @override
  final int typeId = 10;

  @override
  AppTokens read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppTokens()..finVuToken = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, AppTokens obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.finVuToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTokensAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
