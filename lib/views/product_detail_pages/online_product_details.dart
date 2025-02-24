// This file is a middle ware between product card and product details screen.
// This files contains query to fetch product data to send on detail page.
// This file will be used for the products store in local storage which has incomplete data.

import 'package:flutter/material.dart';
import 'package:golden_doctor/graph_ql/query/mutation_query.dart';
import 'package:golden_doctor/models/products/product_model.dart';
import 'package:golden_doctor/utils/app_colors.dart';
import 'package:golden_doctor/utils/app_fonts.dart';
import 'package:golden_doctor/utils/app_images.dart';
import 'package:golden_doctor/views/product_detail_pages/product_detail_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class OnlineProductDetails extends StatelessWidget {
  const OnlineProductDetails({
    super.key,
    required this.productID,
  });

  // final CartModel cartmodel;
  final String productID;
  @override
  Widget build(BuildContext context) {
    // print("-----${productID}");
    return Scaffold(
      body: Query(
        options: QueryOptions(
          document: gql(fetchSignleProduct(productID)),
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.noInternet),
                  Text(
                    "No Internet",
                    style: AppTextStyles.headline2.copyWith(
                      color: AppColors.myPrimary,
                    ),
                  ),
                ],
              ),
            );
          }

          if (result.isLoading && result.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (result.data != null) {
            ProductNode purpleNode =
                ProductNode.fromJson(result.data!["product"]);  
            return ProductDetailScreen(singleProduct: purpleNode);
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(AppImages.noData),
                  Text(
                    "Empty",
                    style: AppTextStyles.headline2.copyWith(
                      color: AppColors.myPrimary,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
