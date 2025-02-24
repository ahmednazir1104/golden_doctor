
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_doctor/utils/app_fonts.dart';
import 'package:golden_doctor/view_models/language_provider.dart';

// ignore: must_be_immutable
class ProductCaruselWidget extends StatelessWidget {
  // ProductsCarouselSection section;
  String sectionTitle;
  List<String> productIdList = [];
  ProductCaruselWidget({
    super.key,
    required this.productIdList,
    required this.sectionTitle,
  });

  @override
  Widget build(BuildContext context) {
//  productIdList =

    // for (var element in section.body) {
    //   productIdList.add(element.objId); // Modify and add to the target list
    // }

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
          // SizedBox(
          //   height: 320,
          //   child: ListView.builder(
          //     // shrinkWrap: true,
          //     // physics: NeverScrollableScrollPhysics(),
          //     // itemCount: AppConstant.brandList.length,
          //     itemCount: productIdList.length,
          //     //  section.body!.length,
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (BuildContext context, int index) {
          //       return
          //           //Text('data');
          //           ProductWidget(
          //         singleProduct: 
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
