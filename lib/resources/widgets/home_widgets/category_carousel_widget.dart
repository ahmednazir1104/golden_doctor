// import 'dart:developer';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:golden_doctor/models/home_model/category_section_model.dart';
import 'package:golden_doctor/utils/app_fonts.dart';
// import 'package:golden_doctor/utils/app_images.dart';
import 'package:golden_doctor/view_models/language_provider.dart';

// ignore: must_be_immutable
class CategoryCarouselWidget extends StatelessWidget {
  // dynamic section;
  CategoriesCarouselSection section;
  // final String categoryName;
  // final VoidCallback voidCallback;
  CategoryCarouselWidget({
    super.key,
    required this.section,
    // required this.categoryName,
    // required this.voidCallback,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
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
                    // section.title.toString().tr == ''
                    //     ? 'NA'
                    //     :
                    section.title.toString(),
                    style: AppTextStyles.headline2,
                  ),
                  Text(
                    "See All".tr,
                    style: AppTextStyles.headline2.copyWith(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child:
               GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.w,
                  mainAxisSpacing: 0.h,
                  childAspectRatio: 0.77,
                ),
                itemCount: section.body.length,
                // scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  Category singleCategory = section.body[index];
                  return InkWell(
                    onTap: () {
                      // context.push('/collectionScreen');

                      if (singleCategory.objType == 'collections') {
                        log('collections========');
                        log('singleCategory.objId ====== ${singleCategory.objId}');
                        context.push(
                          "/collection_product_screen",
                          extra: {
                            "collectionID": singleCategory.objId,
                            "collectionName": singleCategory.objName,
                          },
                        );
                      } else if (singleCategory.objType == 'product') {
                        log('product========');
                      } else {
                        log('product========');
                      }
                      // if (singleCategory.objType!.name == 'COLLECTIONS') {
                      //   log('collections========');
                      //   context.push('/collectionScreen');
                      // } else if (singleCategory.objType!.name == 'product') {
                      //   log('product========');
                      // } else {
                      //   log('other========');
                      //   log('Obg type ==== ${singleCategory.objType!.name}');
                      // }
                    },
                    // voidCallback,
                    child: Padding(
                      padding: EdgeInsets.only(left: 0.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 190.h,
                            // width: 168.w,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(4.r),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      singleCategory.desktopImg.toString())

                                  // AssetImage(
                                  //   AppImages.doctorImage,
                                  // ),
                                  ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          SizedBox(
                            // height: 10,
                            child: Text(
                              singleCategory.objName.substring(0, 15),
                              overflow: TextOverflow.ellipsis,
                              // singleCategory.objName.toString(),
                              maxLines: 2,
                              style: AppTextStyles.headline2.copyWith(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
