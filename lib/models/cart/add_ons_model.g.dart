// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_ons_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddOnsAdapter extends TypeAdapter<AddOns> {
  @override
  final int typeId = 1;

  @override
  AddOns read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddOns(
      id: fields[0] as int,
      price: fields[1] as double,
      name: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddOns obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddOnsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
