import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_doctor/models/product_quantity_model.dart/product_quantity_model.dart';
import 'package:golden_doctor/models/products/product_model.dart';
import 'package:golden_doctor/resources/widgets/product_widget/color_palette_widget.dart';
import 'package:golden_doctor/resources/widgets/universal_widget/app_button.dart';
import 'package:golden_doctor/resources/widgets/universal_widget/selectable_textbox.dart';
import 'package:golden_doctor/utils/app_colors.dart';
import 'package:golden_doctor/utils/app_constant.dart';
import 'package:golden_doctor/utils/app_fonts.dart';
import 'package:golden_doctor/view_models/language_provider.dart';
import 'package:golden_doctor/view_models/product_details_view_model.dart';
import 'package:golden_doctor/view_models/set_builder_view_model.dart';

class SetBuilderScreen extends ConsumerWidget {
  final String collection1;
  final String collection2;
  const SetBuilderScreen({
    super.key,
    required this.collection1,
    required this.collection2,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CarouselSliderController shirtCarouselController =
        CarouselSliderController();
    CarouselSliderController pantCarouselController =
        CarouselSliderController();

    int shirtIndex = -1;
    int pantIndex = -1;

    // final setBuilderRead = ref.read(setBuilderProvider.notifier);
    // ref.watch(setBuilderProvider.select((value)=> value.productList1));
    List col = [
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
    print("0000000000000000000000");
    return Directionality(
      textDirection: AppConstant.selectedLanguage == 'EN'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title:
              Image.asset("assets/app_images/horizantelLogo.png", height: 32),
          actions: [
            IconButton(
              icon: const Icon(Icons.search_rounded),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(CupertinoIcons.barcode_viewfinder),
              onPressed: () {},
            ),
          ],
        ),
        body: FutureBuilder(
          future: ref
              .read(setBuilderProvider.notifier)
              .fetchProductsByCollectionIDs(
                collectionID1: collection1,
                collectionID2: collection2,
              ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null) {
              if (kDebugMode) {
                print(snapshot.data);
              }
              return Center(
                child: Text("No data found\n Please try again"),
              );
            }
            // ref.watch(setBuilderProvider.select((value)=> value.));
            // print("11111111111111111111");
            return Consumer(
              builder: (context, ref, child) {
                final setBuilderWatch = ref.watch(setBuilderProvider);
                final setBuilderRead = ref.read(setBuilderProvider.notifier);
                ProductEdge displayProduct1 =
                    snapshot.data![0][setBuilderWatch.firstDisplyProductIndex];
                ProductEdge displayProduct2 =
                    snapshot.data![1][setBuilderWatch.secondDisplyProductIndex];
                // print("2222222222222222222222222222");
                // print(setBuilderWatch.firstDisplyProductIndex);
                // ---------------------

                // This will initialize the base varients and options for top product
                if (setBuilderWatch.firstDisplyProductIndex != shirtIndex) {
                  shirtIndex = setBuilderWatch.firstDisplyProductIndex;
                  ref
                      .read(productDetailsProvider("set-builder-product-1")
                          .notifier)
                      .productQuentity(context, displayProduct1.node.id);

                  Future.delayed(Duration(seconds: 0)).then((value) {
                    ref
                        .read(productDetailsProvider("set-builder-product-1")
                            .notifier)
                        .selectOption(
                          displayProduct1
                              .node.variants.edges[0].node.selectedOptions,
                        );
                  });
                }
                // This will initialize the base varients and options for second product
                if (setBuilderWatch.secondDisplyProductIndex != pantIndex) {
                  pantIndex = setBuilderWatch.secondDisplyProductIndex;
                  ref
                      .read(productDetailsProvider("set-builder-product-2")
                          .notifier)
                      .productQuentity(context, displayProduct2.node.id);

                  Future.delayed(Duration(seconds: 0)).then((value) {
                    ref
                        .read(productDetailsProvider("set-builder-product-2")
                            .notifier)
                        .selectOption(
                          displayProduct2
                              .node.variants.edges[0].node.selectedOptions,
                        );
                  });
                }

                final optionsWatch1 =
                    ref.watch(productDetailsProvider("set-builder-product-1"));
                final optionsRead1 = ref.read(
                    productDetailsProvider("set-builder-product-1").notifier);
                VariantsEdge selectedVariant1 = optionsRead1.selectVariant(
                    purpleNode: displayProduct1.node);
                ProductQuantityModel? productQuantityModel1;
                // ----------------
                final optionsWatch2 =
                    ref.watch(productDetailsProvider("set-builder-product-2"));
                final optionsRead2 = ref.read(
                    productDetailsProvider("set-builder-product-2").notifier);
                VariantsEdge selectedVariant2 = optionsRead2.selectVariant(
                    purpleNode: displayProduct2.node);
                ProductQuantityModel? productQuantityModel2;

                // --------------------------

                return SingleChildScrollView(
                  child: Column(
                    spacing: 30.h,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // -------- images ----------
                          Container(
                            color: AppColors.greyF2,
                            height: 683.h,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                spacing: 20.h,
                                children: [
                                  Stack(
                                    children: [
                                      CarouselSlider.builder(
                                        carouselController:
                                            shirtCarouselController,
                                        itemCount: snapshot.data![0].length,
                                        itemBuilder: (context, index, _) {
                                          return CachedNetworkImage(
                                            imageUrl: snapshot.data![0][index]
                                                .node.images.edges[0].node.url,
                                            width: double.infinity,
                                            height: 180.h,
                                            fit: BoxFit.fitHeight,
                                          );
                                        },
                                        options: CarouselOptions(
                                          height: 180.h,
                                          viewportFraction: 1,
                                          enableInfiniteScroll: false,
                                          onPageChanged: (index, reason) {
                                            Future.delayed(
                                              Duration(milliseconds: 170),
                                              () => setBuilderRead
                                                  .changeDisplyProduct(
                                                movement: setBuilderRead
                                                            .firstDisplyProductIndex <
                                                        index
                                                    ? 1
                                                    : -1,
                                                productList: snapshot.data![0],
                                                itemIndex: 0,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      // Image.asset(
                                      //   "assets/app_images/tshirtImage.png",
                                      //   fit: BoxFit.fitHeight,
                                      //   height: 180.h,
                                      //   width: double.infinity,
                                      // ),
                                      Positioned(
                                        top: 88.h,
                                        left: 0.w,
                                        child: IconButton(
                                          onPressed: () {
                                            shirtCarouselController
                                                .previousPage();
                                          },
                                          icon: Icon(Icons.keyboard_arrow_left),
                                        ),
                                      ),
                                      Positioned(
                                        top: 88.h,
                                        right: 0.w,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          visualDensity: VisualDensity.compact,
                                          onPressed: () {
                                            shirtCarouselController.nextPage();
                                          },
                                          icon:
                                              Icon(Icons.keyboard_arrow_right),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      CarouselSlider.builder(
                                        carouselController:
                                            pantCarouselController,
                                        itemCount: snapshot.data![1].length,
                                        itemBuilder: (context, index, _) {
                                          return CachedNetworkImage(
                                            imageUrl: snapshot.data![1][index]
                                                .node.images.edges[0].node.url,
                                            width: double.infinity,
                                            height: 180.h,
                                            fit: BoxFit.fitHeight,
                                          );
                                        },
                                        options: CarouselOptions(
                                          height: 272.h,
                                          viewportFraction: 1,
                                          enableInfiniteScroll: false,
                                          onPageChanged: (index, reason) {
                                            Future.delayed(
                                              Duration(milliseconds: 170),
                                              () => setBuilderRead
                                                  .changeDisplyProduct(
                                                movement: setBuilderRead
                                                            .secondDisplyProductIndex <
                                                        index
                                                    ? 1
                                                    : -1,
                                                productList: snapshot.data![1],
                                                itemIndex: 1,
                                              ),
                                            );
                                          },
                                        ),
                                      ),

                                      // Image.asset(
                                      //   "assets/app_images/trouserImage.png",
                                      //   // fit: BoxFit.fitWidth,
                                      //   width: double.infinity,
                                      //   // MediaQuery.of(context).size.width * 0.5 - 90,
                                      //   height: 272.h,
                                      // ),
                                      Positioned(
                                        top: 88.h,
                                        left: 0.w,
                                        child: IconButton(
                                          onPressed: () {
                                            pantCarouselController
                                                .previousPage();
                                          },
                                          icon: Icon(Icons.keyboard_arrow_left),
                                        ),
                                      ),
                                      Positioned(
                                        top: 88.h,
                                        right: 0.w,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          visualDensity: VisualDensity.compact,
                                          onPressed: () {
                                            pantCarouselController.nextPage();
                                          },
                                          icon:
                                              Icon(Icons.keyboard_arrow_right),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // -------- product description ---------
                          Expanded(
                            child: Column(
                              children: [
                                // --------- shirt --------
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 7.h,
                                    children: [
                                      Text(
                                        // setBuilderWatch
                                        //     .selectedVariant1!
                                        //     .node
                                        //     .title,
                                        displayProduct1.node
                                            .title, //"Catarina One-Pocket Scrub Top™",
                                        style: AppTextStyles.headline3.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        "${"SAR".tr} ${selectedVariant1.node.price.amount}", //"\$ 38.00",
                                        style: AppTextStyles.lable3.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      optionsWatch1.selectedOptions.isEmpty
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: displayProduct1
                                                  .node.options.length,
                                              itemBuilder: (context, index) {
                                                Options singleProOption =
                                                    displayProduct1
                                                        .node.options[index];
                                                switch (singleProOption.name) {
                                                  case 'Color':
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "COLOR ",
                                                              style:
                                                                  AppTextStyles
                                                                      .headline3
                                                                      .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                            Text(
                                                              selectedVariant1
                                                                  .node
                                                                  .selectedOptions
                                                                  .firstWhere(
                                                                    (e) =>
                                                                        e.name ==
                                                                        singleProOption
                                                                            .name,
                                                                  )
                                                                  .value, //"Black",
                                                              style:
                                                                  AppTextStyles
                                                                      .lable3
                                                                      .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 29,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: singleProOption
                                                                      .optionValues
                                                                      .length, //col.length,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return ColorPalateWidget(
                                                                      optionKey:
                                                                          singleProOption
                                                                              .name,
                                                                      // "color",
                                                                      optionValue: singleProOption
                                                                          .optionValues[
                                                                              index]
                                                                          .name,
                                                                      // col[index],
                                                                      uniquePageKey:
                                                                          "set-builder-product-1",
                                                                    );
                                                                  }),
                                                        ),
                                                      ],
                                                    );
                                                  case 'Length':
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "SIZE TYPE  ",
                                                              style:
                                                                  AppTextStyles
                                                                      .headline3
                                                                      .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                            Text(
                                                              selectedVariant1
                                                                  .node
                                                                  .selectedOptions
                                                                  .firstWhere((e) =>
                                                                      e.name ==
                                                                      singleProOption
                                                                          .name)
                                                                  .value,
                                                              // "Regular",
                                                              style:
                                                                  AppTextStyles
                                                                      .lable3,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 29,
                                                          child:
                                                              ListView.builder(
                                                            itemCount:
                                                                singleProOption
                                                                    .optionValues
                                                                    .length,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  var temp =
                                                                      optionsWatch1
                                                                          .selectedOptions;
                                                                  temp[temp.indexWhere((x) =>
                                                                      x.name ==
                                                                      singleProOption
                                                                          .name)] = SelectedOption(
                                                                    name: singleProOption
                                                                        .name,
                                                                    value: singleProOption
                                                                        .optionValues[
                                                                            index]
                                                                        .name,
                                                                  );

                                                                  optionsRead1
                                                                      .selectOption(
                                                                          temp);
                                                                },
                                                                child:
                                                                    SelectableTextBox(
                                                                  text: singleProOption
                                                                      .optionValues[
                                                                          index]
                                                                      .name,
                                                                  isSelected: singleProOption
                                                                              .optionValues[
                                                                                  index]
                                                                              .name ==
                                                                          optionsWatch1
                                                                              .selectedOptions
                                                                              .firstWhere((e) => e.name == singleProOption.name)
                                                                              .value
                                                                      ? true
                                                                      : false,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  case 'Size':
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 20),
                                                          child: AppButtons
                                                              .myprimaryButton(
                                                            onPressed: () {},
                                                            height: 30.h,
                                                            text:
                                                                "What’s My size",
                                                            color: AppColors
                                                                .greyF2,
                                                            textColor: AppColors
                                                                .black1C,
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "SIZE",
                                                              style:
                                                                  AppTextStyles
                                                                      .headline3
                                                                      .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                            Text(
                                                              "Size Chart",
                                                              style:
                                                                  AppTextStyles
                                                                      .lable2
                                                                      .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 29,
                                                          child:
                                                              ListView.builder(
                                                            itemCount:
                                                                singleProOption
                                                                    .optionValues
                                                                    .length,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  var temp =
                                                                      optionsWatch1
                                                                          .selectedOptions;
                                                                  temp[temp.indexWhere((x) =>
                                                                      x.name ==
                                                                      singleProOption
                                                                          .name)] = SelectedOption(
                                                                    name: singleProOption
                                                                        .name,
                                                                    value: singleProOption
                                                                        .optionValues[
                                                                            index]
                                                                        .name,
                                                                  );

                                                                  optionsRead1
                                                                      .selectOption(
                                                                          temp);
                                                                },
                                                                child:
                                                                    SelectableTextBox(
                                                                  text: singleProOption
                                                                      .optionValues[
                                                                          index]
                                                                      .name,
                                                                  isSelected: singleProOption
                                                                              .optionValues[
                                                                                  index]
                                                                              .name ==
                                                                          optionsWatch1
                                                                              .selectedOptions
                                                                              .firstWhere((e) => e.name == singleProOption.name)
                                                                              .value
                                                                      ? true
                                                                      : false,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  default:
                                                    return SizedBox();
                                                }
                                              }),
                                    ],
                                  ),
                                ),
                                Divider(),
                                // --------- pant --------
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 7.h,
                                    children: [
                                      Text(
                                        // setBuilderWatch
                                        //     .selectedVariant1!
                                        //     .node
                                        //     .title,
                                        displayProduct2.node
                                            .title, //"Catarina One-Pocket Scrub Top™",
                                        style: AppTextStyles.headline3.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        "${"SAR".tr} ${selectedVariant2.node.price.amount}", //"\$ 38.00",
                                        style: AppTextStyles.lable3.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      optionsWatch2.selectedOptions.isEmpty
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: displayProduct2
                                                  .node.options.length,
                                              itemBuilder: (context, index) {
                                                Options singleProOption =
                                                    displayProduct2
                                                        .node.options[index];
                                                switch (singleProOption.name) {
                                                  case 'Color':
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "COLOR ",
                                                              style:
                                                                  AppTextStyles
                                                                      .headline3
                                                                      .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                            Text(
                                                              selectedVariant2
                                                                  .node
                                                                  .selectedOptions
                                                                  .firstWhere(
                                                                    (e) =>
                                                                        e.name ==
                                                                        singleProOption
                                                                            .name,
                                                                  )
                                                                  .value, //"Black",
                                                              style:
                                                                  AppTextStyles
                                                                      .lable3
                                                                      .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 29,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: singleProOption
                                                                      .optionValues
                                                                      .length, //col.length,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return ColorPalateWidget(
                                                                      optionKey:
                                                                          singleProOption
                                                                              .name,
                                                                      // "color",
                                                                      optionValue: singleProOption
                                                                          .optionValues[
                                                                              index]
                                                                          .name,
                                                                      // col[index],
                                                                      uniquePageKey:
                                                                          "set-builder-product-2",
                                                                    );
                                                                  }),
                                                        ),
                                                      ],
                                                    );
                                                  case 'Length':
                                                    return !selectedVariant2
                                                            .node
                                                            .selectedOptions
                                                            .any((e) =>
                                                                e.name ==
                                                                singleProOption
                                                                    .name)
                                                        ? SizedBox()
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "SIZE TYPE  ",
                                                                    style: AppTextStyles
                                                                        .headline3
                                                                        .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    selectedVariant2
                                                                        .node
                                                                        .selectedOptions
                                                                        .firstWhere((e) =>
                                                                            e.name ==
                                                                            singleProOption.name)
                                                                        .value,
                                                                    // "Regular",
                                                                    style: AppTextStyles
                                                                        .lable3,
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 29,
                                                                child: ListView
                                                                    .builder(
                                                                  itemCount:
                                                                      singleProOption
                                                                          .optionValues
                                                                          .length,
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        var temp =
                                                                            optionsWatch2.selectedOptions;
                                                                        temp[temp.indexWhere((x) =>
                                                                            x.name ==
                                                                            singleProOption.name)] = SelectedOption(
                                                                          name:
                                                                              singleProOption.name,
                                                                          value: singleProOption
                                                                              .optionValues[index]
                                                                              .name,
                                                                        );

                                                                        optionsRead2
                                                                            .selectOption(temp);
                                                                      },
                                                                      child:
                                                                          SelectableTextBox(
                                                                        text: singleProOption
                                                                            .optionValues[index]
                                                                            .name,
                                                                        isSelected: singleProOption.optionValues[index].name ==
                                                                                optionsWatch2.selectedOptions.firstWhere((e) => e.name == singleProOption.name).value
                                                                            ? true
                                                                            : false,
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                  case 'Size':
                                                    return !selectedVariant2
                                                            .node
                                                            .selectedOptions
                                                            .any((e) =>
                                                                e.name ==
                                                                singleProOption
                                                                    .name)
                                                        ? SizedBox()
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            20),
                                                                child: AppButtons
                                                                    .myprimaryButton(
                                                                  onPressed:
                                                                      () {},
                                                                  height: 30.h,
                                                                  text:
                                                                      "What’s My size",
                                                                  color: AppColors
                                                                      .greyF2,
                                                                  textColor:
                                                                      AppColors
                                                                          .black1C,
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "SIZE",
                                                                    style: AppTextStyles
                                                                        .headline3
                                                                        .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "Size Chart",
                                                                    style: AppTextStyles
                                                                        .lable2
                                                                        .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .underline,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 29,
                                                                child: ListView
                                                                    .builder(
                                                                  itemCount:
                                                                      singleProOption
                                                                          .optionValues
                                                                          .length,
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        var temp =
                                                                            optionsWatch2.selectedOptions;
                                                                        temp[temp.indexWhere((x) =>
                                                                            x.name ==
                                                                            singleProOption.name)] = SelectedOption(
                                                                          name:
                                                                              singleProOption.name,
                                                                          value: singleProOption
                                                                              .optionValues[index]
                                                                              .name,
                                                                        );

                                                                        optionsRead2
                                                                            .selectOption(temp);
                                                                      },
                                                                      child:
                                                                          SelectableTextBox(
                                                                        text: singleProOption
                                                                            .optionValues[index]
                                                                            .name,
                                                                        isSelected: singleProOption.optionValues[index].name ==
                                                                                optionsWatch2.selectedOptions.firstWhere((e) => e.name == singleProOption.name).value
                                                                            ? true
                                                                            : false,
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                  default:
                                                    return SizedBox();
                                                }
                                              },
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      AppButtons.myprimaryButton(
                        onPressed: () {},
                        text: "ADD TO BAG",
                      ),
                      Divider(),
                      Text("Customize your scrub sets",
                          style: AppTextStyles.headline3),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20.w, right: 20.w, bottom: 30.w),
                        child: Text(
                          "Shopping for uniforms doesn’t have to be uniform. Our advanced custom Scrub Set Builder allows you to pair your favorite styles, fits and colors, including black, green and blue, to customize your perfect scrub set. Just scroll, pair and click. It’s that simple.",
                          style: AppTextStyles.lable2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
