import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      body:    getBrandAsync.when(
        data: (brandVal) {
          return
        Text(brandVal.toString());
        },
        loading: () => CircularProgressIndicator(),
        error: (err, stack) => Text('Error: $err'),
      ),
                 
    );
  }
}
