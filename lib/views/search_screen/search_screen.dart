import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_doctor/graph_ql/query/mutation_query.dart';
import 'package:golden_doctor/models/products/product_model.dart';
import 'package:golden_doctor/resources/widgets/product_widget/product_widget.dart';
import 'package:golden_doctor/utils/app_colors.dart';
import 'package:golden_doctor/utils/app_fonts.dart';
import 'package:golden_doctor/utils/app_images.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SearchProducts extends StatefulWidget {
  const SearchProducts({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchProductsState createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  final formkey = GlobalKey<FormState>();
  String? searchitem;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          AppImages.horizantelLogo,
          height: 32,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        child: Column(
          children: [
            SizedBox(
              height: 36.h,
              child: TextFormField(
                controller: TextEditingController(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                // enableInteractiveSelection: true,
                showCursor: true,

                // cursorHeight: 6,
                onFieldSubmitted: (value) {
                  print('validate');
                  setState(() {
                    searchitem = value;
                  });
                },
                decoration: InputDecoration(
                  // contentPadding:
                  //     EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.greyDE,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(color: AppColors.grey)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(color: AppColors.myPrimary)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: const BorderSide(color: AppColors.myPrimary)),
                  hintText: 'Search for products',
                  hintStyle: TextStyle(
                    color: AppColors.greyDE,
                    fontSize: 13.sp,
                  ),
                  // floatingLabelStyle: TextStyle(
                  //     color: AppColors.myPrimary, fontSize: 13.sp),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: searchitem != null
                      ? Query(
                          options: QueryOptions(
                              document: gql(
                                finalsearchProducts,
                              ),
                              variables: {
                                'Search': "title:$searchitem OR tag:$searchitem*"
                              }),
                          builder: (QueryResult? result,
                              {VoidCallback? refetch, FetchMore? fetchMore}) {
                            if (result!.hasException) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppImages.searchImages,
                                      height: 40.h,
                                      width: 40.w,
                                    ),
                                    Text(
                                      "Bad Connection",
                                      style: AppTextStyles.headline1
                                          .copyWith(color: AppColors.myPrimary),
                                    ),
                                  ],
                                ),
                              );
                            }
              
                            if (result.isLoading) {
                              return const Center(
                                child: Text('Loading'),
                              );
                            }
              
                            if (result.data != null) {
                              dynamic resData =
                                  jsonEncode(result.data!['products']['edges']);
                              List responseList = jsonDecode(resData);
              
                              List<ProductEdge> productsEdges =
                                  List<ProductEdge>.from(responseList
                                      .map((x) => ProductEdge.fromJson(x)));
              
                              return productsEdges == []
                                  ? const SizedBox()
                                  : GridView.builder(
                                    itemCount: productsEdges.length,
                                    scrollDirection: Axis.vertical,
                                    // shrinkWrap: true,
                                    // physics:
                                    //     const NeverScrollableScrollPhysics(),
                                    // gridDelegate:
                                    //     const SliverGridDelegateWithFixedCrossAxisCount(
                                    //   crossAxisCount: 2,
                                    //   childAspectRatio: 3 / 6,
                                    //   crossAxisSpacing: 0,
                                    //   mainAxisSpacing: 0,
                                    // ),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 332.h,
                                      crossAxisSpacing: 10.w,
                                      mainAxisSpacing: 10.h,
                                    ),
                                    itemBuilder: (context, index) {
                                      ProductNode singleProduct =
                                          productsEdges[index].node;
                                      return ProductWidget(
                                        singleProduct: singleProduct,
                                      );
                                    },
                                  );
                            } else {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(AppImages.searchImages),
                                    Text(
                                      "Empty",
                                      style: AppTextStyles.headline1
                                          .copyWith(color: AppColors.myPrimary),
                                    ),
                                  ],
                                ),
                              );
                            }
                          })
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage(
                                  AppImages.searchImages,
                                ),
                              )
                            ],
                          ),
                        )),
            ),
          ],
        ),
      ),
    );
  }
}
