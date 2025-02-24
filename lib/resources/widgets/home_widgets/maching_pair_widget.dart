import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:golden_doctor/models/home_model/maching_pair_model.dart';

// ignore: must_be_immutable
class MachingPairWidgetWidget extends StatelessWidget {
  MatchingPairsSection section;

  MachingPairWidgetWidget({
    super.key,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/setBuilderScreen', extra: {
          'collection1': section.body[0].objId,
          'collection2': section.body[1].objId,
        });
      },
      child: Container(
        height: double.parse(section.height.toString()),
        // height: 500,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 36.h),
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(section.desktopImg.toString())
              // AssetImage(
              //   AppImages.createSetImage,
              // ),
              ),
        ),
      ),
    );
  }
}
