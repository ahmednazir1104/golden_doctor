// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartListModelAdapter extends TypeAdapter<CartListModel> {
  @override
  final int typeId = 0;

  @override
  CartListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartListModel(
      cartList: (fields[0] as List?)?.cast<CartModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, CartListModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.cartList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CartModelAdapter extends TypeAdapter<CartModel> {
  @override
  final int typeId = 1;

  @override
  CartModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartModel(
      productName: fields[0] as String?,
      productId: fields[1] as String?,
      productColor: fields[2] as String?,
      productSize: fields[3] as String?,
      varientId: fields[4] as String?,
      productImage: fields[5] as String?,
      productPrice: fields[6] as String?,
      quantity: fields[7] as String?,
      comparePrice: fields[8] as String?,
      sku: fields[9] as String?,
      available: fields[10] as bool?,
      userId: fields[11] as String?,
      vendor: fields[12] as String?,
      isEmbroidery: fields[13] as bool?,
      embroideryOptions: fields[14] as EmbroideryOptions?,
    );
  }

  @override
  void write(BinaryWriter writer, CartModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.productName)
      ..writeByte(1)
      ..write(obj.productId)
      ..writeByte(2)
      ..write(obj.productColor)
      ..writeByte(3)
      ..write(obj.productSize)
      ..writeByte(4)
      ..write(obj.varientId)
      ..writeByte(5)
      ..write(obj.productImage)
      ..writeByte(6)
      ..write(obj.productPrice)
      ..writeByte(7)
      ..write(obj.quantity)
      ..writeByte(8)
      ..write(obj.comparePrice)
      ..writeByte(9)
      ..write(obj.sku)
      ..writeByte(10)
      ..write(obj.available)
      ..writeByte(11)
      ..write(obj.userId)
      ..writeByte(12)
      ..write(obj.vendor)
      ..writeByte(13)
      ..write(obj.isEmbroidery)
      ..writeByte(14)
      ..write(obj.embroideryOptions);
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

class EmbroideryOptionsAdapter extends TypeAdapter<EmbroideryOptions> {
  @override
  final int typeId = 2;

  @override
  EmbroideryOptions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmbroideryOptions(
      tags: (fields[0] as List?)?.cast<String>(),
      line1: fields[1] as String?,
      line2: fields[2] as String?,
      position: fields[3] as String?,
      color: fields[4] as String?,
      font: fields[5] as String?,
      parentId: fields[6] as String?,
      parentTitle: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EmbroideryOptions obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.tags)
      ..writeByte(1)
      ..write(obj.line1)
      ..writeByte(2)
      ..write(obj.line2)
      ..writeByte(3)
      ..write(obj.position)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.font)
      ..writeByte(6)
      ..write(obj.parentId)
      ..writeByte(7)
      ..write(obj.parentTitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmbroideryOptionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
