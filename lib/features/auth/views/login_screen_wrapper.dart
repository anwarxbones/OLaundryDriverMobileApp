import 'package:o_driver/constants/app_colors.dart';
import 'package:o_driver/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreenWrapper extends StatelessWidget {
  const LoginScreenWrapper({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      color: AppColors.grayBG,
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  'assets/images/top_bg.png',
                ),
              ),
            ),
            height: 230.h,
          ),
          Container(
            height: 230.h,
            decoration: BoxDecoration(
              color: AppColors.grayBG,
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  AppColors.grayBG.withOpacity(0.5),
                  AppColors.grayBG,
                ],
                stops: const [0.0, 1.0],
              ),
            ),
          ),
          SizedBox(
            height: 812.h,
            width: 375.w,
            child: child,
          )
        ],
      ),
    );
  }
}
