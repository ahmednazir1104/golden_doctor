import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:golden_doctor/models/products/product_model.dart';
import 'package:golden_doctor/utils/app_colors.dart';
import 'package:golden_doctor/utils/app_fonts.dart';
import 'package:golden_doctor/utils/app_images.dart';
import 'package:golden_doctor/resources/widgets/product_widget/product_bottom_sheet_widget.dart';

class ProductWidget extends StatelessWidget {
  final ProductNode singleProduct;
  const ProductWidget({
    super.key,
    required this.singleProduct,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          "/productDetailScreen",
          extra: {"productNode": singleProduct},
          // "/online_product_detail_screen",
          // extra: {"productID": singleProduct.id},
        );
      },
      child: Container(
        width: 160.w,
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 180.h,
              child: Stack(
                children: [
                  Positioned.fill(
                    // top: 0,
                    // left: 0,
                    // right: 0,
                    // bottom: 0,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: singleProduct.images.edges[0].node.url,
                      // imageUrl: singleProduct.variants.edges[0].node.image.url,
                      // 'https://pixlr.com/images/generator/photo-generator.webp',
                      // height: 200.h,
                      placeholder: (context, url) => SizedBox(
                        width: double.infinity,
                        height: 202.h,
                        child: Center(
                          child: Image(
                            image: AssetImage(
                              AppImages.logoImage,
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  clipBehavior: Clip.antiAlias,
                                  builder: (context) =>
                                      ProductBottomSheetWidget(
                                    singleProduct: singleProduct,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  color: AppColors.myScaffold,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: AppColors.myPrimary,
                                  size: 12.h,
                                  weight: 700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // ---- sales tag----
            // Visibility(
            //   visible: true,
            //   child: Positioned(
            //     top: 0,
            //     right: 0,
            //     child: Container(
            //       color: AppColors.grey,
            //       padding:
            //           EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            //       child: Text('%',
            //           style: AppTextStyles.body1
            //               ),
            //     ),
            //   ),
            // ),

            IntrinsicWidth(
              child: Container(
                // width: 57.w,
                height: 31.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                margin: EdgeInsets.only(top: 7.h, bottom: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.greyCA,
                  borderRadius: BorderRadius.circular(70.r),
                ),
                child: Center(
                  child: Text(
                    singleProduct.vendor!,
                    // 'Infinity',
                    style: AppTextStyles.body2,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 100.w,
              child: Text(
                singleProduct.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                // "Infinity Women's Split Neck Top…",
                style: AppTextStyles.body2.copyWith(fontSize: 12.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      singleProduct
                          .variants.edges[0].node.selectedOptions[0].value,
                      style: AppTextStyles.body2.copyWith(fontSize: 12.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      // width: 125.w,
                      child: Text(
                        singleProduct.options[0].optionValues.length > 1
                            ? "${singleProduct.options[0].optionValues.length} Colors"
                            : "${singleProduct.options[0].optionValues.length} Color",
                        // "06 Colors",
                        style: AppTextStyles.body3.copyWith(fontSize: 12.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Text(
                "SAR ${singleProduct.variants.edges[0].node.price.amount.split(".")[0]}",
                style: AppTextStyles.headline2.copyWith(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
