import 'dart:convert';
import 'package:collection/collection.dart';

CollectionProductsModel collectionProductsModelFromJson(String str) =>
    CollectionProductsModel.fromJson(json.decode(str));

String collectionProductsModelToJson(CollectionProductsModel data) =>
    json.encode(data.toJson());

class CollectionProductsModel {
  final Data data;

  CollectionProductsModel({
    required this.data,
  });

  factory CollectionProductsModel.fromJson(Map<String, dynamic> json) =>
      CollectionProductsModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  final Collection collection;

  Data({
    required this.collection,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        collection: Collection.fromJson(json["collection"]),
      );

  Map<String, dynamic> toJson() => {
        "collection": collection.toJson(),
      };
}

class Collection {
  final Products products;

  Collection({
    required this.products,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        products: Products.fromJson(json["products"]),
      );

  Map<String, dynamic> toJson() => {
        "products": products.toJson(),
      };
}

class PageInfo {
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String? endCursor;
  final String? startCursor;

  PageInfo({
    required this.hasNextPage,
    required this.hasPreviousPage,
    this.endCursor,
    this.startCursor,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        hasNextPage: json["hasNextPage"],
        hasPreviousPage: json["hasPreviousPage"],
        endCursor: json["endCursor"],
        startCursor: json["startCursor"],
      );

  Map<String, dynamic> toJson() => {
        "hasNextPage": hasNextPage,
        "hasPreviousPage": hasPreviousPage,
        "endCursor": endCursor,
        "startCursor": startCursor,
      };
}

class Products {
  final PageInfo pageInfo;
  final List<ProductEdge> edges;

