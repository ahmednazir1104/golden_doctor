import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:golden_doctor/models/cart/cart_model.dart';
import 'package:golden_doctor/models/product_quantity_model.dart/product_quantity_model.dart';
import 'package:golden_doctor/models/products/product_model.dart';
import 'package:golden_doctor/resources/widgets/product_widget/color_palette_widget.dart';
import 'package:golden_doctor/resources/widgets/product_widget/pdp_product_carousel.dart';
import 'package:golden_doctor/resources/widgets/universal_widget/app_button.dart';
import 'package:golden_doctor/resources/widgets/universal_widget/selectable_textbox.dart';
import 'package:golden_doctor/utils/app_colors.dart';
import 'package:golden_doctor/utils/app_constant.dart';
import 'package:golden_doctor/utils/app_fonts.dart';
import 'package:golden_doctor/utils/app_images.dart';
import 'package:golden_doctor/view_models/cart_view_model.dart';
import 'package:golden_doctor/view_models/language_provider.dart';
import 'package:golden_doctor/view_models/product_details_view_model.dart';

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
final imglist = [
  "https://scrubser-shop.com/wp-content/uploads/2024/02/CK131A_A.jpg",
  "https://scrubser-shop.com/wp-content/uploads/2024/02/CK131A_A.jpg",
  "https://scrubser-shop.com/wp-content/uploads/2024/02/CK131A_A.jpg",
];

final carouselIndex = StateProvider<int>((ref) {
  return 0;
});

