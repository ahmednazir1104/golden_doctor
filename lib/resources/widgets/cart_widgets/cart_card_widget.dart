import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_doctor/models/cart/cart_model.dart';
import 'package:golden_doctor/utils/app_colors.dart';
import 'package:golden_doctor/utils/app_constant.dart';
import 'package:golden_doctor/utils/app_fonts.dart';
import 'package:golden_doctor/utils/app_images.dart';
import 'package:golden_doctor/view_models/cart_view_model.dart';

class CartCardWidget extends ConsumerWidget {
  final int cartIndex;
  const CartCardWidget({required this.cartIndex, super.key});

  @override
  Widget build(BuildContext context, ref) {
    final cartRead = ref.read(cartProvider.notifier);
    final cartList = ref.watch(cartProvider);
    CartModel cartModel = cartList[cartIndex];
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: SizedBox(
        height: 175.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              fit: BoxFit.fitHeight,
              imageUrl: cartModel.productImage ?? "",
              width: 103.w,
              height: 160,
              placeholder: (context, url) => SizedBox(
                width: double.infinity,
                // height: 200.h,
                child: Center(
                  child: Image(
                    image: AssetImage(
                      AppImages.logoImage,
                    ),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Expanded(
              child: Padding(
                padding: AppConstant.selectedLanguage == 'EN'
                    ? EdgeInsets.only(left: 15.w)
                    : EdgeInsets.only(right: 15.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            cartModel.productName ?? "Unknown",
                            style: AppTextStyles.body1.copyWith(
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            cartRead.deleteCart(cartIndex);
                          },
                          icon: Icon(
                            Icons.close,
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: cartModel.isEmbroidery == false,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: Text(
                          cartModel.vendor ?? "Unknown",
                          style: AppTextStyles.body1.copyWith(
                              fontSize: 16.sp, color: AppColors.grey70),
                        ),
                      ),
                    ),
                    Row(
                      
                      children: [
                        Text(
                          'SAR ${cartModel.productPrice}',
                          style: AppTextStyles.body1.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Visibility(
                          visible: cartModel.comparePrice != null &&
                              cartModel.comparePrice.toString() != "0" &&
                              cartModel.comparePrice.toString() != "" &&
                              cartModel.comparePrice.toString() !=
                                  cartModel.productPrice.toString(),
                          child: Text(
                            '${cartModel.comparePrice}',
                            style: AppTextStyles.body1.copyWith(
                              fontSize: 16.sp,
                              color: AppColors.grey70,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                        Text(
                          cartModel.comparePrice != null &&
                                  cartModel.comparePrice.toString() != "0" &&
                                  cartModel.comparePrice.toString() != "" &&
                                  cartModel.comparePrice.toString() !=
                                      cartModel.productPrice.toString()
                              ? '-${((double.parse(cartModel.productPrice!).toInt() / ~double.parse(cartModel.comparePrice!).toInt()) * 100) - 100}%'
                              : "",
                          style: AppTextStyles.body1.copyWith(
                              fontSize: 16.sp, color: AppColors.redFB71),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: cartModel.isEmbroidery == false,
                      child: Expanded(
                        child: SizedBox(),
                      ),
                    ),
                    cartModel.isEmbroidery == false
                        ? Row(
                            children: [
                              Container(
                                // width: 100.w,
                                decoration: BoxDecoration(
                                  color: AppColors.greyDE,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (int.parse(cartModel.quantity!) >
                                            1) {
                                          // CartModel tempCartModel = new CartModel();
                                          // tempCartModel = cartList[cartIndex];
                                          // tempCartModel.quantity =
                                          // (int.parse(tempCartModel.quantity!) - 1)
                                          //     .toString();
                                          cartRead.updateCart(
                                              CartModel(
                                                available: cartModel.available,
                                                comparePrice:
                                                    cartModel.comparePrice,
                                                productImage:
                                                    cartModel.productImage,
                                                productId: cartModel.productId,
                                                productName:
                                                    cartModel.productName,
                                                productPrice:
                                                    cartModel.productPrice,
                                                quantity: (int.parse(cartModel
                                                            .quantity!) -
                                                        1)
                                                    .toString(),
                                                sku: cartModel.sku,
                                                varientId: cartModel.varientId,
                                                vendor: cartModel.vendor,
                                                embroideryOptions:
                                                    cartModel.embroideryOptions,
                                                isEmbroidery:
                                                    cartModel.isEmbroidery,
                                                productColor:
                                                    cartModel.productColor,
                                                productSize:
                                                    cartModel.productSize,
                                                userId: cartModel.userId,
                                              ),
                                              // CartModel(
                                              //   productColor: cartModel.productId,
                                              //   varientId: cartModel.varientId,
                                              //   productPrice: cartModel.productPrice,
                                              //   productName: cartModel.productName,
                                              //   productImage: cartModel.productImage,
                                              //   quantity:
                                              //       (int.parse(cartModel.quantity!) -
                                              //               1)
                                              //           .toString(),
                                              //   comparePrice: cartModel.comparePrice,
                                              //   sku: cartModel.sku,
                                              // ),
                                              cartIndex);
                                        }
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        color: AppColors.grey70,
                                      ),
                                    ),
                                    // IconButton(
                                    //   onPressed: () {},
                                    //   icon: Icon(
                                    //     Icons.remove,
                                    //     color: AppColors.grey70,
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: Text(cartModel.quantity ?? "0"),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // CartModel tempCartModel = new CartModel();
                                        // tempCartModel = cartList[cartIndex];

                                        // tempCartModel.quantity =
                                        //     (int.parse(tempCartModel.quantity!) + 1)
                                        //         .toString();
                                        // print("===============");
                                        // print(tempCartModel.toJson());
                                        // print("===============");
                                        // print(cartList[cartIndex].toJson());
                                        // print("===============");
                                        cartRead.updateCart(
                                            CartModel(
                                              available: cartModel.available,
                                              comparePrice:
                                                  cartModel.comparePrice,
                                              productImage:
                                                  cartModel.productImage,
                                              productId: cartModel.productId,
                                              productName:
                                                  cartModel.productName,
                                              productPrice:
                                                  cartModel.productPrice,
                                              quantity: (int.parse(
                                                          cartModel.quantity!) +
                                                      1)
                                                  .toString(),
                                              sku: cartModel.sku,
                                              varientId: cartModel.varientId,
                                              vendor: cartModel.vendor,
                                              embroideryOptions:
                                                  cartModel.embroideryOptions,
                                              isEmbroidery:
                                                  cartModel.isEmbroidery,
                                              productColor:
                                                  cartModel.productColor,
                                              productSize:
                                                  cartModel.productSize,
                                              userId: cartModel.userId,
                                            ),

                                            // CartModel(
                                            //   productId: cartModel.productId,
                                            //   varientId: cartModel.varientId,
                                            //   productPrice: cartModel.productPrice,
                                            //   productName: cartModel.productName,
                                            //   productImage: cartModel.productImage,
                                            //   quantity:
                                            //       (int.parse(cartModel.quantity!) + 1)
                                            //           .toString(),
                                            //   comparePrice: cartModel.comparePrice,
                                            //   sku: cartModel.sku,
                                            // ),
                                            cartIndex);
                                        // if (count > 1) {
                                        // ref.read(countProvider.notifier).state =
                                        //     count + 1;
                                        // }
                                      },
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.grey70,
                                      ),
                                    )
                                    // IconButton(
                                    //   onPressed: () {},
                                    //   icon: Icon(
                                    //     Icons.add,
                                    //     color: AppColors.grey70,
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(left: 18.w),
                              //   child: Text(
                              //     'Size: L',
                              //     style: AppTextStyles.body1.copyWith(
                              //       fontSize: 16.sp,
                              //     ),
                              //   ),
                              // ),
                            ],
                          )
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                "Line 1: ${cartModel.embroideryOptions!.line1}",
                                style: AppTextStyles.lable3,
                              ),
                              Text(
                                "parentID: ${cartModel.embroideryOptions!.parentId!.split("/").last}",
                                style: AppTextStyles.lable3,
                              ),
                              Visibility(
                                visible: true,
                                // cartModel
                                //     .embroideryOptions!.line2!.isNotEmpty,
                                child: Text(
                                  "Line 2: ${cartModel.quantity}",
                                  // "Line 2: ${cartModel.embroideryOptions!.line2}",
                                  style: AppTextStyles.lable3,
                                ),
                              ),
                              Visibility(
                                visible: cartModel.embroideryOptions!.tags!
                                    .contains("SelectColor"),
                                child: Text(
                                  "Color: ${cartModel.embroideryOptions!.color}",
                                  style: AppTextStyles.lable3,
                                ),
                              ),
                              Visibility(
                                visible: cartModel.embroideryOptions!.tags!
                                    .contains("SelectFont"),
                                child: Text(
                                  "Font: ${cartModel.embroideryOptions!.font}",
                                  style: AppTextStyles.lable3,
                                ),
                              ),
                              Visibility(
                                visible: cartModel.embroideryOptions!.tags!
                                    .contains("SelectPosition"),
                                child: Text(
                                  "Position: ${cartModel.embroideryOptions!.position}",
                                  style: AppTextStyles.lable3,
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ),
            // Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