  Products({
    required this.pageInfo,
    required this.edges,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        pageInfo: PageInfo.fromJson(json["pageInfo"]),
        edges: json["edges"] != null
            ? List<ProductEdge>.from(
                json["edges"].map((x) => ProductEdge.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "pageInfo": pageInfo.toJson(),
        "edges": List<dynamic>.from(edges.map((x) => x.toJson())),
      };
}

class ProductEdge {
  final String? cursor;
  final ProductNode node;

  ProductEdge({
    required this.cursor,
    required this.node,
  });

  factory ProductEdge.fromJson(Map<String, dynamic> json) => ProductEdge(
        cursor: json["cursor"],
        node: ProductNode.fromJson(json["node"]),
      );

  Map<String, dynamic> toJson() => {
        "cursor": cursor,
        "node": node.toJson(),
      };
}

class ProductNode {
  final String gid;
  final String? productQuantity;
  final String title;
  final String? vendor;
  final List<String> tags;
  final String? description;
  final String? descriptionHtml;
  final String? productType;
  final DateTime? publishedAt;
  final String? onlineStoreUrl;
  final Variants variants;
  final Images images;
  final String id;
  final List<Options> options;
  final String? emborideryMetafield;
  final String? productRecomandationMetafield;
  final String? youMayAlsoLikeMetafield;

  String? variantColor;

  ProductNode({
    required this.gid,
    required this.productQuantity,
    required this.title,
    required this.vendor,
    required this.tags,
    required this.description,
    required this.descriptionHtml,
    required this.productType,
    required this.publishedAt,
    required this.onlineStoreUrl,
    required this.variants,
    required this.images,
    required this.id,
    required this.options,
    this.emborideryMetafield,
    this.variantColor,
    this.productRecomandationMetafield,
    this.youMayAlsoLikeMetafield,
  });

  factory ProductNode.fromJson(Map<String, dynamic> json) {
    print(json["title"]);
    return ProductNode(
      gid: json["id"] ?? "N/A",
      productQuantity: json['quantityAvailable'] ?? "N/A",
      title: json["title"] ?? "N/A",
      vendor: json["vendor"] ?? "N/A",
      tags: List<String>.from(json["tags"].map((x) => x)),
      description: json["description"] ?? "N/A",
      descriptionHtml: json["descriptionHtml"] ?? "N/A",
      productType: json["productType"] ?? "N/A",
      publishedAt: DateTime.parse(json["publishedAt"]),
      onlineStoreUrl: json["onlineStoreUrl"] ?? "N/A",
      variants: Variants.fromJson(json["variants"]),
      images: Images.fromJson(json["images"]),
      id: json["id"] ?? "N/A",
      options:
          List<Options>.from(json["options"].map((x) => Options.fromJson(x))),
      emborideryMetafield:
          _getValueForKey(items: json["metafields"], key: "embroidery_product"),
      productRecomandationMetafield: _getValueForKey(
          items: json["metafields"], key: "product_recomandation"),
      youMayAlsoLikeMetafield:
          _getValueForKey(items: json["metafields"], key: "you_may_also_like"),
    );
  }

  Map<String, dynamic> toJson() => {
        "gid": gid,
        "title": title,
        "vendor": vendor,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "description": description,
        "descriptionHtml": descriptionHtml,
        "productType": productType,
        "publishedAt": publishedAt?.toIso8601String(),
        "onlineStoreUrl": onlineStoreUrl,
        "variants": variants.toJson(),
        "images": images.toJson(),
        "id": id,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
      };
}

String? _getValueForKey({List<dynamic>? items, required String key}) {
  if (items == null) return null;
  final item = items.firstWhereOrNull((element) => element?['key'] == key);
  return item?['value'];
}

class Options {
  final String name;
  final List<OptionValuesModel> optionValues;

  Options({
    required this.name,
    required this.optionValues,
  });

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        name: json["name"],
        optionValues: List<OptionValuesModel>.from(
            json["optionValues"].map((x) => OptionValuesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "optionValues": List<dynamic>.from(optionValues.map((x) => x.toJson())),
      };
}

class OptionValuesModel {
  final String name;

  OptionValuesModel({
    required this.name,
  });

  factory OptionValuesModel.fromJson(Map<String, dynamic> json) =>
      OptionValuesModel(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Images {
  final List<ImagesEdge> edges;

  Images({
    required this.edges,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        edges: List<ImagesEdge>.from(
            json["edges"].map((x) => ImagesEdge.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "edges": List<dynamic>.from(edges.map((x) => x.toJson())),
      };
}

class ImagesEdge {
  final FluffyNode node;

  ImagesEdge({
    required this.node,
  });

  factory ImagesEdge.fromJson(Map<String, dynamic> json) => ImagesEdge(
        node: FluffyNode.fromJson(json["node"]),
      );

  Map<String, dynamic> toJson() => {
        "node": node.toJson(),
      };
}

class FluffyNode {
  final String url;
  final String altText;

  FluffyNode({
    required this.url,
    required this.altText,
  });

  factory FluffyNode.fromJson(Map<String, dynamic> json) => FluffyNode(
        url: json["url"] ?? "",
        altText: json["altText"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class Variants {
  final List<VariantsEdge> edges;

  Variants({
    required this.edges,
  });

  factory Variants.fromJson(Map<String, dynamic> json) => Variants(
        edges: List<VariantsEdge>.from(
            json["edges"].map((x) => VariantsEdge.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "edges": List<dynamic>.from(edges.map((x) => x.toJson())),
      };
}

class VariantsEdge {
  final TentacledNode node;

  VariantsEdge({
    required this.node,
  });

  factory VariantsEdge.fromJson(Map<String, dynamic> json) => VariantsEdge(
        node: TentacledNode.fromJson(json["node"]),
      );

  Map<String, dynamic> toJson() => {
        "node": node.toJson(),
      };
}

class TentacledNode {
  final String id;
  final String title;
  final ProductImage? image;
  final Price price;
  final String? sku;
  final Price? compareAtPrice;
  final bool? availableForSale;
  final List<SelectedOption> selectedOptions;

  TentacledNode({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.sku,
    required this.compareAtPrice,
    required this.availableForSale,
    required this.selectedOptions,
  });

  factory TentacledNode.fromJson(Map<String, dynamic> json) => TentacledNode(
        id: json["id"],
        title: json["title"] ?? "N/A",
        image:
            json["image"] != null ? ProductImage.fromJson(json["image"]) : null,
        price: Price.fromJson(json["price"]),
        sku: json["sku"] ?? "N/A",
        compareAtPrice: json["compareAtPrice"] != null
            ? Price.fromJson(json["compareAtPrice"])
            : null,
        availableForSale: json["availableForSale"] ?? false,
        selectedOptions: List<SelectedOption>.from(
            json["selectedOptions"].map((x) => SelectedOption.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image?.toJson(),
        "price": price.toJson(),
        "sku": sku,
        "compareAtPrice": compareAtPrice?.toJson(),
        "availableForSale": availableForSale,
        "selectedOptions":
            List<dynamic>.from(selectedOptions.map((x) => x.toJson())),
      };
}

class ProductImage {
  final String url;

  ProductImage({
    required this.url,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class Price {
  final String amount;

  Price({
    required this.amount,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
      };
}

class SelectedOption {
  final String name;
  final String value;

  SelectedOption({
    required this.name,
    required this.value,
  });

  factory SelectedOption.fromJson(Map<String, dynamic> json) => SelectedOption(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}

// To parse this JSON data, do
//
//     final collectionProductModel = collectionProductModelFromJson(jsonString);

// import 'dart:convert';

// CollectionProductModel collectionProductModelFromJson(String str) =>
//     CollectionProductModel.fromJson(json.decode(str));

// String collectionProductModelToJson(CollectionProductModel data) =>
//     json.encode(data.toJson());

// class CollectionProductModel {
//   final Data? data;

//   CollectionProductModel({
//     this.data,
//   });

//   factory CollectionProductModel.fromJson(Map<String, dynamic> json) =>
//       CollectionProductModel(
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": data?.toJson(),
//       };
// }

// class Data {
//   final Collection? collection;

//   Data({
//     this.collection,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         collection: json["collection"] == null
//             ? null
//             : Collection.fromJson(json["collection"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "collection": collection?.toJson(),
//       };
// }

// class Collection {
//   final Products? products;

//   Collection({
//     this.products,
//   });

//   factory Collection.fromJson(Map<String, dynamic> json) => Collection(
//         products: json["products"] == null
//             ? null
//             : Products.fromJson(json["products"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "products": products?.toJson(),
//       };
// }

// class Products {
//   final List<ProductsEdge>? edges;
//   final PageInfo? pageInfo;

//   Products({
//     this.edges,
//     this.pageInfo,
//   });

//   factory Products.fromJson(Map<String, dynamic> json) => Products(
//         edges: json["edges"] == null
//             ? []
//             : List<ProductsEdge>.from(
//                 json["edges"]!.map((x) => ProductsEdge.fromJson(x))),
//         pageInfo: json["pageInfo"] == null
//             ? null
//             : PageInfo.fromJson(json["pageInfo"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "edges": edges == null
//             ? []
//             : List<dynamic>.from(edges!.map((x) => x.toJson())),
//         "pageInfo": pageInfo?.toJson(),
//       };
// }

// class ProductsEdge {
//   final String? cursor;
//   final PurpleNode? node;

//   ProductsEdge({
//     this.cursor,
//     this.node,
//   });

//   factory ProductsEdge.fromJson(Map<String, dynamic> json) => ProductsEdge(
//         cursor: json["cursor"],
//         node: json["node"] == null ? null : PurpleNode.fromJson(json["node"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "cursor": cursor,
//         "node": node?.toJson(),
//       };
// }

// class PurpleNode {
//   final String? title;
//   final List<Tag>? tags;
//   final String? description;
//   final String? descriptionHtml;
//   final String? productType;
//   final DateTime? publishedAt;
//   final dynamic onlineStoreUrl;
//   final List<Option>? options;
//   final Variants? variants;
//   final Images? images;
//   final List<dynamic>? metafields;
//   final String? id;

//   PurpleNode({
//     this.title,
//     this.tags,
//     this.description,
//     this.descriptionHtml,
//     this.productType,
//     this.publishedAt,
//     this.onlineStoreUrl,
//     this.options,
//     this.variants,
//     this.images,
//     this.metafields,
//     this.id,
//   });

//   factory PurpleNode.fromJson(Map<String, dynamic> json) => PurpleNode(
//         title: json["title"],
//         tags: json["tags"] == null
//             ? []
//             : List<Tag>.from(json["tags"]!.map((x) => tagValues.map[x]!)),
//         description: json["description"],
//         descriptionHtml: json["descriptionHtml"],
//         productType: json["productType"],
//         publishedAt: json["publishedAt"] == null
//             ? null
//             : DateTime.parse(json["publishedAt"]),
//         onlineStoreUrl: json["onlineStoreUrl"],
//         options: json["options"] == null
//             ? []
//             : List<Option>.from(
//                 json["options"]!.map((x) => Option.fromJson(x))),
//         variants: json["variants"] == null
//             ? null
//             : Variants.fromJson(json["variants"]),
//         images: json["images"] == null ? null : Images.fromJson(json["images"]),
//         metafields: json["metafields"] == null
//             ? []
//             : List<dynamic>.from(json["metafields"]!.map((x) => x)),
//         id: json["id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "title": title,
//         "tags": tags == null
//             ? []
//             : List<dynamic>.from(tags!.map((x) => tagValues.reverse[x])),
//         "description": description,
//         "descriptionHtml": descriptionHtml,
//         "productType": productType,
//         "publishedAt": publishedAt?.toIso8601String(),
//         "onlineStoreUrl": onlineStoreUrl,
//         "options": options == null
//             ? []
//             : List<dynamic>.from(options!.map((x) => x.toJson())),
//         "variants": variants?.toJson(),
//         "images": images?.toJson(),
//         "metafields": metafields == null
//             ? []
//             : List<dynamic>.from(metafields!.map((x) => x)),
//         "id": id,
//       };
// }

// class Images {
//   final List<ImagesEdge>? edges;

//   Images({
//     this.edges,
//   });

//   factory Images.fromJson(Map<String, dynamic> json) => Images(
//         edges: json["edges"] == null
//             ? []
//             : List<ImagesEdge>.from(
//                 json["edges"]!.map((x) => ImagesEdge.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "edges": edges == null
//             ? []
//             : List<dynamic>.from(edges!.map((x) => x.toJson())),
//       };
// }

// class ImagesEdge {
//   final FluffyNode? node;

//   ImagesEdge({
//     this.node,
//   });

//   factory ImagesEdge.fromJson(Map<String, dynamic> json) => ImagesEdge(
//         node: json["node"] == null ? null : FluffyNode.fromJson(json["node"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "node": node?.toJson(),
//       };
// }

// class FluffyNode {
//   final String? url;
//   final String? altText;

//   FluffyNode({
//     this.url,
//     this.altText,
//   });

//   factory FluffyNode.fromJson(Map<String, dynamic> json) => FluffyNode(
//         url: json["url"],
//         altText: json["altText"],
//       );

//   Map<String, dynamic> toJson() => {
//         "url": url,
//         "altText": altText,
//       };
// }

// class Option {
//   final OptionName? name;
//   final List<OptionValue>? optionValues;

//   Option({
//     this.name,
//     this.optionValues,
//   });

//   factory Option.fromJson(Map<String, dynamic> json) => Option(
//         name: optionNameValues.map[json["name"]]!,
//         optionValues: json["optionValues"] == null
//             ? []
//             : List<OptionValue>.from(
//                 json["optionValues"]!.map((x) => OptionValue.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "name": optionNameValues.reverse[name],
//         "optionValues": optionValues == null
//             ? []
//             : List<dynamic>.from(optionValues!.map((x) => x.toJson())),
//       };
// }

// enum OptionName { COLOR, FIT, NAME_COLOR, SIZE }

// final optionNameValues = EnumValues({
//   "color": OptionName.COLOR,
//   "fit": OptionName.FIT,
//   "Color": OptionName.NAME_COLOR,
//   "size": OptionName.SIZE
// });

// class OptionValue {
//   final ValueEnum? name;

//   OptionValue({
//     this.name,
//   });

//   factory OptionValue.fromJson(Map<String, dynamic> json) => OptionValue(
//         name: valueEnumValues.map[json["name"]]!,
//       );

//   Map<String, dynamic> toJson() => {
//         "name": valueEnumValues.reverse[name],
//       };
// }

// enum ValueEnum {
//   AQUA_MARINE,
//   CARBON_BLACK,
//   HEATHER_SEEDS,
//   L,
//   LEATHERBACK_GREY,
//   M,
//   NAME_PETITE,
//   NAME_REGULAR,
//   OZONE_BLUE,
//   PETITE,
//   PURPLE_RAIN,
//   REGULAR,
//   S,
//   THE_2_XL,
//   THE_3_XL,
//   XS,
//   XXS
// }

// final valueEnumValues = EnumValues({
//   "Aqua Marine": ValueEnum.AQUA_MARINE,
//   "Carbon Black": ValueEnum.CARBON_BLACK,
//   "Heather Seeds": ValueEnum.HEATHER_SEEDS,
//   "L": ValueEnum.L,
//   "Leatherback Grey": ValueEnum.LEATHERBACK_GREY,
//   "M": ValueEnum.M,
//   "Petite": ValueEnum.NAME_PETITE,
//   "Regular": ValueEnum.NAME_REGULAR,
//   "Ozone Blue": ValueEnum.OZONE_BLUE,
//   "PETITE": ValueEnum.PETITE,
//   "Purple Rain": ValueEnum.PURPLE_RAIN,
//   "REGULAR": ValueEnum.REGULAR,
//   "S": ValueEnum.S,
//   "2XL": ValueEnum.THE_2_XL,
//   "3XL": ValueEnum.THE_3_XL,
//   "XS": ValueEnum.XS,
//   "XXS": ValueEnum.XXS
// });

// enum Tag { DELETE, MAKE_A_SET, SIZE_CHART }

// final tagValues = EnumValues({
//   "delete": Tag.DELETE,
//   "make-a-set": Tag.MAKE_A_SET,
//   "SizeChart": Tag.SIZE_CHART
// });

// class Variants {
//   final List<VariantsEdge>? edges;

//   Variants({
//     this.edges,
//   });

//   factory Variants.fromJson(Map<String, dynamic> json) => Variants(
//         edges: json["edges"] == null
//             ? []
//             : List<VariantsEdge>.from(
//                 json["edges"]!.map((x) => VariantsEdge.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "edges": edges == null
//             ? []
//             : List<dynamic>.from(edges!.map((x) => x.toJson())),
//       };
// }

// class VariantsEdge {
//   final TentacledNode? node;

//   VariantsEdge({
//     this.node,
//   });

//   factory VariantsEdge.fromJson(Map<String, dynamic> json) => VariantsEdge(
//         node:
//             json["node"] == null ? null : TentacledNode.fromJson(json["node"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "node": node?.toJson(),
//       };
// }

// class TentacledNode {
//   final String? id;
//   final String? title;
//   final Image? image;
//   final Price? price;
//   final String? sku;
//   final dynamic compareAtPrice;
//   final bool? availableForSale;
//   final List<SelectedOption>? selectedOptions;

//   TentacledNode({
//     this.id,
//     this.title,
//     this.image,
//     this.price,
//     this.sku,
//     this.compareAtPrice,
//     this.availableForSale,
//     this.selectedOptions,
//   });

//   factory TentacledNode.fromJson(Map<String, dynamic> json) => TentacledNode(
//         id: json["id"],
//         title: json["title"],
//         image: json["image"] == null ? null : Image.fromJson(json["image"]),
//         price: json["price"] == null ? null : Price.fromJson(json["price"]),
//         sku: json["sku"],
//         compareAtPrice: json["compareAtPrice"],
//         availableForSale: json["availableForSale"],
//         selectedOptions: json["selectedOptions"] == null
//             ? []
//             : List<SelectedOption>.from(json["selectedOptions"]!
//                 .map((x) => SelectedOption.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "image": image?.toJson(),
//         "price": price?.toJson(),
//         "sku": sku,
//         "compareAtPrice": compareAtPrice,
//         "availableForSale": availableForSale,
//         "selectedOptions": selectedOptions == null
//             ? []
//             : List<dynamic>.from(selectedOptions!.map((x) => x.toJson())),
//       };
// }

// class Image {
//   final String? url;

//   Image({
//     this.url,
//   });

//   factory Image.fromJson(Map<String, dynamic> json) => Image(
//         url: json["url"],
//       );

//   Map<String, dynamic> toJson() => {
//         "url": url,
//       };
// }

// class Price {
//   final String? amount;

//   Price({
//     this.amount,
//   });

//   factory Price.fromJson(Map<String, dynamic> json) => Price(
//         amount: json["amount"],
//       );

//   Map<String, dynamic> toJson() => {
//         "amount": amount,
//       };
// }

// class SelectedOption {
//   final OptionName? name;
//   final ValueEnum? value;

//   SelectedOption({
//     this.name,
//     this.value,
//   });

//   factory SelectedOption.fromJson(Map<String, dynamic> json) => SelectedOption(
//         name: optionNameValues.map[json["name"]]!,
//         value: valueEnumValues.map[json["value"]]!,
//       );

//   Map<String, dynamic> toJson() => {
//         "name": optionNameValues.reverse[name],
//         "value": valueEnumValues.reverse[value],
//       };
// }

// class PageInfo {
//   final bool? hasNextPage;
//   final bool? hasPreviousPage;
//   final String? startCursor;
//   final String? endCursor;

//   PageInfo({
//     this.hasNextPage,
//     this.hasPreviousPage,
//     this.startCursor,
//     this.endCursor,
//   });

//   factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
//         hasNextPage: json["hasNextPage"],
//         hasPreviousPage: json["hasPreviousPage"],
//         startCursor: json["startCursor"],
//         endCursor: json["endCursor"],
//       );

//   Map<String, dynamic> toJson() => {
//         "hasNextPage": hasNextPage,
//         "hasPreviousPage": hasPreviousPage,
//         "startCursor": startCursor,
//         "endCursor": endCursor,
//       };
// }

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
