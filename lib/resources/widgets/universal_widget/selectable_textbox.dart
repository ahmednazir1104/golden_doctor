import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_doctor/utils/app_colors.dart';
import 'package:golden_doctor/utils/app_fonts.dart';

class SelectableTextBox extends StatelessWidget {
  const SelectableTextBox({
    super.key,
    required this.text,
    required this.isSelected,
    this.maxWidth,
  });
  final String text;
  final bool isSelected;
  final double? maxWidth;
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        height: 38.h,
        constraints: BoxConstraints(
          minWidth: 48,
          // maxWidth: maxWidth ?? double.infinity,
        ),
        margin: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.myPrimary : AppColors.myScaffold,
          border: Border.all(
            color: AppColors.greyCA,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w,),
          child: Center(
            child: Text(
              text,
              style: AppTextStyles.headline3.copyWith(
                color: isSelected ? AppColors.myScaffold : AppColors.myPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
