import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_doctor/graph_ql/config.dart';
import 'package:golden_doctor/graph_ql/query/mutation_query.dart';
import 'package:golden_doctor/models/cart/cart_model.dart';
import 'package:golden_doctor/models/product_quantity_model.dart/product_quantity_model.dart';
import 'package:golden_doctor/models/products/product_model.dart';
import 'package:golden_doctor/utils/handles.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// AutoDisposeChangeNotifierProvider.family Implementation
final productDetailsProvider = ChangeNotifierProvider.autoDispose
    .family<ProductDetailViewModel, String>((ref, uniquePageId) {
  return ProductDetailViewModel(uniquePageId);
});

class ProductDetailViewModel extends ChangeNotifier {
  final String uniquePageId; // unique page id
  List<SelectedOption> selectedOptions = [];
  ProductQuantityModel? productQuantityModel;
  CartModel? embroideryOptions;

  ProductDetailViewModel(this.uniquePageId);

  // Function to update selected options
  void selectOption(List<SelectedOption> newOption) {
    selectedOptions = [...newOption];
    notifyListeners();
  }

  // Function to select a variant based on selected options
  VariantsEdge selectVariant({required ProductNode purpleNode}) {
    VariantsEdge variantsEdge = purpleNode.variants.edges[0];

    for (int i = 0; i < purpleNode.variants.edges.length; i++) {
      var a = purpleNode.variants.edges[i].node.selectedOptions
          .map((e) => e.toJson())
          .toList()
          .toString();
      var b = selectedOptions.map((e) => e.toJson()).toList().toString();

      if (a == b) {
        variantsEdge = purpleNode.variants.edges[i];
        break;
      }
    }
    return variantsEdge;
  }

  // Fetch product quantity
  Future<void> productQuentity(BuildContext context, productId) async {
    ApiBaseHelper apiBaseHelper = ApiBaseHelper();
    String body = productQuantityQuery(productId: productId);
    var response = await apiBaseHelper.post(url: '', data: body);
    productQuantityModel =
        ProductQuantityModel.fromJson(response['data']['product']);
    notifyListeners();
  }

  // Fetch products by collection
  Future<List<ProductEdge>?> fetchProducts({String? collectionId}) async {
    if (collectionId == null) return null;

    GraphQlHelper graphQlHelper = GraphQlHelper();
    QueryResult result = await graphQlHelper.client.value.query(
      QueryOptions(
        document:
            gql(fetchProductwithCollectionIdfn(collectionId, cursor: null)),
        variables: {'numProducts': 40, 'cursor': null},
      ),
    );

    if (result.hasException) {
      if (kDebugMode) {
        print("GraphQL Error: ${result.exception!.graphqlErrors}");
      }
      return null;
    }

    Data collectionProducts = Data.fromJson(result.data!);
    return collectionProducts.collection.products.edges;
  }

  // Add Embroidery options in state
  void addEmbroidery({required CartModel embroideryOptionsArg}) {
    embroideryOptions = CartModel(
      isEmbroidery: true,
      embroideryOptions: EmbroideryOptions(
        line1: embroideryOptionsArg.embroideryOptions!.line1,
        line2: embroideryOptionsArg.embroideryOptions!.line2,
        parentId: embroideryOptionsArg.embroideryOptions!.parentId,
        tags: embroideryOptionsArg.embroideryOptions!.tags,
        color: embroideryOptionsArg.embroideryOptions!.color,
        font: embroideryOptionsArg.embroideryOptions!.font,
        position: embroideryOptionsArg.embroideryOptions!.position,
      ),
      available: true,
      comparePrice: embroideryOptionsArg.comparePrice,
      productPrice: embroideryOptionsArg.productPrice,
      productId: embroideryOptionsArg.productId,
      varientId: embroideryOptionsArg.varientId,
      productName: embroideryOptionsArg.productName,
      productImage: embroideryOptionsArg.productImage,
      quantity: embroideryOptionsArg.quantity,
    );
    notifyListeners();
  }

  // Clear Embroidery
  void clearEmbroidery() {
    embroideryOptions = null;
    notifyListeners();
  }
}
