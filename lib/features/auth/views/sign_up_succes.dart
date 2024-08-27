import 'dart:io';

import 'package:dry_cleaners_driver/constants/app_colors.dart';
import 'package:dry_cleaners_driver/constants/app_text_decor.dart';
import 'package:dry_cleaners_driver/widgets/buttons/full_width_button.dart';
import 'package:dry_cleaners_driver/widgets/misc_widgets.dart';
import 'package:dry_cleaners_driver/widgets/screen_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpSuccessScreen extends StatelessWidget {
  const SignUpSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        child: Center(
      child: Container(
        margin: EdgeInsets.all(21.h),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.h),
            boxShadow: [
              BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  offset: Offset(0, 4.h),
                  blurRadius: 12.h,
                  spreadRadius: 0)
            ]),
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/icon_under_review.png"),
            AppSpacerH(24.h),
            Text(
              "Your registration request on review, please wait for confirmation.",
              textAlign: TextAlign.center,
              style: AppTextDecor.osRegular14black,
            ),
            AppSpacerH(24.h),
            Text(
              "We will send you a SMS after we verify and confirm your request.",
              style: AppTextDecor.osRegular14Navy,
              textAlign: TextAlign.center,
            ),
            AppSpacerH(24.h),
            AppTextButton(
              title: "Got It",
              onTap: () {
                EasyLoading.showSuccess("App will Close");
                Future.delayed(const Duration(seconds: 3)).then((value) {
                  exit(0);
                });
              },
            )
          ],
        ),
      ),
    ));
  }
}
