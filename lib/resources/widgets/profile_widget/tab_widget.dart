import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_doctor/utils/app_colors.dart';
import 'package:golden_doctor/utils/app_fonts.dart';

class TabWidget extends StatelessWidget {
  final String tabTitle;
  final VoidCallback? onTap;
  const TabWidget({
    super.key,
    required this.tabTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: 15.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tabTitle,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.black2022,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.buttonColor,
                  size: 20.sp,
                ),
              ],
            ),
            Divider(
              color: AppColors.greyF2F2,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
