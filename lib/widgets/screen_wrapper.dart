import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o_driver/constants/app_colors.dart';
import 'package:o_driver/utils/global_functions.dart';

class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper({
    Key? key,
    this.color = AppColors.grayBG,
    required this.child,
    this.padding,
  }) : super(key: key);
  final Color color;
  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    AppGFunctions.changeStatusBarColor(color: Colors.transparent);
    return Scaffold(
      // extendBody: true,
      // extendBodyBehindAppBar: true,
      body: Container(
        height: 812.h,
        width: 375.w,
        padding: padding ?? EdgeInsets.zero,
        color: color,
        child: child,
      ),
    );
  }
}
