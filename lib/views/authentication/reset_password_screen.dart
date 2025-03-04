import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:golden_doctor/resources/widgets/universal_widget/app_button.dart';
import 'package:golden_doctor/resources/widgets/universal_widget/app_textfield.dart';
import 'package:golden_doctor/utils/app_fonts.dart';
import 'package:golden_doctor/utils/app_keys.dart';
import 'package:golden_doctor/utils/app_textfield_controllers.dart';
import 'package:golden_doctor/view_models/authentication_view_model.dart';

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
      bool bolleanvalue = ref.watch(apiServiceProvider).boleanValue;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 27.w),
        child: Form(
          key: AppAllKeys.forgetPasswordFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 60.h),
                child: Text(
                  'Write your email here',
                  style: AppTextStyles.body1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 13.h),
                child: Text(
                  '"Lorem ipsum dolor sit amet, consectetur adipiscing eli ad minim veniam,.',
                  style: AppTextStyles.lable1
                      .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 38.h),
                child: AppTextfields.myTextField(
                  controller: AppTextfieldControllers.forgetPasswordEmail,
                  lable: 'Enter your email',
                  icon: Icons.mail,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.h),
                child:  bolleanvalue
                    ? const CircularProgressIndicator()
                    :  AppButtons.myprimaryButton(
                      onPressed: () async {
                    if (AppAllKeys.forgetPasswordFormKey.currentState!
                        .validate()) {
                      ref.read(apiServiceProvider.notifier).changeUserPassword(
                            context,
                            AppTextfieldControllers.forgetPasswordEmail.text,
                          );
                      AppTextfieldControllers.forgetPasswordEmail.clear();
                    } else {
                      Fluttertoast.showToast(msg: "Enter Email first");
                      AppTextfieldControllers.forgetPasswordEmail.clear();
                    }
                  },
                  text: 'Send',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
