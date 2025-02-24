import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_doctor/models/products/product_model.dart';
import 'package:golden_doctor/resources/widgets/product_widget/product_widget.dart';
import 'package:golden_doctor/utils/app_fonts.dart';
import 'package:golden_doctor/view_models/language_provider.dart';

// ignore: must_be_immutable
class PdpProductCarousel extends StatelessWidget {
  // ProductsCarouselSection section;
  String sectionTitle;
  List<ProductEdge> products;
  PdpProductCarousel({
    super.key,
    required this.products,
    required this.sectionTitle,
  });

  @override
  Widget build(BuildContext context) {
    // return  
    // FutureBuilder(
    //     future: products,
    //     builder: (context, AsyncSnapshot snap) {
    //       print("00000000000000000");
    //       if (snap.connectionState == ConnectionState.waiting) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       } else if (snap.hasError ||
    //           (snap.data == null &&
    //               snap.connectionState != ConnectionState.waiting)) {
    //         return SizedBox();
    //       }
          return Padding(
            padding: EdgeInsets.only(bottom: 36.h, left: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(right: 12.w, left: 0.w, bottom: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        sectionTitle,
                        style: AppTextStyles.headline2,
                      ),
                      Text(
                        "See All".tr,
                        style: AppTextStyles.headline2.copyWith(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 320,
                  width: double.infinity,
                  child: ListView.builder(
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    // itemCount: AppConstant.brandList.length,
                    itemCount: products.length,
                    //  section.body!.length,
                    scrollDirection: Axis.horizontal,
                    // itemExtent: 185.w,
                    // padding: EdgeInsets.only(right: 20.w,),
                    itemBuilder: (BuildContext context, int index) {
                      return
                          //Text('data');
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: ProductWidget(
                                singleProduct: products[index].node),
                          );
                      //         ProductNode(
                      //   gid: "gid",
                      //   productQuantity: "productQuantity",
                      //   title: "title",
                      //   vendor: "vendor",
                      //   tags: [],
                      //   description: "description",
                      //   descriptionHtml: "descriptionHtml",
                      //   productType: "productType",
                      //   publishedAt: DateTime.now(),
                      //   onlineStoreUrl: "",
                      //   id: "id",
                      //   variants: Variants(edges: []),
                      //   images: Images(edges: []),
                      //   options: [],
                      // ));
                    },
                  ),
                ),
              ],
            ),
          );
        // });
  }
}
