// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:golden_doctor/graph_ql/query/mutation_query.dart';
// import 'package:golden_doctor/models/product_quantity_model.dart/product_quantity_model.dart';
// import 'package:golden_doctor/models/products/product_model.dart';
// import 'package:golden_doctor/utils/handles.dart';

// final productDetailsProvider =
//     AutoDisposeNotifierProvider<ProductDetailViewModel, List<SelectedOption>>(
//         () {
//   return ProductDetailViewModel();
// });

// class ProductDetailViewModel extends AutoDisposeNotifier<List<SelectedOption>> {
//   @override
//   List<SelectedOption> build() => [];

//   void selectOption(List<SelectedOption> newOption) {
//     state = [...newOption];
//   }

//   ProductQuantityModel? productQuantityModel;
// // This Function will return the Selected variant on Details page
// // Selected variant will be added to cart.
//   VariantsEdge selectVariant({required ProductNode purpleNode}) {
//     VariantsEdge variantsEdge = purpleNode.variants.edges[0];
//     for (int i = 0; i < purpleNode.variants.edges.length; i++) {
//       String a = purpleNode.variants.edges[i].node.selectedOptions
//           .map((e) => e.toJson())
//           .toList()
//           .toString();
//       String b = state.map((e) => e.toJson()).toList().toString();
//       if (a == b) {
//         variantsEdge = purpleNode.variants.edges[i];
//         break;
//       }
//     }
//     return variantsEdge;
//   }

// // This function will fetch product Quantity
//   Future<void> productQuentity(
//     BuildContext context,
//     String productId,
//   ) async {
//     ApiBaseHelper apiBaseHelper = ApiBaseHelper();
//     String body = productQuantityQuery(productId: productId);
//     var response = await apiBaseHelper.post(url: '', data: body);
//     productQuantityModel =
//         ProductQuantityModel.fromJson(response['data']['product']);
//     // try {
//     //   var headers = {
//     //     'X-Shopify-Storefront-Access-Token': '564e4ac3bb875c69f875eea45070034a',
//     //     'Content-Type': 'application/json'
//     //   };
//     //   var request = http.Request(
//     //       'POST',
//     //       Uri.parse(
//     //           'https://alche-app-development.myshopify.com/api/2023-10/graphql.json'));
//     //   request.body =
//     //       '''{"query":"\\n\\n\\nquery MyQuery {\\n  product(id: \\"${productId}\\") {\\n    totalInventory\\n    variants(first: 15) {\\n      edges {\\n        node {\\n          quantityAvailable\\n          id\\n        }\\n      }\\n    }\\n  }\\n}","variables":{"id":"${productId}"}}''';
//     //   request.headers.addAll(headers);
//     //   http.StreamedResponse response = await request.send();
//     //   if (response.statusCode == 200) {
//     //     // log("Response === " + await response.stream.bytesToString());
//     //     final responsebody = await response.stream.bytesToString();
//     //     Map<String, dynamic> jsonMap = json.decode(responsebody);
//     //     log('product Quantity  response ====n ${jsonMap['data']['product']}');
//     //     //  ProductQuantityModel.fromJson(jsonMap['data']['product']);
//     //     productQuantityModel =
//     //         ProductQuantityModel.fromJson(jsonMap['data']['product']);
//     //     log('Product Quantity = ${productQuantityModel!.totalInventory.toString()}');
//     //     // log('URL === ${jsonMap['data']['cart']['checkoutUrl']}');
//     //   } else {
//     //     log(response.reasonPhrase.toString());
//     //   }
//     // } catch (e) {
//     //   log('Catch ${e.toString()}');
//     //   // addboleanValue(false);
//     // }
//   }
// }
