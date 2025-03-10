import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:golden_doctor/graph_ql/config.dart';
import 'package:golden_doctor/graph_ql/query/mutation_query.dart';
import 'package:golden_doctor/models/products/product_model.dart';
import 'package:golden_doctor/resources/widgets/product_widget/product_widget.dart';
import 'package:golden_doctor/utils/app_colors.dart';
import 'package:golden_doctor/utils/app_constant.dart';
import 'package:golden_doctor/utils/app_fonts.dart';
import 'package:golden_doctor/utils/app_images.dart';
import 'package:golden_doctor/view_models/collection_product_view_model/collection_product_view_model.dart';
import 'package:golden_doctor/view_models/collection_product_view_model/collection_view_model.dart';
import 'package:golden_doctor/view_models/language_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CollectionProductsScreen extends ConsumerStatefulWidget {
  const CollectionProductsScreen({
    super.key,
    required this.collectionId,
    required this.collectionName,
  });

  final String collectionId;
  final String collectionName;

  @override
  ConsumerState<CollectionProductsScreen> createState() =>
      _CollectionProductsScreenState();
}

class _CollectionProductsScreenState
    extends ConsumerState<CollectionProductsScreen> {
  @override
  void initState() {
    // print("iniit");
    Future.delayed(
        Duration(seconds: 0),
        () => {
              ref.watch(collectionsProductsProvider).getData(
                  collectionId: widget.collectionId, type: "Initial Fetch")
            });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // print("did change dependency");
    super.didChangeDependencies();
  }

  final ScrollController scrollController = ScrollController();
  List<ProductEdge> allProducts = [];
  double _lastOffset = 0.0;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    // print("build");
    allProducts = ref.watch(collectionsProductsProvider).productList;

    // --------------------------------------------------------

    WidgetsBinding.instance.addPostFrameCallback((vale) {
      Future.delayed(Duration(seconds: 2), () {
        scrollController.addListener(() async {
          // print("listning");
          if (scrollController.offset ==
                  scrollController.position.maxScrollExtent &&
              scrollController.offset != _lastOffset) {
            // if (collectionProducts!.collection.products.pageInfo.hasNextPage) {
            // print("fetcing more");
            // _endCursor =
            //     collectionProducts.collection.products.pageInfo.endCursor;
            _lastOffset = scrollController.offset;
            ref.watch(collectionsProductsProvider).getData(
                  collectionId: widget.collectionId,
                  type: "Fetch More",
                );
            // }
          }
        });
      });
    });

// -----------------------------------------------------------
    return Directionality(
      textDirection: AppConstant.selectedLanguage == 'EN'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(AppImages.horizantelLogo, height: 32),
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: () {
                ref.read(filterProviderLocal.notifier).state =
                    ref.watch(filterProvider);
                context.push("/filterScreen");
              },
              label: Text(
                "Filter".tr,
                style: AppTextStyles.body2.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              icon: Icon(Icons.tune),
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, _) =>
                    ref.watch(collectionsProductsProvider).isLoading
                        // ? Center(child: Text("Loading"))
                        ? Center(child: CircularProgressIndicator())
                        : allProducts.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.folder_off_outlined),
                                    // Image.asset(AppImages.noData),
                                    Text(
                                      "Empty",
                                      style: AppTextStyles.headline1
                                          .copyWith(color: AppColors.myPrimary),
                                    ),
                                  ],
                                ),
                              )
                            : GridView.builder(
                                itemCount: allProducts.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  // childAspectRatio: 6/9,
                                  mainAxisExtent: 332.h,
                                  // childAspectRatio: 9 / 18, //170 / 350,
                                  crossAxisSpacing: 10.w,
                                  mainAxisSpacing: 10.h,
                                  // mainAxisExtent: 290,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                itemBuilder: (context, index) {
                                  ProductNode singlePro =
                                      allProducts[index].node;
log(singlePro.title.toString());
                                  return ProductWidget(
                                    singleProduct: singlePro,
                                  );
                                },
                              ),
                // : GridView.builder(
                //     controller: scrollController,
                //     itemCount: ref
                //         .watch(collectionsProductsProvider)
                //         .productList
                //         .length,
                //     gridDelegate:
                //         SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 2, // Number of columns
                //       crossAxisSpacing: 0.0, // No spacing between columns
                //       mainAxisSpacing: 0.0, // No spacing between rows
                //       childAspectRatio:
                //           (180 / 350), // Aspect ratio for each grid item
                //     ),
                //     itemBuilder: (context, i) {
                //       print("All Products ${allProducts.length}");
                //       return ProductWidget();
                //       //  ProductCard(
                //       //   // horizontal: i % 3 == 0 ? 0 : appPaddingNormal,
                //       //   purpleNode: allProducts[i].node,
                //       // );
                //     },
                //   ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> fetchMoreProductFn(FetchMore fetchMore) async {
  Future<QueryResult> getData({var cursor}) async {
    GraphQlHelper graphQlHelper = GraphQlHelper();
    QueryResult result = await graphQlHelper.client.value.query(
      QueryOptions(
        document: gql(fetchProductwithCollectionIdfn(widget.collectionId,
            cursor: cursor)),
        variables: {'numProducts': 25, 'cursor': cursor},
      ),
    );
    return result;
  }
  
}
