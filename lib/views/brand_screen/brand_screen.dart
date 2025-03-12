import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_doctor/models/brands_model/brands_model.dart';
import 'package:golden_doctor/utils/app_colors.dart';
import 'package:golden_doctor/utils/app_fonts.dart';
import 'package:golden_doctor/view_models/brand_view_model/brand_view_model.dart';

class BrandScreen extends ConsumerWidget {
  const BrandScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getBrandAsync = ref.watch(getBrandProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Brands',
          style: AppTextStyles.body1,
        ),
      ),
      body: getBrandAsync.when(
        data: (brandVal) {
          return SizedBox(
            height: 300.h,
            child: ListView.builder(
              itemCount: brandVal[0].brands!.length,
              // AppConstant.brandList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                // SingleBrand singleBrand =  brandVal[0].brands![index];
                return InkWell(
                  onTap: () {
                    // context.push(
                    //   "/collection_product_screen",
                    //   extra: {
                    //     "collectionID": singleBrand.objId,
                    //     "collectionName": singleBrand.objName,
                    //   },
                    // );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    height: 65.h,
                    width: 65.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              brandVal[0].brands![index].iconSrc.toString())
                          //  AssetImage(
                          //   AppConstant.brandList[index],
                          // ),
                          ),
                    ),
                    child: Text(
                      brandVal[0].brands![index].brandName.toString(),
                      style: TextStyle(color: AppColors.black1C),
                    ),
                  ),
                );
              },
            ),
          );

          //  Text(brandVal.toString());
        },
        loading: () => CircularProgressIndicator(),
        error: (err, stack) => Text(
          'Error: $err',
          style: AppTextStyles.body1,
        ),
      ),
    );
  }
}
