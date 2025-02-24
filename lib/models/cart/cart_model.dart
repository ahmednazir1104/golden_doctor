// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'package:hive/hive.dart';
import 'dart:convert';

part 'cart_model.g.dart';




CartListModel cartListModelFromJson(String str) => CartListModel.fromJson(json.decode(str));

String cartListModelToJson(CartListModel data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class CartListModel {
    @HiveField(0)
    List<CartModel>? cartList;

    CartListModel({
        this.cartList,
    });

    factory CartListModel.fromJson(Map<String, dynamic> json) => CartListModel(
        cartList: json["cartList"] == null ? [] : List<CartModel>.from(json["cartList"]!.map((x) => CartModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "cartList": cartList == null ? [] : List<dynamic>.from(cartList!.map((x) => x.toJson())),
    };
}

@HiveType(typeId: 1)
class CartModel {
    @HiveField(0)
    String? productName;
    @HiveField(1)
    String? productId;
    @HiveField(2)
    String? productColor;
    @HiveField(3)
    String? productSize;
    @HiveField(4)
    String? varientId;
    @HiveField(5)
    String? productImage;
    @HiveField(6)
    String? productPrice;
    @HiveField(7)
    String? quantity;
    @HiveField(8)
    String? comparePrice;
    @HiveField(9)
    String? sku;
    @HiveField(10)
    bool? available;
    @HiveField(11)
    String? userId;
    @HiveField(12)
    String? vendor;
    @HiveField(13)
    bool? isEmbroidery;
    @HiveField(14)
    EmbroideryOptions? embroideryOptions;

    CartModel({
        this.productName,
        this.productId,
        this.productColor,
        this.productSize,
        this.varientId,
        this.productImage,
        this.productPrice,
        this.quantity,
        this.comparePrice,
        this.sku,
        this.available,
        this.userId,
        this.vendor,
        this.isEmbroidery,
        this.embroideryOptions,
    });

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        productName: json["productName"],
        productId: json["productId"],
        productColor: json["productColor"],
        productSize: json["productSize"],
        varientId: json["varientId"],
        productImage: json["productImage"],
        productPrice: json["productPrice"],
        quantity: json["quantity"],
        comparePrice: json["comparePrice"],
        sku: json["sku"],
        available: json["available"],
        userId: json["userId"],
        vendor: json["vendor"],
        isEmbroidery: json["isEmbroidery"],
        embroideryOptions: json["embroideryOptions"] == null ? null : EmbroideryOptions.fromJson(json["embroideryOptions"]),
    );

    Map<String, dynamic> toJson() => {
        "productName": productName,
        "productId": productId,
        "productColor": productColor,
        "productSize": productSize,
        "varientId": varientId,
        "productImage": productImage,
        "productPrice": productPrice,
        "quantity": quantity,
        "comparePrice": comparePrice,
        "sku": sku,
        "available": available,
        "userId": userId,
        "vendor": vendor,
        "isEmbroidery": isEmbroidery,
        "embroideryOptions": embroideryOptions?.toJson(),
    };
}

@HiveType(typeId: 2)
class EmbroideryOptions {
    @HiveField(0)
    List<String>? tags;
    @HiveField(1)
    String? line1;
    @HiveField(2)
    String? line2;
    @HiveField(3)
    String? position;
    @HiveField(4)
    String? color;
    @HiveField(5)
    String? font;
    @HiveField(6)
    String? parentId;
    @HiveField(7)
    String? parentTitle;

    EmbroideryOptions({
        this.tags,
        this.line1,
        this.line2,
        this.position,
        this.color,
        this.font,
        this.parentId,
        this.parentTitle,
    });

    factory EmbroideryOptions.fromJson(Map<String, dynamic> json) => EmbroideryOptions(
        tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
        line1: json["line1"],
        line2: json["line2"],
        position: json["position"],
        color: json["color"],
        font: json["font"],
        parentId: json["parent_id"],
        parentTitle: json["parent_title"],
    );

    Map<String, dynamic> toJson() => {
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "line1": line1,
        "line2": line2,
        "position": position,
        "color": color,
        "font": font,
        "parent_id": parentId,
        "parent_title": parentTitle,
    };
}
