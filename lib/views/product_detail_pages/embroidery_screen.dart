import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:golden_doctor/graph_ql/query/mutation_query.dart';
import 'package:golden_doctor/models/cart/cart_model.dart';
import 'package:golden_doctor/models/products/product_model.dart';
import 'package:golden_doctor/resources/widgets/universal_widget/app_button.dart';
import 'package:golden_doctor/utils/app_colors.dart';
import 'package:golden_doctor/utils/app_constant.dart';
import 'package:golden_doctor/utils/app_fonts.dart';
import 'package:golden_doctor/utils/app_images.dart';
import 'package:golden_doctor/view_models/language_provider.dart';
import 'package:golden_doctor/view_models/product_details_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../view_models/embroidery_view_model/embroidery_view_model.dart';

// String defineText = 'Ahmad';

class EmbroideryScreen extends ConsumerWidget {
  final String embroideryProductID;
  final String parentId;
  final String uniquePageKey;
  final List<String> tags;
  const EmbroideryScreen({
    required this.embroideryProductID,
    required this.parentId,
    required this.uniquePageKey,
    required this.tags,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print(productID);
    final productDetailProvider =
        ref.read(productDetailsProvider(uniquePageKey).notifier);
    // ---------------------
    // final addTextProviderWatch = ref.watch(addTextBoolProvider);
    final textPositionPro = ref.watch(textPositionProvider);
    final textColorPro = ref.watch(textColorProvider);
    final textfontPro = ref.watch(textFontProvider);
    final textNamePro = ref.watch(textName1Provider);
    final textNameoptionalPro = ref.watch(textName2Provider);
    // final embroideryProviderWatch = ref.watch(embroideryProvider);
    // final addTextValue = ref.watch(embroideryProvider).addtext;
    // final addMessage = ref.watch(embroideryProvider).message;

    return Directionality(
      textDirection: AppConstant.selectedLanguage == 'EN'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Personalize your figs'.tr,
            // style: AppTextStyles.body1,
          ),
        ),
        body: Query(
          options: QueryOptions(
              document: gql(fetchSignleProduct(embroideryProductID))),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            ProductNode productNode;
            if (result.hasException) {
              return Center(
                child: FractionallySizedBox(
                  widthFactor: 0.3,
                  child: AppButtons.myprimaryButton(
                    onPressed: () {
                      refetch!();
                    },
                    text: "Try Again".tr,
                  ),
                ),
              );
            }
            if (result.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (result.data != null) {
              // print("111111111111111111");
              // print(result.data);
              productNode = ProductNode.fromJson(result.data!['product']);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    // ------------ image -------------
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(5),
                          ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // ----Image---
                          Container(
                            width: double.infinity,
                            // height: 202.h,
                            decoration: BoxDecoration(
                              color: AppColors.greyCA,
                            ),
                            child: AspectRatio(
                              aspectRatio: 6 / 7,
                              child:
                                  // Container(
                                  //   // height: 480.h,
                                  //   width: MediaQuery.of(context).size.width,
                                  //   decoration: BoxDecoration(
                                  //     color: AppColors.myScaffold,
                                  //     image: DecorationImage(
                                  //       image: AssetImage(
                                  //         AppImages.embroderyImage,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl:
                                    // 'https://pixlr.com/images/generator/photo-generator.webp',
                                    productNode.images.edges[0].node.url,
                                // height: 200.h,
                                placeholder: (context, url) => SizedBox(
                                  width: double.infinity,
                                  height: 480.h,
                                  child: Center(
                                    child: Image(
                                      image: AssetImage(
                                        AppImages.embroderyImage,
                                      ),
                                      width: double.infinity,
                                      height: 480.h,
                                      // opacity: AlwaysStoppedAnimation(0.3),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                          // ----text on img----
                          Positioned(
                            top: 80.h,
                            left: textPositionPro == "Left Chest" ? 100.w : 0,
                            right: textPositionPro == "Right Chest" ? 100.w : 0,
                            child: SizedBox(
                              // height: 24,
                              // width: 24,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // defineText,
                                      textNamePro.tr,
                                      style: textfontPro == 'Block'
                                          ? GoogleFonts.poppins(
                                              color: textColorPro == 'Black'
                                                  ? AppColors.buttonColor
                                                  : AppColors.myScaffold,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                            )
                                          : GoogleFonts.dancingScript(
                                              color: textColorPro == 'Black'
                                                  ? AppColors.buttonColor
                                                  : AppColors.myScaffold,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                    ),
                                    Text(
                                      // defineText,
                                      textNameoptionalPro.tr,
                                      style: textfontPro == 'Black'
                                          ? GoogleFonts.poppins(
                                              color: textColorPro == 'Black'
                                                  ? AppColors.buttonColor
                                                  : AppColors.myScaffold,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                            )
                                          : GoogleFonts.dancingScript(
                                              color: textColorPro == 'Black'
                                                  ? AppColors.buttonColor
                                                  : AppColors.myScaffold,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // addTextProviderWatch
                    //     ?
                    SizedBox(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      size: 15,
                                    ),
                                  ),
                                  Text(
                                    'Back'.tr,
                                    style: AppTextStyles.body1.copyWith(
                                      color: AppColors.black28,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                'Add Text'.tr,
                                style: AppTextStyles.body1.copyWith(
                                  color: AppColors.black28,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 15.w),
                                child: Text(
                                  '+${productNode.variants.edges[0].node.price.amount}',
                                  style: AppTextStyles.body1.copyWith(
                                    color: AppColors.black28,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(color: AppColors.black28),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.w, right: 15.w, top: 24.h),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.h),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'First Line'.tr,
                                      style: AppTextStyles.body1.copyWith(
                                        color: AppColors.black28,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                // AppTextfields.sharpCornerTextField(
                                //   controller: AppTextfieldControllers
                                //       .embroideryfirstTextFieldControler,
                                //   lable: 'Write Here',
                                // ),

                                TextField(
                                  style: AppTextStyles.body2,
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 12),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide:
                                            BorderSide(color: AppColors.grey)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: BorderSide(
                                            color: AppColors.myPrimary)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                            color: AppColors.myPrimary)),
                                    hintText: 'Write Here'.tr,
                                    hintStyle: TextStyle(
                                        color: AppColors.grey, fontSize: 13.sp),
                                    floatingLabelStyle: TextStyle(
                                      color: AppColors.myPrimary,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    ref.read(textName1Provider.notifier).state =
                                        value;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.w, right: 15.w, top: 24.h),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.h),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Second Line (Optional)'.tr,
                                      style: AppTextStyles.body1.copyWith(
                                        color: AppColors.black28,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                // AppTextfields.sharpCornerTextField(
                                //   controller: AppTextfieldControllers
                                //       .embroiderysecondTextFieldControler,
                                //   lable: 'Write Here',
                                // ),
                                TextField(
                                  style: AppTextStyles.body2,
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 12),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide:
                                            BorderSide(color: AppColors.grey)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: BorderSide(
                                            color: AppColors.myPrimary)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                            color: AppColors.myPrimary)),
                                    hintText: 'Write Here'.tr,
                                    hintStyle: TextStyle(
                                        color: AppColors.grey, fontSize: 13.sp),
                                    floatingLabelStyle: TextStyle(
                                      color: AppColors.myPrimary,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    ref.read(textName2Provider.notifier).state =
                                        value;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: tags.contains('SelectPosition'),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 15.w, right: 15.w, top: 24.h),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 7.h),
                                    child: Row(
                                      children: [
                                        Text(
                                          'SIZE TEXT POSITION'.tr,
                                          style: AppTextStyles.body1.copyWith(
                                            color: AppColors.black28,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(width: 15.w),
                                        Text(
                                          textPositionPro.tr,
                                          style: AppTextStyles.body3,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(
                                                  textPositionProvider.notifier)
                                              .state = 'Left Chest';
                                        },
                                        child: Container(
                                          height: 38.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                              color: textPositionPro ==
                                                      'Left Chest'
                                                  ? AppColors.black1C
                                                  : AppColors.myScaffold,
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                              border: Border.all(
                                                color: textPositionPro ==
                                                        'Left Chest'
                                                    ? AppColors.black1C
                                                    : AppColors.grey94,
                                              )),
                                          child: Center(
                                            child: Text(
                                              'Left Chest'.tr,
                                              style:
                                                  AppTextStyles.body2.copyWith(
                                                color: textPositionPro ==
                                                        'Left Chest'
                                                    ? AppColors.myScaffold
                                                    : AppColors.black1C,

                                                // AppColors.myScaffold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 15.w),
                                      GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(
                                                  textPositionProvider.notifier)
                                              .state = 'Right Chest';
                                        },
                                        child: Container(
                                          height: 38.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                              color: textPositionPro ==
                                                      'Right Chest'
                                                  ? AppColors.black1C
                                                  : AppColors.myScaffold,

                                              //  AppColors.black1C,
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                              border: Border.all(
                                                color: textPositionPro ==
                                                        'Right Chest'
                                                    ? AppColors.black1C
                                                    : AppColors.grey70,
                                              )),
                                          child: Center(
                                            child: Text(
                                              'Right Chest'.tr,
                                              style:
                                                  AppTextStyles.body2.copyWith(
                                                color: textPositionPro ==
                                                        'Right Chest'
                                                    ? AppColors.myScaffold
                                                    : AppColors.black1C,

                                                //  AppColors.myScaffold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: tags.contains('SelectColor'),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 15.w, right: 15.w, top: 24.h),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 7.h),
                                    child: Row(
                                      children: [
                                        Text(
                                          'SELECT TEXT COLOR'.tr,
                                          style: AppTextStyles.body1.copyWith(
                                            color: AppColors.black28,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(width: 15.w),
                                        Text(
                                          textColorPro.tr,
                                          style: AppTextStyles.body3,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(textColorProvider.notifier)
                                              .state = 'Black';
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10.w),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: textColorPro == 'Black'
                                                  ? AppColors.myPrimary
                                                  : AppColors.myScaffold,
                                            ),
                                          ),
                                          child: Container(
                                            height: 39.h,
                                            width: 39.w,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.black1C,
                                            ),
                                            child: textColorPro == 'Black'
                                                ? Icon(
                                                    Icons.check,
                                                    color: AppColors.myScaffold,
                                                  )
                                                : SizedBox(),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(textColorProvider.notifier)
                                              .state = 'White';
                                        },
                                        child: Container(
                                          //   height: 39.h,
                                          // width: 39.w,
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: textColorPro == 'White'
                                                  ? AppColors.myPrimary
                                                  : Colors.transparent,
                                            ),
                                          ),
                                          child: Container(
                                            height: 39.h,
                                            width: 39.w,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.myScaffold,
                                              border: Border.all(
                                                  color: AppColors.grey),
                                            ),
                                            child: textColorPro == 'White'
                                                ? Icon(
                                                    Icons.check,
                                                  )
                                                : SizedBox(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: tags.contains('SelectFont'),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 15.w, right: 15.w, top: 24.h),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 7.h),
                                    child: Row(
                                      children: [
                                        Text(
                                          'SIZE FONT TYPE'.tr,
                                          style: AppTextStyles.body1.copyWith(
                                            color: AppColors.black28,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(width: 15.w),
                                        Text(
                                          textfontPro.tr,
                                          style: AppTextStyles.body3,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(textFontProvider.notifier)
                                              .state = 'Block';
                                        },
                                        child: Container(
                                          height: 38.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                              color: textfontPro == 'Block'
                                                  ? AppColors.black1C
                                                  : AppColors.myScaffold,
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                              border: Border.all(
                                                color: textfontPro == 'Block'
                                                    ? AppColors.black1C
                                                    : AppColors.grey94,
                                              )),
                                          child: Center(
                                            child: Text(
                                              'Block'.tr,
                                              style:
                                                  AppTextStyles.body2.copyWith(
                                                color: textfontPro == 'Block'
                                                    ? AppColors.myScaffold
                                                    : AppColors.black1C,

                                                // AppColors.myScaffold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(textFontProvider.notifier)
                                              .state = 'Script';
                                        },
                                        child: Container(
                                          height: 38.h,
                                          width: 100.w,
                                          // margin: EdgeInsets.only(left: 20.w),
                                          decoration: BoxDecoration(
                                              color: textfontPro == 'Script'
                                                  ? AppColors.black1C
                                                  : AppColors.myScaffold,

                                              //  AppColors.black1C,
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                              border: Border.all(
                                                color: textfontPro == 'Script'
                                                    ? AppColors.black1C
                                                    : AppColors.grey70,
                                              )),
                                          child: Center(
                                            child: Text(
                                              'Script'.tr,
                                              style:
                                                  AppTextStyles.body2.copyWith(
                                                color: textfontPro == 'Script'
                                                    ? AppColors.myScaffold
                                                    : AppColors.black1C,

                                                //  AppColors.myScaffold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 15.w, right: 15.w, top: 24.h),
                              child: Divider(
                                color: AppColors.black28,
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 15.w, right: 15.w, top: 24.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 150.w,
                                    child: AppButtons.myOutlinedButton(
                                      onPressed: () {
                                        ref
                                            .read(textPositionProvider.notifier)
                                            .state = 'Left Chest';
                                        ref
                                            .read(textColorProvider.notifier)
                                            .state = 'Black';
                                        ref
                                            .read(textFontProvider.notifier)
                                            .state = 'Block';
                                      },
                                      text: 'RESEET'.tr,
                                      // textColor: AppColors.myScaffold,
                                      // color: AppColors.myScaffold,
                                      context: context,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                    child: AppButtons.myprimaryButton(
                                        onPressed: () {
                                          productDetailProvider.addEmbroidery(
                                            embroideryOptionsArg: CartModel(
                                              available: true,
                                              isEmbroidery: true,
                                              comparePrice: productNode.variants
                                                  .edges[0].node.price.amount,
                                              productPrice: productNode.variants
                                                  .edges[0].node.price.amount,
                                              productId: productNode.id,
                                              varientId: productNode
                                                  .variants.edges[0].node.id,
                                              productName: productNode.title,
                                              productImage: productNode
                                                  .images.edges[0].node.url,
                                              quantity: "1",
                                              embroideryOptions:
                                                  EmbroideryOptions(
                                                line1: textNamePro,
                                                line2: textNameoptionalPro,
                                                parentId: parentId,
                                                tags: tags,
                                                color: textColorPro,
                                                font: textfontPro,
                                                position: textPositionPro,
                                              ),
                                            ),
                                          );
                                          context.pop();
                                        },
                                        text: '${"ADD".tr} +\$14'),
                                  ),
                                ],
                              )),
                          SizedBox(height: 15.h)
                        ],
                      ),
                    ),
                    // : Column(
                    //     children: [
                    //       Padding(
                    //         padding: EdgeInsets.only(top: 35.h),
                    //         child: Center(
                    //           child: Text(
                    //             'Embroidery Options',
                    //             style: AppTextStyles.headline1.copyWith(
                    //               fontSize: 14.sp,
                    //               fontWeight: FontWeight.w700,
                    //               color: AppColors.black28,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       CheckboxListTile(
                    //         value: addTextProviderWatch,
                    //         onChanged: (value) {
                    //           ref.read(addTextBoolProvider.notifier).state =
                    //               value!;
                    //         },
                    //         controlAffinity:
                    //             ListTileControlAffinity.leading,
                    //         title: Row(
                    //           mainAxisAlignment:
                    //               MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text(
                    //               'Add Text',
                    //               style: AppTextStyles.body1.copyWith(
                    //                 fontSize: 14.sp,
                    //                 fontWeight: FontWeight.w700,
                    //               ),
                    //             ),
                    //             Text(
                    //               '+14.00',
                    //               style: AppTextStyles.body1.copyWith(
                    //                 fontSize: 14.sp,
                    //                 fontWeight: FontWeight.w700,
                    //                 color: AppColors.buttonColor,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                  ],
                ),
              );
            } else {
              return Center(
                child: FutureBuilder(
                    future: Future.delayed(
                      Duration(seconds: 7),
                      () => true,
                    ),
                    builder: (context, snap) {
                      if (snap.hasData) {
                        return Center(
                          child: FractionallySizedBox(
                            widthFactor: 0.3,
                            child: AppButtons.myprimaryButton(
                              onPressed: () {
                                refetch!();
                              },
                              text: "Try Again".tr,
                            ),
                          ),
                        );
                      }
                      return CircularProgressIndicator();
                    }),
              );
            }
          },
        ),
      ),
    );
  }
}
