import 'package:flutter/foundation.dart';
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
    // final getBrandAsync = ref.watch(getBrandProvider);
    final brandsAsyncValue = ref.watch(getBrandProvider);
    // final brandsAsyncValue = ref.watch(getBrandProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Brands',
          style: AppTextStyles.body1,
        ),
      ),
      body: brandsAsyncValue.when(
        data: (brandsModel) {
          final brandsList = brandsModel.brands;

          if (brandsList.isEmpty) {
            return Center(child: Text('No brands available'));
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.w,
                  mainAxisSpacing: 6.h,
                  childAspectRatio: 1.1,
                ),
                itemCount: brandsList.length,
                // scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final brand = brandsList[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 120.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                brand.iconSrc.toString(),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Text(
                            brand.brandName,
                            style: AppTextStyles.body2,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
