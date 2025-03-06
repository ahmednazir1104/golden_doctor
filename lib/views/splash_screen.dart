
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:golden_doctor/models/language/language_model.dart';
import 'package:golden_doctor/resources/services/shearedpreference_service.dart';
import 'package:golden_doctor/utils/app_colors.dart';
import 'package:golden_doctor/utils/app_constant.dart';
import 'package:golden_doctor/utils/app_fonts.dart';
import 'package:golden_doctor/utils/app_images.dart';
import 'package:golden_doctor/view_models/fonts_view_model.dart';
import 'package:golden_doctor/view_models/language_provider.dart';

LanguageModel? selectedLanguage;

FontWeight fontWeightFromInt(int weight) {
  switch (weight) {
    case 100:
      return FontWeight.w100;
    case 200:
      return FontWeight.w200;
    case 300:
      return FontWeight.w300;
    case 400:
      return FontWeight.w400;
    case 500:
      return FontWeight.w500;
    case 600:
      return FontWeight.w600;
    case 700:
      return FontWeight.w700;
    case 800:
      return FontWeight.w800;
    case 900:
      return FontWeight.w900;
    default:
      throw ArgumentError(
          "Invalid weight value: $weight. Must be 100, 200, ..., 900.");
  }
}

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
// print('SplashScreen');
//       ref.watch(getPagesProvider);

    // ref.read(getTranslationProvider.notifier).fetchNavigation();
   ref.watch(getColorProvider);

    // final colorList = ref.watch(colorPaletteListProvider);
    // log('colorList ==== ${colorList.length}');

    // print('fontSettingsAsync');
    // final fontSettingsAsync =
    ref.watch(fontSettingsProvider);
    // print('getLanguageAsync');
    final getLanguageAsync = ref.watch(getLanguageProvider);
    // print('getTranslationAsync');
    // final getTranslationAsync =
    ref.watch(getTranslationProvider);
    return Directionality(
      textDirection: AppConstant.selectedLanguage == 'EN'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                AppImages.splashScreenImage,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: 60.h, bottom: 60.h, left: 15.w, right: 15.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 55.h,
                      width: 55.w,
                      child: Image(
                        image: AssetImage(
                          AppImages.logoImage,
                        ),
                      ),
                    ),
                    getLanguageAsync.when(
                      data: (languages) {
                        return DropdownButton<LanguageModel>(
                          iconEnabledColor: AppColors.myScaffold,
                          iconDisabledColor: AppColors.myScaffold,
                          underline: SizedBox(),
                          padding: EdgeInsets.all(0),
                          value: selectedLanguage,
                          dropdownColor: AppColors.myPrimary,
                          hint: Row(
                            spacing: 5.w,
                            children: [
                              Icon(
                                Icons.language,
                                color: AppColors.myScaffold,
                              ),
                              Text(
                                AppConstant.selectedLanguage!,
                                style: AppTextStyles.headline2
                                    .copyWith(color: AppColors.myScaffold),
                              ),
                            ],
                          ),
                          items: languages.map((language) {
                            return DropdownMenuItem<LanguageModel>(
                              value: language,
                              child: Row(
                                children: [
                                  Image.network(
                                    language.iconSrc,
                                    width: 24,
                                    height: 24,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    language.title,
                                    style: AppTextStyles.headline2
                                        .copyWith(color: AppColors.myScaffold),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (LanguageModel? newLanguage) {
                            setState(() {
                              if (kDebugMode) {
                                print(
                                    'Selected Language: ${newLanguage?.title}');
                                    log(
                                    'Selected Language: ${newLanguage?.title}');
                                    log('Selected Language: ${newLanguage?.label}');
                              }
                              selectedLanguage = newLanguage;
                              ShearedprefService.setLanguage(
                                  selectedLanguage!.label.toString());
                              AppConstant.selectedLanguage =
                                  selectedLanguage!.label.toString();
                            });
                          },
                        );
                      },
                      loading: () => CircularProgressIndicator(),
                      error: (err, stack) => Text('Error: $err'),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 254.w,
                      child: RichText(
                        text: TextSpan(
                          text: 'Master the Game '.tr,
                          // text: "textOne".tr,
                          style: AppTextStyles.lable2.copyWith(
                            color: AppColors.myScaffold,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            WidgetSpan(
                              child: Text(
                                "of Today’s Fashion".tr,
                                style: AppTextStyles.body1.copyWith(
                                  color: AppColors.myScaffold,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "Scrubser  here. Anytime. Anywhere.".tr,
                      style: AppTextStyles.body3.copyWith(
                        color: AppColors.myScaffold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.go('/wellcomeScreen');
                        // context.go('/nav_barScreen');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.5.h, horizontal: 2.w),
                        margin: EdgeInsets.only(top: 60.h),
                        decoration: BoxDecoration(
                          color: AppColors.myScaffold,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Text(
                              "Get Started".tr,
                              style: AppTextStyles.body2.copyWith(
                                color: AppColors.myPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              height: 41.h,
                              width: 46.w,
                              decoration: BoxDecoration(
                                color: AppColors.myPrimary,
                                borderRadius: BorderRadius.circular(3.8.r),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.myScaffold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // fontSettingsAsync.when(
                //   data: (fontSettings) {
                //     // Navigate to home screen once data is loaded
                //     AppTextStyles.updateFontStyles(
                //       family: fontSettings.fontFamily,
                //       // h1Size: double.parse(fontSettings.headline1Size.toString()),
                //       // h2Size: double.parse(fontSettings.headline2Size.toString()),
                //       // b1Size: double.parse(fontSettings.body1Size.toString()),
                //       // b2Size: double.parse(fontSettings.body2Size.toString()),
                //       // b3Size: double.parse(fontSettings.body3Size.toString()),
                //       // h1Weight: fontWeightFromInt(fontSettings.headline1Weight),
                //       // h2Weight: fontWeightFromInt(fontSettings.headline2Weight),
                //       // b1Weight: fontWeightFromInt(fontSettings.body1Weight),
                //       // b2Weight: fontWeightFromInt(fontSettings.body2Weight),
                //       // b3Weight: fontWeightFromInt(fontSettings.body3Weight),
                //     );
                //     // Future.microtask(() => Navigator.push(
                //     //     context,
                //     //     MaterialPageRoute(
                //     //       builder: (context) => const MainScreen(),
                //     //     )));
                //     return Container(
                //       height: 25,
                //       color: AppColors.black2022,
                //     );
                //   },
                //   loading: () => const Center(child: CircularProgressIndicator()),
                //   error: (error, stack) {
                //     print("Error: $error");
                //     print("Stack trace: $stack");
                //     return const Center(
                //         child: Text('Error loading font settings'));
                //   },
                // ),
                // SizedBox(
                //   height: 400,
                //   child: getTranslationAsync.when(
                //     data: (translations) {
                //       return ListView.builder(
                //         itemCount: homePageTranslations.length,
                //         itemBuilder: (context, index) {
                //           final translation = homePageTranslations[index];
                //           return ListTile(
                //             title: Text(translation.baseContent),
                //             subtitle: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                     'Translated: ${translation.translatedContent}'),
                //                 Text('Locale: ${translation.locale}'),
                //                 Text('Type: ${translation.type}'),
                //               ],
                //             ),
                //           );
                //         },
                //       );
                //     },
                //     loading: () => CircularProgressIndicator(),
                //     error: (err, stack) => Text('Error: $err'),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class SplashScreen extends ConsumerWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     print('fontSettingsAsync');
//     final fontSettingsAsync = ref.watch(fontSettingsProvider);
//     print('getLanguageAsync');
//     final getLanguageAsync = ref.watch(getLanguageProvider);
//     return Scaffold(
//       body: Column(
//         children: [
// getLanguageAsync.when(
//       data: (languages) {
//         return DropdownButton<LanguageModel>(
//           value: selectedLanguage,
//           hint: Text("Select a Language"),
//           items: languages.map((language) {
//             return DropdownMenuItem<LanguageModel>(
//               value: language,
//               child: Row(
//                 children: [
//                   Image.network(
//                     language.iconSrc,
//                     width: 24,
//                     height: 24,
//                     fit: BoxFit.cover,
//                   ),
//                   const SizedBox(width: 10),
//                   Text(language.title),
//                 ],
//               ),
//             );
//           }).toList(),
//           onChanged: (LanguageModel? newLanguage) {
//             setState(() {
//               selectedLanguage = newLanguage;
//             });
//             print('Selected Language: ${newLanguage?.title}');
//           },
//         );
//       },
//       loading: () => CircularProgressIndicator(),
//       error: (err, stack) => Text('Error: $err'),
//     ),

//           fontSettingsAsync.when(
//             data: (fontSettings) {
//               // Navigate to home screen once data is loaded
//               AppTextStyles.updateFontStyles(
//                 family: fontSettings.fontFamily,
//                 // h1Size: double.parse(fontSettings.headline1Size.toString()),
//                 // h2Size: double.parse(fontSettings.headline2Size.toString()),
//                 // b1Size: double.parse(fontSettings.body1Size.toString()),
//                 // b2Size: double.parse(fontSettings.body2Size.toString()),
//                 // b3Size: double.parse(fontSettings.body3Size.toString()),
//                 // h1Weight: fontWeightFromInt(fontSettings.headline1Weight),
//                 // h2Weight: fontWeightFromInt(fontSettings.headline2Weight),
//                 // b1Weight: fontWeightFromInt(fontSettings.body1Weight),
//                 // b2Weight: fontWeightFromInt(fontSettings.body2Weight),
//                 // b3Weight: fontWeightFromInt(fontSettings.body3Weight),
//               );
//               Future.microtask(() => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const MainScreen(),
//                   )));
//               return null;
//             },
//             loading: () => const Center(child: CircularProgressIndicator()),
//             error: (error, stack) {
//               print("Error: $error");
//               print("Stack trace: $stack");
//               return const Center(child: Text('Error loading font settings'));
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
