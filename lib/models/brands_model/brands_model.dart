// To parse this JSON data, do
//
//     final brandsModel = brandsModelFromJson(jsonString);

import 'dart:convert';

BrandsModel brandsModelFromJson(String str) =>
    BrandsModel.fromJson(json.decode(str));

String brandsModelToJson(BrandsModel data) => json.encode(data.toJson());

class BrandsModel {
  final List<SingleBrand>? brands;

  BrandsModel({
    this.brands,
  });

  factory BrandsModel.fromJson(Map<String, dynamic> json) => BrandsModel(
        brands: json["brands"] == null
            ? []
            : List<SingleBrand>.from(json["brands"]!.map((x) => SingleBrand.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "brands": brands == null
            ? []
            : List<dynamic>.from(brands!.map((x) => x.toJson())),
      };
}

class SingleBrand {
  final String? collectionId;
  final String? iconSrc;
  final String? brandName;
  final int? id;

  SingleBrand({
    this.collectionId,
    this.iconSrc,
    this.brandName,
    this.id,
  });

  factory SingleBrand.fromJson(Map<String, dynamic> json) => SingleBrand(
        collectionId: json["collection_id"],
        iconSrc: json["icon_src"],
        brandName: json["brand_name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "collection_id": collectionId,
        "icon_src": iconSrc,
        "brand_name": brandName,
        "id": id,
      };
}
