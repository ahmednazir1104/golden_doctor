import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_doctor/models/static_pages_model/static_pages_model.dart';
import 'package:golden_doctor/utils/app_fonts.dart';

class StaticPagesScreen extends ConsumerWidget {
  final StaticPagesModel singlePage;
  const StaticPagesScreen({super.key, required this.singlePage});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          singlePage.title,
          style: AppTextStyles.body2,
        ),
      ),
      body: Center(
        child: Text(
          singlePage.content,
          style: AppTextStyles.body1,
        ),
      ),
    );
  }
}
