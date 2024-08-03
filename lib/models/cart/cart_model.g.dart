// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartModelAdapter extends TypeAdapter<CartModel> {
  @override
  final int typeId = 0;

  @override
  CartModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartModel(
      productId: fields[0] as int,
      quantity: fields[1] as double,
      addOns: (fields[2] as List).cast<AddOns>(),
      price: fields[4] as double?,
      note: fields[3] as String?,
      discountPrice: fields[5] as double?,
      discountPercentage: fields[6] as double?,
      name: fields[7] as String,
      image: fields[8] as String,
      categoryName: fields[9] as String,
      soldBy: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CartModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.addOns)
      ..writeByte(3)
      ..write(obj.note)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.discountPrice)
      ..writeByte(6)
      ..write(obj.discountPercentage)
      ..writeByte(7)
      ..write(obj.name)
      ..writeByte(8)
      ..write(obj.image)
      ..writeByte(9)
      ..write(obj.categoryName)
      ..writeByte(10)
      ..write(obj.soldBy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