class ProductDetailScreen extends ConsumerStatefulWidget {
  final ProductNode singleProduct;
  const ProductDetailScreen({
    super.key,
    required this.singleProduct,
  });

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  late final Future<List<ProductEdge>?> popularProducts;
  late final Future<List<ProductEdge>?> recomandedProducts;
  late InAppWebViewController webViewController;
  final uniquePageKey = DateTime.now().toUtc().toString();
  @override
  void initState() {
    ref
        .read(productDetailsProvider(uniquePageKey).notifier)
        .productQuentity(context, widget.singleProduct.id);

    Future.delayed(Duration(seconds: 0)).then((value) {
      ref.read(productDetailsProvider(uniquePageKey).notifier).selectOption(
            widget.singleProduct.variants.edges[0].node.selectedOptions,
          );
      recomandedProducts = ref
          .read(productDetailsProvider(uniquePageKey).notifier)
          .fetchProducts(
            collectionId: widget.singleProduct.productRecomandationMetafield,
          );
      popularProducts = ref
          .read(productDetailsProvider(uniquePageKey).notifier)
          .fetchProducts(
            collectionId: widget.singleProduct.youMayAlsoLikeMetafield,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentImgIndex = ref.watch(carouselIndex);
    final cartRead = ref.read(cartProvider.notifier);
    final List<CartModel> cartList = ref.watch(cartProvider);

    final optionsWatch = ref.watch(productDetailsProvider(uniquePageKey));
    final optionsRead =
        ref.read(productDetailsProvider(uniquePageKey).notifier);
    VariantsEdge selectedVariant =
        optionsRead.selectVariant(purpleNode: widget.singleProduct);
    ProductQuantityModel? productQuantityModel;
    List<ImagesEdge> imageEdges;
    // ------ create image list if specific color variant------
    imageEdges = widget.singleProduct.images.edges;
    if (optionsWatch.selectedOptions.isNotEmpty) {
      imageEdges = [
        ...widget.singleProduct.images.edges.where(
            (e) => e.node.altText == optionsWatch.selectedOptions[0].value),
        // e.node.altText == selectedVariant.node.selectedOptions[0].value),
      ];
    }
    if (imageEdges.isEmpty) {
      imageEdges = widget.singleProduct.images.edges;
    }
    final Options? sizeOption = widget.singleProduct.options
        .firstWhereOrNull((element) => element.name == "Size");
    final Options? fitOption = widget.singleProduct.options
        .firstWhereOrNull((element) => element.name == "Length");
    final Options? colorOption = widget.singleProduct.options
        .firstWhereOrNull((element) => element.name == "Color");

    // print("selected varient");
    // print(json.encode(selectedVariant.node.selectedOptions));
    return Directionality(
      textDirection: AppConstant.selectedLanguage == 'EN'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        body: optionsWatch.selectedOptions.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : CustomScrollView(
                slivers: <Widget>[
                  // -------- image carousel. -----------
                  SliverAppBar(
                    toolbarHeight: 33,
                    expandedHeight: 409.h,
                    pinned: true,
                    backgroundColor: AppColors.myScaffold,
                    elevation: 0,
                    forceElevated: false,
                    surfaceTintColor: AppColors.myScaffold,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      titlePadding: EdgeInsets.zero,
                      collapseMode: CollapseMode.pin,
                      background: Stack(
                        children: [
                          Positioned.fill(
                            child: CarouselSlider.builder(
                              itemCount: imageEdges.length, //imglist.length,
                              itemBuilder: (contaxt, index, _) {
                                return CachedNetworkImage(
                                  imageUrl: imageEdges[index].node.url,
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
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                );
                              },
                              options: CarouselOptions(
                                aspectRatio: 3 / 6,
                                viewportFraction: 1,
                                enableInfiniteScroll: true,
                                onPageChanged: (index, reason) => ref
                                    .read(carouselIndex.notifier)
                                    .state = index,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 60.h,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: imglist.asMap().entries.map((entry) {
                                return Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: entry.key == currentImgIndex
                                        ? AppColors.blue575
                                        : AppColors.myScaffold,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
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
                        ],
                      ),
                    ),
                    // bottom: PreferredSize(
                    //   preferredSize: Size(double.infinity, 30.h),
                    //   child:
                    // ),
                  ),

                  // -------- product details. --------
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: <Widget>[
                          Text(
                            widget.singleProduct.title,
                            style: AppTextStyles.headline2.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            widget.singleProduct.vendor ?? "",
                            style: AppTextStyles.lable3.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          // ------- Color Options -------
                          if (colorOption != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "COLOR    ".tr,
                                      style: AppTextStyles.headline3.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      optionsWatch.selectedOptions[0].value,
                                      // selectedVariant.node.selectedOptions[0].value,
                                      style: AppTextStyles.lable3,
                                    ),
                                  ],
                                ),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.start,
                                  children: [
                                    ...colorOption.optionValues.map(
                                      (e) => ColorPalateWidget(
                                        optionKey: colorOption.name,
                                        optionValue: e.name,
                                        uniquePageKey: uniquePageKey,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                              ],
                            )
                          else
                            SizedBox(),

                          // ------- Size Type -------
                          if (fitOption != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${'Length'.tr}    ",
                                      style: AppTextStyles.headline3.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                        optionsWatch.selectedOptions
                                            .firstWhere(
                                                (e) => e.name == "Length")
                                            .value,
                                        style: AppTextStyles.lable3),
                                  ],
                                ),
                                SizedBox(
                                  height: 29,
                                  child: ListView.builder(
                                    itemCount: fitOption.optionValues.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          var temp =
                                              optionsWatch.selectedOptions;
                                          temp[temp.indexWhere((x) =>
                                                  x.name == fitOption.name)] =
                                              SelectedOption(
                                            name: fitOption.name,
                                            value: fitOption
                                                .optionValues[index].name,
                                          );

                                          optionsRead.selectOption(temp);
                                        },
                                        child: SelectableTextBox(
                                          text: fitOption
                                              .optionValues[index].name,
                                          isSelected: fitOption
                                                      .optionValues[index]
                                                      .name ==
                                                  optionsWatch.selectedOptions
                                                      .firstWhere((x) =>
                                                          x.name ==
                                                          fitOption.name)
                                                      .value
                                              ? true
                                              : false,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 10.h),
                              ],
                            )
                          else
                            SizedBox(),
                          // ------- Size -------
                          if (sizeOption != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "SIZE".tr,
                                      style: AppTextStyles.headline3.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                // title: Text("Size Chart"),
                                                content: SizedBox(
                                                  height: 400.h,
                                                  child: InAppWebView(
                                                    initialUrlRequest:
                                                        URLRequest(
                                                      url: WebUri(
                                                          // parameter required
                                                          // Custumer Id
                                                          // retailerid
                                                          // product Handle Id
                                                          'https://www.primeai2.org/CUSTOMERS/scrubsershop/mobilewidget/size_recommendation_native.php?retailerid=scrubsershop&customerid=7853285146857&productid=womens-zip-front-warm-up-solid-scrub&lang=${AppConstant.selectedLanguage}'),
                                                      // 'https://www.primeai2.org/aop/aop_get_cidfromret.php?par0=c2NydWJzZXJzaG9w&par1=Nzg1MzI4NTE0Njg1Nw=='),
                                                      // 'https://www.primeai2.org/CUSTOMERS/scrubsershop/mobilewidget/pai_retailer_min.js'),
                                                      // 'https://www.primeai2.org/CUSTOMERS/scrubsershop/mobilewidget/pai_retailer_min.js'),
                                                      // ' https://www.primeai2.org/CUSTOMERS/scrubsershop/mobilewidget/002-use-widget.js',)
                                                      // 'https://www.primeai2.org/CUSTOMERS/scrubsershop/mobilewidget/size_recommendation_native.php?retailerid=scrubsershop&customerid=7853285146857&productid=8810259284201'),
                                                    ),
                                                    onWebViewCreated:
                                                        (controller) {
                                                      webViewController =
                                                          controller;
                                                    },
                                                    onLoadStart:
                                                        (controller, url) {
                                                      if (kDebugMode) {
                                                        print(
                                                            "Started loading: $url");
                                                      }
                                                    },
                                                    onLoadStop: (controller,
                                                        url) async {
                                                      if (kDebugMode) {
                                                        print(
                                                            "Finished loading: $url");
                                                      }
                                                    },
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: Text(
                                        "What's my size?".tr,
                                        style: AppTextStyles.lable3.copyWith(
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Wrap(
                                  children: [
                                    ...sizeOption.optionValues.map(
                                      (e) => GestureDetector(
                                        onTap: () {
                                          var temp =
                                              optionsWatch.selectedOptions;
                                          temp[temp.indexWhere((x) =>
                                                  x.name == sizeOption.name)] =
                                              SelectedOption(
                                            name: sizeOption.name,
                                            value: e.name,
                                          );
                                          optionsRead.selectOption(temp);
                                        },
                                        child: SelectableTextBox(
                                          text: e.name,
                                          isSelected: e.name ==
                                                  optionsWatch.selectedOptions
                                                      .firstWhere((x) =>
                                                          x.name ==
                                                          sizeOption.name)
                                                      .value
                                              ? true
                                              : false,
                                          maxWidth: 50.w,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          else
                            SizedBox(),

                          // SizedBox(height: 10.h),
                          Divider(color: AppColors.greyDE),
                          // ------- Price & Add To Cart-------
                          Row(
                            children: [
                              Text(
                                "${"SAR".tr} ${selectedVariant.node.price.amount}",
                                style: AppTextStyles.headline3,
                              ),
                              SizedBox(width: 20),
                              Flexible(
                                child: AppButtons.myprimaryButton(
                                  onPressed: () {
                                    int variantIndex = widget
                                        .singleProduct.variants.edges
                                        .indexOf(selectedVariant);
                                    if (kDebugMode) {
                                      print("Variant index = $variantIndex");
                                      print(
                                          "Variant  = ${selectedVariant.node.title}");
                                    }
                                    productQuantityModel = ref
                                        .read(productDetailsProvider(
                                                uniquePageKey)
                                            .notifier)
                                        .productQuantityModel;
                                    // print(productQuantityModel!.variants!.edges!.length);
                                    // print(jsonEncode(productQuantityModel));
                                    // check If item is already in cart or not

                                    if (cartList.any((element) {
                                          if (element.varientId ==
                                              selectedVariant.node.id) {
                                            return true;
                                          } else {
                                            return false;
                                          }
                                        }) ==
                                        false) {
                                      if (kDebugMode) {
                                        print("new item");
                                      }
                                      if (productQuantityModel!
                                              .variants!
                                              .edges![variantIndex]
                                              .node!
                                              .quantityAvailable! >
                                          0) {
                                        cartRead.addCart(
                                          CartModel(
                                            isEmbroidery: false,
                                            vendor: widget.singleProduct.vendor,
                                            available: true,
                                            // productGraphID:
                                            //     widget.singleProduct.gid,
                                            productId: widget.singleProduct.id,
                                            varientId: selectedVariant.node.id,
                                            productPrice: selectedVariant
                                                .node.price.amount,
                                            productName:
                                                "${widget.singleProduct.title}\n${selectedVariant.node.title}",
                                            productImage:
                                                selectedVariant.node.image!.url,
                                            quantity: "1",
                                            comparePrice: selectedVariant
                                                .node.compareAtPrice?.amount,
                                            sku: selectedVariant.node.sku,
                                          ),
                                        );
                                        if (optionsWatch.embroideryOptions !=
                                            null) {
                                          cartRead.addCart(
                                              optionsWatch.embroideryOptions!);
                                        }
                                        Fluttertoast.showToast(
                                            msg: "Added In Cart");
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: "Out Of Stock",
                                        );
                                      }
                                    } else {
                                      if (kDebugMode) {
                                        print("old item");
                                      }
                                      // find index of item in cart
                                      int itemIndexInCart = cartList.indexWhere(
                                        (element) =>
                                            element.varientId ==
                                            selectedVariant.node.id,
                                      );
                                      // update quantity of item in cart
                                      // CartModel tempCartModel = new CartModel();
                                      // tempCartModel = cartList[itemIndexInCart];
                                      // tempCartModel.quantity =
                                      //     (int.parse(tempCartModel.quantity!) +
                                      //             1)
                                      //         .toString();
                                      if ((int.parse(cartList[itemIndexInCart]
                                                  .quantity!) +
                                              1) <=
                                          productQuantityModel!
                                              .variants!
                                              .edges![variantIndex]
                                              .node!
                                              .quantityAvailable!) {
                                        cartRead.updateCart(
                                          CartModel(
                                            available: cartList[itemIndexInCart]
                                                .available,
                                            comparePrice:
                                                cartList[itemIndexInCart]
                                                    .comparePrice,
                                            productImage:
                                                cartList[itemIndexInCart]
                                                    .productImage,
                                            productId: cartList[itemIndexInCart]
                                                .productId,
                                            productName:
                                                cartList[itemIndexInCart]
                                                    .productName,
                                            productPrice:
                                                cartList[itemIndexInCart]
                                                    .productPrice,
                                            quantity: (int.parse(cartList[
                                                            itemIndexInCart]
                                                        .quantity!) +
                                                    1)
                                                .toString(),
                                            sku: cartList[itemIndexInCart].sku,
                                            varientId: cartList[itemIndexInCart]
                                                .varientId,
                                            vendor: cartList[itemIndexInCart]
                                                .vendor,
                                            embroideryOptions:
                                                cartList[itemIndexInCart]
                                                    .embroideryOptions,
                                            isEmbroidery:
                                                cartList[itemIndexInCart]
                                                    .isEmbroidery,
                                            productColor:
                                                cartList[itemIndexInCart]
                                                    .productColor,
                                            productSize:
                                                cartList[itemIndexInCart]
                                                    .productSize,
                                            userId: cartList[itemIndexInCart]
                                                .userId,
                                          ),
                                          itemIndexInCart,
                                        );
                                        if (optionsWatch.embroideryOptions !=
                                            null) {
                                          // finding index of embroideer in cart list if already  added.
                                          // if already added then value of embroideryItemIndexInCart will be index of item in cart
                                          // else value of embroideryItemIndexInCart will be -1
                                          int embroideryItemIndexInCart = cartList.indexWhere(
                                              (element) => (element.isEmbroidery == true &&
                                                  element.varientId ==
                                                      optionsWatch
                                                          .embroideryOptions!
                                                          .varientId &&
                                                  element.embroideryOptions!.parentId ==
                                                      selectedVariant.node.id &&
                                                  element.embroideryOptions!.line1 ==
                                                      optionsWatch
                                                          .embroideryOptions!
                                                          .embroideryOptions!
                                                          .line1 &&
                                                  element.embroideryOptions!.line2 ==
                                                      optionsWatch
                                                          .embroideryOptions!
                                                          .embroideryOptions!
                                                          .line2 &&
                                                  element.embroideryOptions!.color ==
                                                      optionsWatch
                                                          .embroideryOptions!
                                                          .embroideryOptions!
                                                          .color &&
                                                  element.embroideryOptions!.font ==
                                                      optionsWatch.embroideryOptions!.embroideryOptions!.font &&
                                                  element.embroideryOptions!.position == optionsWatch.embroideryOptions!.embroideryOptions!.position));
                                          print(embroideryItemIndexInCart);
                                          if (embroideryItemIndexInCart != -1) {
                                            // CartModel tempEmbroideryCartModel =
                                            //     cartList[
                                            //         embroideryItemIndexInCart];
                                            // tempEmbroideryCartModel
                                            //     .quantity = (int.parse(
                                            //             tempEmbroideryCartModel
                                            //                 .quantity!) +
                                            //         1)
                                            //     .toString();
                                            print("old embroidery");
                                            cartRead.updateCart(
                                              CartModel(
                                                available: cartList[
                                                        embroideryItemIndexInCart]
                                                    .available,
                                                comparePrice: cartList[
                                                        embroideryItemIndexInCart]
                                                    .comparePrice,
                                                productImage: cartList[
                                                        embroideryItemIndexInCart]
                                                    .productImage,
                                                productId: cartList[
                                                        embroideryItemIndexInCart]
                                                    .productId,
                                                productName: cartList[
                                                        embroideryItemIndexInCart]
                                                    .productName,
                                                productPrice: cartList[
                                                        embroideryItemIndexInCart]
                                                    .productPrice,
                                                quantity: (int.parse(cartList[
                                                                embroideryItemIndexInCart]
                                                            .quantity!) +
                                                        1)
                                                    .toString(),
                                                sku: cartList[
                                                        embroideryItemIndexInCart]
                                                    .sku,
                                                varientId: cartList[
                                                        embroideryItemIndexInCart]
                                                    .varientId,
                                                vendor: cartList[
                                                        embroideryItemIndexInCart]
                                                    .vendor,
                                                embroideryOptions:
                                                    EmbroideryOptions(
                                                  line1: cartList[
                                                          embroideryItemIndexInCart]
                                                      .embroideryOptions!
                                                      .line1,
                                                  line2: cartList[
                                                          embroideryItemIndexInCart]
                                                      .embroideryOptions!
                                                      .line2,
                                                  color: cartList[
                                                          embroideryItemIndexInCart]
                                                      .embroideryOptions!
                                                      .color,
                                                  font: cartList[
                                                          embroideryItemIndexInCart]
                                                      .embroideryOptions!
                                                      .font,
                                                  position: cartList[
                                                          embroideryItemIndexInCart]
                                                      .embroideryOptions!
                                                      .position,
                                                  parentId:
                                                      selectedVariant.node.id,
                                                  tags: cartList[
                                                          embroideryItemIndexInCart]
                                                      .embroideryOptions!
                                                      .tags,
                                                  parentTitle: selectedVariant
                                                      .node.title,
                                                ),
                                                isEmbroidery: cartList[
                                                        embroideryItemIndexInCart]
                                                    .isEmbroidery,
                                                productColor: cartList[
                                                        embroideryItemIndexInCart]
                                                    .productColor,
                                                productSize: cartList[
                                                        embroideryItemIndexInCart]
                                                    .productSize,
                                                userId: cartList[
                                                        embroideryItemIndexInCart]
                                                    .userId,
                                              ),
                                              embroideryItemIndexInCart,
                                            );
                                          } else {
                                            print("new embroidery");
                                            cartRead.addCart(
                                              CartModel(
                                                available: true,
                                                comparePrice: optionsWatch
                                                    .embroideryOptions!
                                                    .comparePrice,
                                                productImage: optionsWatch
                                                    .embroideryOptions!
                                                    .productImage,
                                                productId: optionsWatch
                                                    .embroideryOptions!
                                                    .productId,
                                                productName: optionsWatch
                                                    .embroideryOptions!
                                                    .productName,
                                                productPrice: optionsWatch
                                                    .embroideryOptions!
                                                    .productPrice,
                                                quantity: optionsWatch
                                                    .embroideryOptions!
                                                    .quantity,
                                                sku: optionsWatch
                                                    .embroideryOptions!.sku,
                                                varientId: optionsWatch
                                                    .embroideryOptions!
                                                    .varientId,
                                                vendor: optionsWatch
                                                    .embroideryOptions!.vendor,
                                                embroideryOptions:
                                                    EmbroideryOptions(
                                                  line1: optionsWatch
                                                      .embroideryOptions!
                                                      .embroideryOptions!
                                                      .line1,
                                                  line2: optionsWatch
                                                      .embroideryOptions!
                                                      .embroideryOptions!
                                                      .line2,
                                                  color: optionsWatch
                                                      .embroideryOptions!
                                                      .embroideryOptions!
                                                      .color,
                                                  font: optionsWatch
                                                      .embroideryOptions!
                                                      .embroideryOptions!
                                                      .font,
                                                  position: optionsWatch
                                                      .embroideryOptions!
                                                      .embroideryOptions!
                                                      .position,
                                                  parentId:
                                                      selectedVariant.node.id,
                                                  tags: optionsWatch
                                                      .embroideryOptions!
                                                      .embroideryOptions!
                                                      .tags,
                                                  parentTitle: selectedVariant
                                                      .node.title,
                                                ),
                                                isEmbroidery: optionsWatch
                                                    .embroideryOptions!
                                                    .isEmbroidery,
                                                productColor: optionsWatch
                                                    .embroideryOptions!
                                                    .productColor,
                                                productSize: optionsWatch
                                                    .embroideryOptions!
                                                    .productSize,
                                                userId: optionsWatch
                                                    .embroideryOptions!.userId,
                                              ),
                                            );
                                          }
                                        }
                                        Fluttertoast.showToast(
                                          msg: "Added in cart",
                                        );
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: "No more Item in Stock",
                                        );
                                      }
                                      // Fluttertoast.showToast(
                                      //   msg: "Already in Cart",
                                      // );
                                    }
                                  },
                                  text: 'ADD TO BAG'.tr,
                                ),
                              ),
                            ],
                          ),
                          // ------- Size Chart -------
                          AppButtons.myTextButton(
                            text: "Size Chart".tr,
                            textStyle: AppTextStyles.lable3.copyWith(
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              // color: appcolor
                            ),
                            onPressed: () {},
                            context: context,
                          ),
                          // ------- Embroidery -------

                          if (optionsRead.embroideryOptions == null)
                            Visibility(
                              visible: widget
                                          .singleProduct.emborideryMetafield !=
                                      null &&
                                  widget.singleProduct.emborideryMetafield !=
                                      "",
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "PERSONALIZE".tr,
                                    style: AppTextStyles.headline3.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context
                                          .push("/embroidery_screen", extra: {
                                        "productID": widget
                                            .singleProduct.emborideryMetafield,
                                        "tags": widget.singleProduct.tags,
                                        "parentId": selectedVariant.node.id,
                                        "uniquePageKey": uniquePageKey,
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.h, horizontal: 17.w),
                                      // margin: EdgeInsets.symmetric(horizontal: 20.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(widget.singleProduct
                                                  .embroidaryHeadings?.tr ??
                                              "Add Embroidery".tr),
                                          Text("From 14 SAR".tr),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "PERSONALIZE".tr,
                                  style: AppTextStyles.headline3.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 92.w,
                                      // height: 141.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.greyCA,
                                      ),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl: optionsRead
                                            .embroideryOptions!.productImage!,
                                        placeholder: (context, url) => SizedBox(
                                          width: 92.w,
                                          height: 141.h,
                                          child: Center(
                                            child: Image(
                                              image: AssetImage(
                                                AppImages.embroderyImage,
                                              ),
                                              width: 92.w,
                                              height: 141.h,
                                              opacity:
                                                  AlwaysStoppedAnimation(0.3),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Embroidery",
                                            style: AppTextStyles.body3.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            "Line 1: ${optionsRead.embroideryOptions!.embroideryOptions!.line1}",
                                            style: AppTextStyles.lable3,
                                          ),
                                          Visibility(
                                            visible: optionsRead
                                                .embroideryOptions!
                                                .embroideryOptions!
                                                .line2!
                                                .isNotEmpty,
                                            child: Text(
                                              "Line 2: ${optionsRead.embroideryOptions!.embroideryOptions!.line2}",
                                              style: AppTextStyles.lable3,
                                            ),
                                          ),
                                          Visibility(
                                            visible: optionsRead
                                                .embroideryOptions!
                                                .embroideryOptions!
                                                .tags!
                                                .contains("SelectColor"),
                                            child: Text(
                                              "Color: ${optionsRead.embroideryOptions!.embroideryOptions!.color}",
                                              style: AppTextStyles.lable3,
                                            ),
                                          ),
                                          Visibility(
                                            visible: optionsRead
                                                .embroideryOptions!
                                                .embroideryOptions!
                                                .tags!
                                                .contains("SelectFont"),
                                            child: Text(
                                              "Font: ${optionsRead.embroideryOptions!.embroideryOptions!.font}",
                                              style: AppTextStyles.lable3,
                                            ),
                                          ),
                                          Visibility(
                                            visible: optionsRead
                                                .embroideryOptions!
                                                .embroideryOptions!
                                                .tags!
                                                .contains("SelectPosition"),
                                            child: Text(
                                              "Position: ${optionsRead.embroideryOptions!.embroideryOptions!.position}",
                                              style: AppTextStyles.lable3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        optionsRead.clearEmbroidery();
                                        // ref.refresh(productDetailsProvider(uniquePageKey));
                                      },
                                      icon: Icon(Icons.delete_outline),
                                    ),
                                  ],
                                ),
                                Divider(color: AppColors.greyDE),
                              ],
                            ),
                          // ------- Expanded tiles -------
                          ExpansionTile(
                            shape: Border(),
                            minTileHeight: 5.h,
                            tilePadding: EdgeInsets.all(0),
                            title: Text(
                              // "DESCRIPTION",

                              widget.singleProduct.collapsibleHeading1!,
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
                                data: widget
                                    .singleProduct.collapsibleDescription1,
                              ),
                            ],
                          ),
                          ExpansionTile(
                            shape: Border(),
                            minTileHeight: 5.h,
                            tilePadding: EdgeInsets.all(0),
                            title: Text(
                              // "DELIVERY & RETURNS",
                              widget.singleProduct.collapsibleHeading2!,
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
                                data: widget
                                    .singleProduct.collapsibleDescription2,
                              ),
                            ],
                          ),
                          // PdpProductCarousel(
                          //   productIdList: ["", "", ""],
                          //   sectionTitle: "Recomanded Product",
                          // ),
                        ],
                      ),
                    ),
                  ),
                  // ------- Product Builders -------
                  SliverList.list(
                    children: [
                      FutureBuilder(
                          future: recomandedProducts,
                          builder: (context, snap) {
                            if (snap.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snap.hasError ||
                                (snap.data == null &&
                                    snap.connectionState !=
                                        ConnectionState.waiting)) {
                              return SizedBox();
                            }
                            return PdpProductCarousel(
                              products: snap.data ?? [],
                              sectionTitle: "Recomanded Product".tr,
                            );
                          }),
                      FutureBuilder(
                          future: popularProducts,
                          builder: (context, snap) {
                            if (snap.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snap.hasError ||
                                (snap.data == null &&
                                    snap.connectionState !=
                                        ConnectionState.waiting)) {
                              return SizedBox();
                            }
                            return PdpProductCarousel(
                              products: snap.data ?? [],
                              sectionTitle: "Popular Product".tr,
                            );
                          }),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
