import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:golden_doctor/resources/services/shearedpreference_service.dart';
import 'package:golden_doctor/resources/widgets/profile_widget/tab_widget.dart';
import 'package:golden_doctor/resources/widgets/universal_widget/app_button.dart';
import 'package:golden_doctor/utils/app_colors.dart';
import 'package:golden_doctor/utils/app_constant.dart';
import 'package:golden_doctor/utils/app_fonts.dart';
import 'package:golden_doctor/utils/app_images.dart';
import 'package:golden_doctor/view_models/authentication_view_model.dart';
import 'package:golden_doctor/view_models/fonts_view_model.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  String? userToken;

  void checkUser() {
    userToken = ShearedprefService.getUserAccessToken();

    Timer(const Duration(seconds: 0), () {
      if (userToken == null || userToken == '') {
        print('No Device token data ');
      } else {
        print('Have Device token data ');
        ref.read(apiServiceProvider.notifier).profile(userToken!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pagesData = ref.watch(getPagesProvider);
    final authenticationrepository = ref.watch(apiServiceProvider);
    final authenticationrepositoryRead = ref.read(apiServiceProvider.notifier);
    // String userToken = ShearedprefService.getUserAccessToken()!;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AppImages.horizantelLogo, height: 32),
      ),
      body:
          //  authenticationrepository.boleanValue
          userToken == null || userToken == ''
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Text('Welcome to Scrubser',
                            style: AppTextStyles.body1),
                      ),
                      SizedBox(height: 15.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.go('/signinScreen');
                              },
                              child: Text(
                                'Log in ',
                                style: AppTextStyles.body1.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            Text(
                              'or ',
                              style: AppTextStyles.body2.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.go('/signupScreen');
                              },
                              child: Text(
                                'Sign up ',
                                style: AppTextStyles.body1.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 18.h, bottom: 15.h),
                        child: Divider(
                          color: AppColors.greyF2F2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Switch anguage',
                              style: AppTextStyles.body1.copyWith(
                                  fontSize: 16.sp, fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                Text(
                                  AppConstant.selectedLanguage!,
                                  style: AppTextStyles.body1.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 15.w),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 15,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.greyF9,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.h, vertical: 15.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Contact Us',
                                style: AppTextStyles.body1
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15.h),
                                child: Text(
                                  '"Lorem ipsum dolor sit amet, consectetur adipiscing eli ad minim veniam, quis nostrud exercitation"',
                                  style: AppTextStyles.body1.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15.h),
                                child: Row(
                                  children: [
                                    Icon(Icons.local_phone_outlined),
                                    SizedBox(width: 15.w),
                                    Text(
                                      '	(+966) 566292585',
                                      style: AppTextStyles.body1.copyWith(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15.h),
                                child: Row(
                                  children: [
                                    Icon(Icons.mail_outline),
                                    SizedBox(width: 15.w),
                                    Text(
                                      'sales@GoldenDrs.com',
                                      style: AppTextStyles.body1.copyWith(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : authenticationrepository.boleanValue
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // mainAxisSize: MainAxisSize.max,
                          children: [
                            authenticationrepository.profileModel == null
                                ? SizedBox()
                                : Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.w,
                                      vertical: 18.h,
                                    ),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColors.grey9c),
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                            radius: 36.r,
                                            child: Text(authenticationrepository
                                                .profileModel!.firstName![0]
                                                .toUpperCase())),
                                        SizedBox(width: appPaddingNormal),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              authenticationrepository
                                                  .profileModel!.firstName!,
                                              style: AppTextStyles.body1
                                                  .copyWith(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            Text(
                                              authenticationrepository
                                                  .profileModel!.email!,
                                              style: AppTextStyles.body1
                                                  .copyWith(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                            TabWidget(
                              tabTitle: 'Orders',
                              onTap: () {
                                context.go('/orderScreen');
                              },
                            ),
                            TabWidget(
                              tabTitle: 'Reset Password',
                              onTap: () {
                                context.push('/resetPasswordScreen');
                              },
                            ),
                            pagesData.when(
                              data: (pagesData) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: pagesData.pages.length,
                                  itemBuilder: (context, index) {
                                    final page = pagesData.pages[index];
                                    return TabWidget(
                                      tabTitle: page.title,
                                      onTap: () {
                                        context.push(
                                          "/staticPagesScreen",
                                          extra: {
                                            "singlePage": page,
                                          },
                                          // "/online_product_detail_screen",
                                          // extra: {"productID": singleProduct.id},
                                        );
                                      },
                                    );
                                    // ListTile(
                                    //   title: Text(page.title),
                                    //   subtitle: Text(page.content),
                                    // );
                                  },
                                );
                              },
                              loading: () =>
                                  Center(child: CircularProgressIndicator()),
                              error: (err, stack) =>
                                  Center(child: Text("Error: $err")),
                            ),
                            SizedBox(height: 15.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Switch anguage',
                                    style: AppTextStyles.body1.copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        AppConstant.selectedLanguage!,
                                        style: AppTextStyles.body1.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(width: 15.w),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 15,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15.h),
                              child: Row(
                                children: [
                                  Icon(Icons.local_phone_outlined),
                                  SizedBox(width: 15.w),
                                  Text(
                                    '	(+966) 566292585',
                                    style: AppTextStyles.body1.copyWith(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15.h),
                              child: Row(
                                children: [
                                  Icon(Icons.mail_outline),
                                  SizedBox(width: 15.w),
                                  Text(
                                    'sales@GoldenDrs.com',
                                    style: AppTextStyles.body1.copyWith(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            AppButtons.myprimaryButton(
                              height: 50.h,
                              text: 'Logout',
                              onPressed: () {
                                authenticationrepositoryRead.logOut(context);
                                setState(() {
                                  userToken = '';
                                });
                              },
                            ),
                            SizedBox(height: appPaddingLarge),
                          ],
                        ),
                      ),
                    ),
    );
  }
}
