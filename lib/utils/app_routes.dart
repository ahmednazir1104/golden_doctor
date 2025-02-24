import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:golden_doctor/views/authentication/forget_password.dart';
import 'package:golden_doctor/views/authentication/login_screen.dart';
import 'package:golden_doctor/views/authentication/signup_screen.dart';
import 'package:golden_doctor/views/checkout/checkout_screen.dart';
import 'package:golden_doctor/views/home_screen.dart';
import 'package:golden_doctor/views/navigation_screen/navigation_screen.dart';
import 'package:golden_doctor/views/product_detail_pages/embroidery_screen.dart';
import 'package:golden_doctor/views/product_detail_pages/online_product_details.dart';
import 'package:golden_doctor/views/product_detail_pages/product_detail_screen.dart';
import 'package:golden_doctor/views/search_screen/search_screen.dart';
import 'package:golden_doctor/views/splash_screen.dart';
import 'package:golden_doctor/views/collection_screen/collection_screen.dart';
import 'package:golden_doctor/views/collection_screen/filter_screen.dart';
import 'package:golden_doctor/views/set_builder_screen.dart/set_builder_screen.dart';
import 'package:golden_doctor/views/welcome_screen.dart';

import '../views/bottomnavigationbar/bottomnavbar_screen.dart';
// import 'package:golden_doctor/views/home_screen.dart';
// import 'package:golden_doctor/views/splash_screen.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/homeScreen',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/wellcomeScreen',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/setBuilderScreen',
      builder: (context, state) {
        Map<String, dynamic> params = state.extra as Map<String, dynamic>;
        return SetBuilderScreen(
          collection1: params["collection1"],
          collection2: params["collection2"],
        );
      },
    ),
    // GoRoute(
    //   path: '/collectionScreen',
    //   builder: (context, state) => const CollectionScreen(),
    // ),

    GoRoute(
      path: '/collection_product_screen',
      builder: (context, state) {
        Map<String, dynamic> param = state.extra as Map<String, dynamic>;
        return CollectionProductsScreen(
          collectionId: param["collectionID"],
          collectionName: param["collectionName"],
        );
      },
    ),
    GoRoute(
      path: '/filterScreen',
      builder: (context, state) => const FilterScreen(),
    ),
    GoRoute(
      path: '/signinScreen',
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: '/signupScreen',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/forgetPasswordScreen',
      builder: (context, state) => const ForgetPasswordScreen(),
    ),
    GoRoute(
      path: '/productDetailScreen',
      name: "productDetailScreen",
      builder: (context, state) {
        Map<String, dynamic> params = state.extra as Map<String, dynamic>;
        return ProductDetailScreen(
          key: ValueKey(params["productNode"].id),
          singleProduct: params["productNode"],
        );
      },
    ),
    GoRoute(
        path: '/online_product_detail_screen',
        builder: (context, state) {
          // print(state.extra);
          Map<String, dynamic> params = state.extra as Map<String, dynamic>;
          return OnlineProductDetails(productID: params["productID"]);
        }),

    /////////////////////////////////////// For Testing Purpose ///////////////////////////////////////
    // GoRoute(
    //   path: '/',
    //   builder: (context, state) =>  AliTest(),
    // ),

    GoRoute(
      path: '/nav_barScreen',
      // path: '/',
      builder: (context, state) => const BottomnavbarScreen(),
    ),
    GoRoute(
      path: '/embroidery_screen',
      builder: (context, state) {
        final Map<String, dynamic> params = state.extra as Map<String, dynamic>;
        return EmbroideryScreen(
          embroideryProductID: params["productID"],
          tags: params["tags"],
          parentId: params["parentId"],
          uniquePageKey: params["uniquePageKey"],
        );
      },
    ),
    GoRoute(
      path: '/navigation_screen',
      builder: (context, state) => const NavigationScreen(),
    ),

    GoRoute(
      path: '/search_screen',
      builder: (context, state) => SearchProducts(),
    ),
    GoRoute(
      path: '/checkout_webview_screen',
      builder: (context, state) {
        Map<String, dynamic> checkoutURL = state.extra as Map<String, dynamic>;
        return WebViewCheckout(
          weburl: checkoutURL["checkouturl"],
        );
      },
    ),
    // GoRoute(
    //   path: '/cart_screen',
    //   builder: (context, state) {
    //     Map<String, dynamic> params = state.extra as Map<String, dynamic>;
    //     return CartScreen(
    //       canPop: params["canPop"],
    //     );
    //   },
    // ),
    // GoRoute(
    //     path: '/product_detail_screen',
    //     builder: (context, state) {
    //       // print(state.extra);
    //       Map<String, dynamic> params = state.extra as Map<String, dynamic>;
    //       return ProductDetailScreen(purpleNode: params["purpleNode"]);
    //     }),
    // GoRoute(
    //     path: '/online_product_detail_screen',
    //     builder: (context, state) {
    //       // print(state.extra);
    //       Map<String, dynamic> params = state.extra as Map<String, dynamic>;
    //       return OnlineProductDetails(productID: params["productID"]);
    //     }),
    // GoRoute(
    //   path: '/forget_password_screen',
    //   builder: (context, state) => const ForgetPasswordScreen(),
    // ),
    // GoRoute(
    //   path: '/collections_screen',
    //   builder: (context, state) => const CollectionsScreen(),
    // ),
    // GoRoute(
    //   path: '/collection_product_screen',
    //   builder: (context, state) {
    //     Map<String, dynamic> param = state.extra as Map<String, dynamic>;
    //     return CollectionProductsScreen(
    //       collectionId: param["collectionID"],
    //       collectionName: param["collectionName"],
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: '/checkout_webview_screen',
    //   builder: (context, state) {
    //     Map<String, dynamic> checkoutURL = state.extra as Map<String, dynamic>;
    //     return WebViewCheckout(
    //       weburl: checkoutURL["checkouturl"],
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: '/allOrder_screen',
    //   builder: (context, state) => const AllOrdersScreen(),
    // ),
    // GoRoute(
    //   path: '/search_screen',
    //   builder: (context, state) {
    //     Map<String, dynamic> params = state.extra as Map<String, dynamic>;
    //     return SearchProducts(canPop: params["canPop"]);
    //   },
    // ),
    // GoRoute(
    //   path: '/size_chart_images_screen',
    //   builder: (context, state) {
    //     Map<String, dynamic> data = state.extra as Map<String, dynamic>;
    //     return SizeChartImages(sizechart: data['tags']);
    //   },
    // ),
  ],
);
