import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_doctor/models/home_model/product_section_model.dart';
import 'package:golden_doctor/resources/widgets/product_widget/product_widget.dart';
import 'package:golden_doctor/utils/app_fonts.dart';
import 'package:golden_doctor/view_models/home_view_model/home_view_model.dart';

class ProductCaruselWidget extends ConsumerWidget {
  final ProductsCarouselSection section;
  const ProductCaruselWidget({
    super.key,
    required this.section,
  });

  @override
  Widget build(BuildContext context, ref) {
    List<String> productIdList = [];
//  productIdList =

    for (var element in section.body) {
      productIdList.add(element.objId); // Modify and add to the target list
    }

    // log('productIdList length = ${productIdList.length.toString()}');
    return Padding(
      padding: EdgeInsets.only(bottom: 36.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 12.w, left: 12.w, bottom: 12.h),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  section.title,
                  style: AppTextStyles.headline2,
                ),
                // Text(
                //   "See All".tr,
                //   style: AppTextStyles.headline2.copyWith(),
                // ),
              ],
            ),
          ),
          FutureBuilder(
              future: ref.read(sectionsProvider.notifier).fetchProducts(
                    productIDs: json
                        .encode(productIdList)
                        .replaceFirst("[", "")
                        .replaceFirst("]", ""),
                  ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return SizedBox(
                  height: 320,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    itemCount: snapshot.data!.length, //  section.body!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: ProductWidget(
                          singleProduct: snapshot.data![index],
                        ),
                      );
                    },
                  ),
                );
              })
          // Query(
          //     options: QueryOptions(
          //       document: gql(fetchProductListByIDs(json
          //           .encode(productIdList)
          //           .replaceFirst("[", "")
          //           .replaceFirst("]", ""))),
          //     ),
          //     builder: (QueryResult snapshot, {refetch, fetchMore}) {
          //       if (snapshot.hasException) {
          //         print(snapshot.exception.toString());
          //         return Text("could not fetch data");
          //       }
          //       if (snapshot.isLoading) {
          //         return Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }
          //       print("00000000");
          //       // print(snapshot.data!["nodes"]);
          //       print("11111111111");
          //       List<ProductNode> productList = [];
          //       if (snapshot.data!['nodes'] == null) {
          //         productList = snapshot.data!['nodes']
          //             .map((e) => ProductNode.fromJson(e))
          //             .toList();

          //       print("222222222222");
          //       return SizedBox(
          //         height: 320,
          //         child: ListView.builder(
          //           // shrinkWrap: true,
          //           // physics: NeverScrollableScrollPhysics(),
          //           // itemCount: AppConstant.brandList.length,
          //           itemCount: productList.length,                    //  section.body!.length,
          //           scrollDirection: Axis.horizontal,
          //           itemBuilder: (BuildContext context, int index) {
          //             return
          //                 // Text('data');
          //                 ProductWidget(
          //               singleProduct: productList[index],
          //             );
          //           },
          //         ),
          //       );}
          //       else{
          //         return Container();
          //       }
          //     }),
        ],
      ),
    );
  }
}
