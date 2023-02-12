// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BarcodeAdapter extends TypeAdapter<Barcode> {
  @override
  final int typeId = 0;

  @override
  Barcode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Barcode(
      id: fields[2] as int,
      imagePath: fields[0] as String,
      isFavorit: fields[3] as bool,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Barcode obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.imagePath)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.isFavorit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarcodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
