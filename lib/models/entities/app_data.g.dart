// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppDataAdapter extends TypeAdapter<AppData> {
  @override
  final int typeId = 0;

  @override
  AppData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppData(
      themeMode: fields[1] as CustomThemeMode,
      user: fields[0] as User,
      fcmToken: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AppData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.user)
      ..writeByte(1)
      ..write(obj.themeMode)
      ..writeByte(2)
      ..write(obj.fcmToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
