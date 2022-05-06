// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_theme_mode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomThemeModeAdapter extends TypeAdapter<CustomThemeMode> {
  @override
  final int typeId = 2;

  @override
  CustomThemeMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CustomThemeMode.light;
      case 1:
        return CustomThemeMode.dark;
      default:
        return CustomThemeMode.light;
    }
  }

  @override
  void write(BinaryWriter writer, CustomThemeMode obj) {
    switch (obj) {
      case CustomThemeMode.light:
        writer.writeByte(0);
        break;
      case CustomThemeMode.dark:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomThemeModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
