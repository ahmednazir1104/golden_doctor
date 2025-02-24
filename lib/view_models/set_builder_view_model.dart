import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_doctor/graph_ql/config.dart';
import 'package:golden_doctor/graph_ql/query/mutation_query.dart';
import 'package:golden_doctor/models/products/product_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final setBuilderProvider =
    ChangeNotifierProvider.autoDispose<SetBuilderViewModel>((ref) {
  return SetBuilderViewModel();
});

class SetBuilderViewModel extends ChangeNotifier {
  // List<ProductEdge> productList1 = [];
  // List<ProductEdge> productList2 = [];
  int firstDisplyProductIndex = 0;
  int secondDisplyProductIndex = 0;
  // List<SelectedOption> selectedOptions1 = [];
  // List<SelectedOption> selectedOptions2 = [];
  // VariantsEdge? selectedVariant1;
  // VariantsEdge? selectedVariant2;

  //  farword produt
  void changeDisplyProduct(
      {required List<ProductEdge> productList,
      required int itemIndex,
      required int movement}) {
    if (itemIndex == 0) {
      movement == 1 ? firstDisplyProductIndex++ : firstDisplyProductIndex--;
      // selectOption(
      //   productList: productList,
      //   newOption: productList[firstDisplyProductIndex]
      //       .node
      //       .variants
      //       .edges[0]
      //       .node
      //       .selectedOptions,
      //   itemIndex: itemIndex,
      // );
    } else {
      movement == 1 ? secondDisplyProductIndex++ : secondDisplyProductIndex--;
      // selectOption(
      //   productList: productList,
      //   newOption: productList[firstDisplyProductIndex]
      //       .node
      //       .variants
      //       .edges[0]
      //       .node
      //       .selectedOptions,
      //   itemIndex: itemIndex,
      // );
    }
    notifyListeners();
  }

  // back produt

  // void backDisplyProduct({required int itemIndex}) {
  //   if (itemIndex == 1) {
  //     firstDisplyProductIndex--;
  //   } else {
  //     secondDisplyProductIndex--;
  //   }
  //   notifyListeners();
  // }

  // Fetch products by collection id
  Future<List<List<ProductEdge>>?> fetchProductsByCollectionIDs({
    required String collectionID1,
    required String collectionID2,
  }) async {
    List<List<ProductEdge>> productLists = [];
    GraphQlHelper graphQlHelper = GraphQlHelper();

    for (int i = 0; i < 2; i++) {
      String collectionID = i == 0 ? collectionID1 : collectionID2;
      QueryResult result = await graphQlHelper.client.value.query(
        QueryOptions(
          document: gql(fetchProductwithCollectionIdfn(collectionID)),
          variables: {
            'numProducts': 40,
          },
        ),
      );

      if (result.hasException) {
        if (kDebugMode) {
          print("GraphQL Error: ${result.exception!.graphqlErrors}");
        }
        return null;
      }
      Data? collectionProducts = Data.fromJson(result.data!);
      List<ProductEdge> productedges =
          collectionProducts.collection.products.edges;
      productLists.add(productedges);
    }
    if (productLists[0].isNotEmpty && productLists[1].isNotEmpty) {
      // productList1 = productLists[0];
      // productList2 = productLists[1];
      return productLists;
    } else {
      return null;
    }
  }

  // Function to update selected options
  // void selectOption(
  //     {required List<ProductEdge> productList,
  //     required List<SelectedOption> newOption,
  //     required int itemIndex}) {
  //   if (itemIndex == 1) {
  //     selectedOptions1 = [...newOption];
  //     selectedVariant1 =
  //         selectVariant(itemIndex: itemIndex, productList: productList);
  //   } else {
  //     selectedOptions2 = [...newOption];
  //     selectedVariant2 =
  //         selectVariant(itemIndex: itemIndex, productList: productList);
  //   }
  //   notifyListeners();
  // }

  // // Function to select a variant based on selected options
  // VariantsEdge selectVariant(
  //     {required List<ProductEdge> productList, required int itemIndex}) {
  //   ProductNode purpleNode = productList[itemIndex].node;
  //   // itemIndex == 0
  //   //     ? productList1[firstDisplyProductIndex].node
  //   //     : productList2[secondDisplyProductIndex].node;
  //   VariantsEdge variantsEdge = purpleNode.variants.edges[0];

  //   for (int i = 0; i < purpleNode.variants.edges.length; i++) {
  //     var a = purpleNode.variants.edges[i].node.selectedOptions
  //         .map((e) => e.toJson())
  //         .toList()
  //         .toString();

  //     var b;
  //     if (itemIndex == 0) {
  //       b = selectedOptions1.map((e) => e.toJson()).toList().toString();
  //     } else {
  //       b = selectedOptions2.map((e) => e.toJson()).toList().toString();
  //     }

  //     if (a == b) {
  //       variantsEdge = purpleNode.variants.edges[i];
  //       break;
  //     }
  //   }
  //   return variantsEdge;
  // }
}

// final displyProduct1 = StateProvider.autoDispose<int>((ref) {
//   return 0;
// });
// final displyProduct2 = StateProvider.autoDispose<int>((ref) {
//   return 0;
// });
