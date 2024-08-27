import 'package:dry_cleaners_driver/constants/hive_contants.dart';
import 'package:dry_cleaners_driver/utils/context_less_nav.dart';
import 'package:dry_cleaners_driver/utils/routes.dart';
import 'package:dry_cleaners_driver/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Box authBox = Hive.box(AppHSC.authBox);
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      context.nav.pushNamedAndRemoveUntil(
        (authBox.get(AppHSC.authToken) != null &&
                authBox.get(AppHSC.authToken) != '')
            ? Routes.homePage
            : Routes.loginScreen,
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Center(
        // child: Image.asset("assets/images/driver_app_top_logo.png"),
        // child: Image.asset("assets/images/driver_app_top_logo.png"),
        child: Hero(
          tag: 'logo',
          child: Image.asset(
            'assets/images/driver_app_top_logo.png',
            height: 200.h,
            width: 200.w,
          ),
        ),
      ),
    );
  }
}
