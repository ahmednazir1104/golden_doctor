import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_doctor/graph_ql/config.dart';
import 'package:golden_doctor/graph_ql/query/mutation_query.dart';
import 'package:golden_doctor/models/products/product_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProductNotifier extends ChangeNotifier {
  List<ProductEdge> productList = [];
  Data? collectionProducts;

  bool isLoading = false;
  setIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void addProducts(List<ProductEdge> newProducts) {
    // productList = [];
    productList = [...productList, ...newProducts];
  }

  void getData({var collectionId, required String type}) async {
    if (kDebugMode) {
      print("Fetch Function");
    }
    if (kDebugMode) {
      print("Old pro ${productList.length}");
    }
    if (type == "Initial Fetch" && productList.isNotEmpty) {
      return;
    } else if (type == "Fetch More") {
      if (collectionProducts!.collection.products.pageInfo.hasNextPage) {
        // setIsLoading();
        GraphQlHelper graphQlHelper = GraphQlHelper();
        QueryResult result = await graphQlHelper.client.value.query(
          QueryOptions(
            document: gql(fetchProductwithCollectionIdfn(collectionId,
                cursor: collectionProducts!
                    .collection.products.pageInfo.endCursor)),
            variables: {
              'numProducts': 40,
              'cursor':
                  collectionProducts!.collection.products.pageInfo.endCursor
            },
          ),
        );
        if (result.hasException) {
          // setIsLoading();
          if (kDebugMode) {
            print("GraphQL has Exception");
          print(result.exception!.graphqlErrors);
          }
        } else {
          collectionProducts = Data.fromJson(result.data!);
          List<ProductEdge> allProducts =
              collectionProducts!.collection.products.edges;
          // print("new pro ${allProducts.length}");
          addProducts(allProducts);
          // print("total pro ${productList.length}");
          // Future.delayed(Duration(seconds: 5), ()=>setIsLoading());
          // setIsLoading();
          notifyListeners();
        }
      }
    } else {
      setIsLoading();
      GraphQlHelper graphQlHelper = GraphQlHelper();
      QueryResult result = await graphQlHelper.client.value.query(
        QueryOptions(
          document:
              gql(fetchProductwithCollectionIdfn(collectionId, cursor: null)),
          variables: {
            'numProducts': 40,
            'cursor': null,
          },
        ),
      );
      if (result.hasException) {
        setIsLoading();
        if (kDebugMode) {
          print("GraphQL has Exception");
        print(result.exception!.graphqlErrors);
        }
      } else {
        // print(result.data!["collection"]["products"]["edges"][0]["node"]
        //     ["metafields"]);
        collectionProducts = Data.fromJson(result.data!);
        List<ProductEdge> allProducts =
            collectionProducts!.collection.products.edges;
        // print("new pro ${allProducts.length}");
        addProducts(allProducts);
        // print("total pro ${productList.length}");
        setIsLoading();
      }
    }
  }
}

final collectionsProductsProvider =
    ChangeNotifierProvider.autoDispose<ProductNotifier>(
        (ref) => ProductNotifier());
