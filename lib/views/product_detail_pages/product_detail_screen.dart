import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_doctor/resources/widgets/product_widget/color_palette_Widget.dart';
import 'package:golden_doctor/resources/widgets/universal_widget/app_button.dart';
import 'package:golden_doctor/resources/widgets/universal_widget/selectable_textbox.dart';
import 'package:golden_doctor/utils/app_colors.dart';
import 'package:golden_doctor/utils/app_constant.dart';
import 'package:golden_doctor/utils/app_fonts.dart';
import 'package:golden_doctor/utils/app_images.dart';



var list = [
  {
    "title": "black",
    "code": "0xff2345f",
  },
];
List col = [
      "black",
      "red",
      "green",
      "orange",
      "yello",
      "black",
      "red",
      "green",
      "orange",
      "yello",
    ];

    List fittype = [
      "Regular",
      "Petite",
    ];
class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 479.h,
            pinned: true,
            backgroundColor: AppColors.myScaffold,
            elevation: 0,
            forceElevated: false,
            surfaceTintColor: AppColors.myScaffold,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.zero,
              collapseMode: CollapseMode.pin,
              background: CarouselSlider.builder(
                itemCount: 5,
                itemBuilder: (contaxt, index, _) {
                  return CachedNetworkImage(
                    imageUrl:
                        "https://scrubser-shop.com/wp-content/uploads/2024/02/CK131A_A.jpg",
                    fit: BoxFit.fill,
                    height: double.infinity,
                    width: double.infinity,
                    placeholder: (context, url) => SizedBox(
                      height: 70.h,
                      width: 70.w,
                      child: Center(
                        child: Image(
                          image: AssetImage(
                            AppImages.horizantelLogo,
                          ),
                          fit: BoxFit.contain,
                          height: 70.h,
                          width: 120.w,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  );
                },
                options: CarouselOptions(
                  aspectRatio: 3 / 6,
                  viewportFraction: 1,
                ),
              ),

              // title: Text("title"),
            ),
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 30.h),
              child: Container(
                height: 30.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(70),
                  ),
                  color: AppColors.myScaffold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    "Catarina One-Pocket Scrub Top™",
                    style: AppTextStyles.headline2.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Brand Name",
                    style: AppTextStyles.lable3.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text(
                        "COLOR    ",
                        style: AppTextStyles.headline3.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text("Black", style: AppTextStyles.lable3),
                    ],
                  ),
                  Wrap(
                    children: [
                      ...col.map(
                        (e) => ColorPalateWidget(
                          colorName: e,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text(
                        "SIZE TYPE    ",
                        style: AppTextStyles.headline3.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text("Regular", style: AppTextStyles.lable3),
                    ],
                  ),
                  SizedBox(
                    height: 29,
                    child: ListView.builder(
                      itemCount: fittype.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SelectableTextBox(
                          text: fittype[index],
                          isSelected: index == 0 ? true : false,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "SIZE",
                        style: AppTextStyles.headline3.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "What's my size?",
                        style: AppTextStyles.lable3.copyWith(
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      ...AppConstant.sizesList.map(
                        (e) => SelectableTextBox(
                          text: e,
                          isSelected: e == "XXL" ? true : false,
                          maxWidth: 50.w,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text("SAR 350"),
                      SizedBox(width: 20),
                      Flexible(
                        child: AppButtons.myprimaryButton(
                          onPressed: () {},
                          text: 'ADD TO BAG',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  AppButtons.myTextButton(
                    text: "Size Chart",
                    textStyle: AppTextStyles.lable3.copyWith(
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      // color: appcolor
                    ),
                    onPressed: () {},
                    context: context,
                  ),
                  Text(
                    "PERSONALIZE",
                    style: AppTextStyles.headline3.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 17.w),
                    // margin: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Add Embroidery"),
                        Text("From 14 SAR"),
                      ],
                    ),
                  ),
                  ExpansionTile(
                    shape: Border(),
                    minTileHeight: 5.h,
                    tilePadding: EdgeInsets.all(0),
                    title: Text(
                      "DESCRIPTION",
                      style: AppTextStyles.headline3.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_drop_down_rounded,
                      color: AppColors.buttonColor,
                      size: 25,
                    ),
                    children: [
                      Html(
                        data: "",
                      ),
                    ],
                  ),
                  ExpansionTile(
                    shape: Border(),
                    minTileHeight: 5.h,
                    tilePadding: EdgeInsets.all(0),
                    title: Text(
                      "DELIVERY & RETURNS",
                      style: AppTextStyles.headline3.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_drop_down_rounded,
                      color: AppColors.buttonColor,
                      size: 25,
                    ),
                    children: [
                      Html(
                        data: "",
                      ),
                    ],
                  ),
                  Text(
                    "Popular Product",
                    style: AppTextStyles.headline3.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Recomanded Product",
                    style: AppTextStyles.headline3.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
