import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:golden_doctor/utils/app_colors.dart';
import 'package:golden_doctor/utils/app_constant.dart';
import 'package:golden_doctor/utils/app_fonts.dart';
import 'package:golden_doctor/view_models/language_provider.dart';
import 'package:golden_doctor/view_models/navigation_view_model/navigation_view_model.dart';

import '../../models/navigation_model/navigation_model.dart';

class NavigationScreen extends ConsumerWidget {
  const NavigationScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(navigationprovider);
    return Directionality(
      textDirection: AppConstant.selectedLanguage == 'EN'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body:
            // navigationState.when(
            //   data: (sectionsModel) {
            //     if (sectionsModel == null || sectionsModel.navigation!.isEmpty) {
            //       return Center(
            //           child: Text(
            //         "No sections available",
            //         style: AppTextStyles.headline1,
            //       ));
            //     }
            //     return ListView.builder(
            //       itemCount: sectionsModel.navigation!.length,
            //       itemBuilder: (context, index) {
            //         final section = sectionsModel.navigation![index];
            //         return Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Text(
            //                 section.label.toString().tr == ''
            //                     ? 'NA'
            //                     : section.label.toString().tr,
            //                 style: AppTextStyles.headline1,
            //               ),
            //             ),
            //             // _buildSectionBody(section),
            //           ],
            //         );
            //       },
            //     );
            //   },
            //   loading: () => const Center(child: CircularProgressIndicator()),
            //   error: (error, stack) => Center(
            //       child: Text(
            //     "Error: $error",
            //     style: AppTextStyles.headline1,
            //   )),
            // ),

            navigationState.when(
                data: (event) {
                  List<Navigation> data = event!.navigation!;

                  //  jsonDecode(
                  //     jsonEncode(event.snapshot.value))['collections'];

                  // List<CollectionModel> collectionsMainModel =
                  //     data.map((e) => CollectionModel.fromJson(e)).toList();
                  if (data == []) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.folder_off),
                          // Image.asset(AppImages.noData),
                          Text(
                            "Empty",
                            style: AppTextStyles.headline1
                                .copyWith(color: AppColors.myPrimary),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return DefaultTabController(
                      length: data.length,
                      child: Column(
                        children: [
                          TabBar(
                            tabAlignment: TabAlignment.start,
                            isScrollable: true,
                            unselectedLabelColor: AppColors.black28,
                            labelColor: AppColors.black28,
                            indicatorColor: AppColors.myPrimary,
                            enableFeedback: false,
                            dividerColor: AppColors.greyCA,
                            dividerHeight: 2,
                            labelStyle: AppTextStyles.headline2,
                            unselectedLabelStyle: AppTextStyles.headline3,
                            tabs: data
                                .map(
                                  (tab) => Tab(
                                    text: tab.label.toString().tr == ''
                                        ? "NA"
                                        : tab.label.toString().tr,
                                  ),
                                )
                                .toList(),
                            onTap: (index) {},
                            padding: EdgeInsets.all(0),
                          ),
                          // Divider(color: AppColors.grey9c,),
                          // SizedBox(height: 10),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              child: TabBarView(
                                children: data.map((e) {
                                  List<int?> isExpanded = List.generate(
                                      data.length, (index) => null);
                                  if (e.children != null && e.children != []) {
                                    return ListView.builder(
                                      itemCount: e.children!.length,
                                      itemBuilder: (context, index) {
                                        if (e.children![index].children !=
                                                null &&
                                            e.children![index].children != []) {
                                          if (isExpanded[data.indexOf(e)] ==
                                              null) {
                                            isExpanded[data.indexOf(e)] = index;
                                          }
                                          return ExpansionTile(
                                              shape: Border(
                                                  // bottom: BorderSide(
                                                  //   // color: AppColors.redFB71,
                                                  // ),
                                                  ),
                                              collapsedShape: Border(
                                                  // br
                                                  ),
                                              expandedCrossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              dense: true,
                                              expandedAlignment:
                                                  Alignment.centerLeft,
                                              iconColor: Colors.transparent,
                                              collapsedIconColor:
                                                  Colors.transparent,
                                              initiallyExpanded: true,
                                              onExpansionChanged: (value) {
                                                // Prevent collapsing by keeping `isExpanded` true
                                                // setState(() {
                                                //   isExpanded = true;
                                                // });
                                              },
                                              // isExpanded[data.indexOf(e)] ==
                                              //         index
                                              //     ? true
                                              //     : false,
                                              // index == 0 ? true : false,
                                              tilePadding: EdgeInsets.zero,
                                              childrenPadding: EdgeInsets.zero,
                                              title: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: EdgeInsets.only(
                                                    top: 28.h,
                                                    //  bottom: 9.h,
                                                    left: 27.w),
                                                decoration: BoxDecoration(
                                                    // color: AppColors.black1C,
                                                    // border: Border(
                                                    //   bottom: BorderSide(
                                                    //     color: AppColors.myPrimary,
                                                    //   ),
                                                    // ),
                                                    ),
                                                child: Text(
                                                  e.children![index].label
                                                              .toString()
                                                              .tr ==
                                                          ''
                                                      ? 'NA'
                                                      : e.children![index]
                                                              .label ??
                                                          "N/A",
                                                  style: AppTextStyles.body1
                                                      .copyWith(
                                                    color: AppColors.black28,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              children: [
                                                Divider(),
                                                ...e.children![index].children!
                                                    .map(
                                                  (e) {
                                                    return InkWell(
                                                      onTap: () {
                                                        if (e.type ==
                                                            'collections') {
                                                          log('collections========');
                                                          context.push(
                                                            "/collection_product_screen",
                                                            extra: {
                                                              "collectionID":
                                                                  e.objId,
                                                              "collectionName":
                                                                  e.objName,
                                                            },
                                                          );
                                                        } else if (e.type ==
                                                            'product') {
                                                          log('product========');
                                                        } else if (e.type ==
                                                            'brands') {
                                                          log('brands========');
                                                          context.push(
                                                            "/collection_product_screen",
                                                            extra: {
                                                              "collectionID":
                                                                  e.objId,
                                                              "collectionName":
                                                                  e.objName,
                                                            },
                                                          );
                                                        } else {
                                                          log('product========');
                                                        }
                                                      },
                                                      child:

                                                          /////////////////////////////////////////////////////////////
                                                          e.children != null &&
                                                                  e.children!
                                                                      .isNotEmpty
                                                              ?
                                                              /////////////////
                                                              // Text(
                                                              //     'child length = ${e.children!.length}')

                                                              ExpansionTile(
                                                                  shape: Border(
                                                                      // bottom: BorderSide(
                                                                      //   // color: AppColors.redFB71,
                                                                      // ),
                                                                      ),
                                                                  collapsedShape:
                                                                      Border(
                                                                          // br
                                                                          ),
                                                                  expandedCrossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  dense: true,
                                                                  expandedAlignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  iconColor: Colors
                                                                      .transparent,
                                                                  collapsedIconColor:
                                                                      Colors
                                                                          .transparent,
                                                                  initiallyExpanded:
                                                                      true,
                                                                  onExpansionChanged:
                                                                      (value) {
                                                                    // Prevent collapsing by keeping `isExpanded` true
                                                                    // setState(() {
                                                                    //   isExpanded = true;
                                                                    // });
                                                                  },
                                                                  // isExpanded[data.indexOf(e)] ==
                                                                  //         index
                                                                  //     ? true
                                                                  //     : false,
                                                                  // index == 0 ? true : false,
                                                                  tilePadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  childrenPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  title:
                                                                      Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    padding: EdgeInsets.only(
                                                                        top: 28.h,
                                                                        //  bottom: 9.h,
                                                                        left: 27.w),
                                                                    decoration: BoxDecoration(
                                                                        // color: AppColors.black1C,
                                                                        // border: Border(
                                                                        //   bottom: BorderSide(
                                                                        //     color: AppColors.myPrimary,
                                                                        //   ),
                                                                        // ),
                                                                        ),
                                                                    child: Text(
                                                                      e.label.toString().tr ==
                                                                              ''
                                                                          ? 'NA'
                                                                          : e.label ??
                                                                              "N/A",
                                                                      style: AppTextStyles
                                                                          .body1
                                                                          .copyWith(
                                                                        color: AppColors
                                                                            .black28,
                                                                        fontSize:
                                                                            14.sp,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  children: [
                                                                    Divider(),
                                                                    ...e.children!
                                                                        .map(
                                                                      (e) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            if (e.type ==
                                                                                'collections') {
                                                                              log('collections========');
                                                                              context.push(
                                                                                "/collection_product_screen",
                                                                                extra: {
                                                                                  "collectionID": e.objId,
                                                                                  "collectionName": e.objName,
                                                                                },
                                                                              );
                                                                            } else if (e.type ==
                                                                                'product') {
                                                                              log('product========');
                                                                            } else if (e.type ==
                                                                                'brands') {
                                                                              log('brands========');
                                                                              context.push(
                                                                                "/collection_product_screen",
                                                                                extra: {
                                                                                  "collectionID": e.objId,
                                                                                  "collectionName": e.objName,
                                                                                },
                                                                              );
                                                                            } else {
                                                                              log('product========');
                                                                            }
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 27.w, top: 13.h),
                                                                            child:
                                                                                Text(
                                                                              e.label.toString().tr == '' ? "NA" : e.label.toString().tr,
                                                                              //  ?? "N?A",
                                                                              style: AppTextStyles.lable1.copyWith(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 14.sp,
                                                                                color: AppColors.black28,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                )

                                                              ///////////

                                                              : Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left:
                                                                          27.w,
                                                                      top:
                                                                          13.h),
                                                                  child: Text(
                                                                    e.label.toString().tr ==
                                                                            ''
                                                                        ? "NA"
                                                                        : e.label
                                                                            .toString()
                                                                            .tr,
                                                                    //  ?? "N?A",
                                                                    style: AppTextStyles
                                                                        .lable1
                                                                        .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          14.sp,
                                                                      color: AppColors
                                                                          .black28,
                                                                    ),
                                                                  ),
                                                                ),
                                                    );

                                                    //  [
                                                    //     Divider(),
                                                    //     ...e.children![index]
                                                    //         .children!
                                                    //         .map(
                                                    //       (e) {
                                                    //         return InkWell(
                                                    //           onTap: () {

                                                    //             // if (e.type == 'collections') {
                                                    //             //   log('collections========');
                                                    //             //   context.push(
                                                    //             //     "/collection_product_screen",
                                                    //             //     extra: {
                                                    //             //       "collectionID": e.objId,
                                                    //             //       "collectionName": e.objName,
                                                    //             //     },
                                                    //             //   );
                                                    //             // } else if (e.type == 'product') {
                                                    //             //   log('product========');
                                                    //             // } else if (e.type == 'brands') {
                                                    //             //   log('brands========');
                                                    //             //   context.push(
                                                    //             //     "/collection_product_screen",
                                                    //             //     extra: {
                                                    //             //       "collectionID": e.objId,
                                                    //             //       "collectionName": e.objName,
                                                    //             //     },
                                                    //             //   );
                                                    //             // } else {
                                                    //             //   log('product========');
                                                    //             // }
                                                    //           },
                                                    //           child: Padding(
                                                    //             padding: EdgeInsets.only(left: 27.w, top: 13.h),
                                                    //             child: Text(
                                                    //               e.label.toString().tr == '' ? "NA" : e.label.toString().tr,
                                                    //               //  ?? "N?A",
                                                    //               style: AppTextStyles.lable1.copyWith(
                                                    //                 fontWeight: FontWeight.w600,
                                                    //                 fontSize: 14.sp,
                                                    //                 color: AppColors.black28,
                                                    //               ),
                                                    //             ),
                                                    //           ),
                                                    //         );
                                                    //       },
                                                    //     ),
                                                    //   ]));
                                                  },
                                                ),
                                              ]);
                                        } else {
                                          return InkWell(
                                            onTap: () {
                                              // context.push(
                                              //   "/collection_product_screen",
                                              //   extra: {
                                              //     "collectionID": e
                                              //         .subCollections![index]
                                              //         .graphqlId,
                                              //     "collectionName": e.title,
                                              //   },
                                              // );
                                            },
                                            child: Container(
                                              // padding: EdgeInsets.all(5),
                                              color: index == 0
                                                  ? AppColors.buttonColor
                                                  : Colors.transparent,
                                              child: Text(
                                                e.children![index].label ??
                                                    "N/A",
                                                style: AppTextStyles.lable1,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  } else {
                                    return Text(
                                      "Collection is Empty",
                                      style: AppTextStyles.body3,
                                    );
                                  }
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                error: (error, stackTrace) {
                  log('Error: $error');
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image.asset(AppImages.noInternet),
                        Icon(Icons.signal_wifi_connected_no_internet_4_rounded),
                        Text(
                          "Bad Connection",
                          style: AppTextStyles.headline1
                              .copyWith(color: AppColors.myPrimary),
                        ),
                      ],
                    ),
                  );
                }),
      ),
    );
  }
}
