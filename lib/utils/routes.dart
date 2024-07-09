import 'package:dry_cleaners_driver/constants/app_durations.dart';
import 'package:dry_cleaners_driver/features/auth/models/login_model/user.dart';
import 'package:dry_cleaners_driver/features/auth/views/login_screen.dart';
import 'package:dry_cleaners_driver/features/auth/views/sign_up_screen.dart';
import 'package:dry_cleaners_driver/features/auth/views/sign_up_succes.dart';
import 'package:dry_cleaners_driver/features/core/views/home_screen.dart';
import 'package:dry_cleaners_driver/features/core/views/splash_screen.dart';
import 'package:dry_cleaners_driver/features/notfications/views/notifications_screen.dart';
import 'package:dry_cleaners_driver/features/orders/models/pending_order_list_model/order.dart';
import 'package:dry_cleaners_driver/features/orders/views/order_screen.dart';
import 'package:dry_cleaners_driver/features/orders/views/this_week_delivery_screen.dart';
import 'package:dry_cleaners_driver/features/orders/views/todays_job_screen.dart';
import 'package:dry_cleaners_driver/features/orders/views/todays_pending_sceen.dart';

import 'package:dry_cleaners_driver/features/profile/views/edit_password_screen.dart';
import 'package:dry_cleaners_driver/features/profile/views/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  /*We are mapping all th eroutes here
  so that we can call any named route
  without making typing mistake
  */
  Routes._();
  //core
  static const splash = '/';
  static const loginScreen = '/loginScreen';
  static const signUpScreen = '/signUpScreen';
  static const signUpSuccessScreen = '/signUpSuccessScreen';
  static const homePage = '/homePage';
  static const orderScreen = '/orderScreen';
  static const notficationsScreen = '/notficationsScreen';
  static const editProfileScreen = '/editProfileScreen';
  static const editPassswordScreen = '/editPassswordScreen';

  //
  static const todayspendingJobScreen = '/todayspendingJobScreen';
  static const todaysjobScreen = '/todaysjobScreen';
  static const thisWeekDeliveryScreen = '/thisWeekDeliveryScreen';

  // static const loginScreen = '/loginScreen';
  // static const orderScreen = '/orderScreen';
}

Route generatedRoutes(RouteSettings settings) {
  Widget child;

  switch (settings.name) {
    //core
    case Routes.splash:
      child = const SplashScreen();
      break;
    case Routes.loginScreen:
      child = const LoginScreen();
      break;
    case Routes.signUpScreen:
      child = const SignUpScreen();
      break;
    case Routes.signUpSuccessScreen:
      child = const SignUpSuccessScreen();
      break;
    case Routes.homePage:
      child = const HomeScreen();
      break;
    case Routes.orderScreen:
      child = OrderScreen(
        order: settings.arguments as Order,
      );
      break;
    case Routes.notficationsScreen:
      child = const NotificationsScreen();
      break;
    case Routes.editProfileScreen:
      child = EditProfileScreen(
        user: settings.arguments as User,
      );
      break;
    case Routes.editPassswordScreen:
      child = const EditPasswordScreen();
      break;

    //
    case Routes.todayspendingJobScreen:
      child = const TodaysPendingDeliveryScreen();
      break;
    case Routes.todaysjobScreen:
      child = const TodaysJobScreen();
      break;
    case Routes.thisWeekDeliveryScreen:
      child = const ThisWeeKDeliveryScreen();
      break;
    // case Routes.loginScreen:
    //   child = const LoginScreen();
    //   break;
    // case Routes.orderScreen:
    //   child = OrderPage(
    //     orderData: settings.arguments as Order,
    //   );
    //   break;

    default:
      throw Exception('Invalid route: ${settings.name}');
  }

  return PageTransition(
    child: child,
    type: PageTransitionType.fade,
    settings: settings,
    duration: AppDurConst.transissionDuration,
    reverseDuration: AppDurConst.transissionDuration,
  );
}
