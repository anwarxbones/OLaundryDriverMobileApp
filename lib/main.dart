import 'dart:io';

import 'package:dry_cleaners_driver/constants/hive_contants.dart';
import 'package:dry_cleaners_driver/features/core/logic/misc_provider.dart';
import 'package:dry_cleaners_driver/firebase_options.dart';
import 'package:dry_cleaners_driver/utils/context_less_nav.dart';
import 'package:dry_cleaners_driver/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hive_flutter/hive_flutter.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // if (Firebase.apps.isEmpty) {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // }

  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  debugPrint('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
      );

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  final RemoteNotification? notification = message.notification;
  final AndroidNotification? android = message.notification?.android;
  final AppleNotification? iOS = message.notification?.apple;
  if (notification != null && (android != null || iOS != null) && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name, channelDescription: channel.description,
          //      one that already exists in example app.
          icon: '@drawable/ic_stat_launcher',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupFlutterNotifications();
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data);
    print(event);
    debugPrint('Handling a ForeGround message ${event.messageId}');
    debugPrint('Handling a ForeGround message ${event.notification}');

    showFlutterNotification(event);
  });

  final token = await FirebaseMessaging.instance.getToken();
  debugPrint('Token : $token');
  // await oneSignalHandler();
  await Hive.initFlutter();
  await Hive.openBox(AppHSC.appSettingsBox);
  await Hive.openBox(AppHSC.authBox);
  await Hive.openBox(AppHSC.userBox);
  await Hive.openBox(AppHSC.cartBox);
  HttpOverrides.global = MyHttpOverrides();
  runApp(const ProviderScope(child: MyApp()));
}

// Future<void> oneSignalHandler() async {
//   await OneSignal.shared
//       .setAppId('96fa9ec8-39bc-4395-9f3b-2c30fd9fdc3e')
//       .then((value) {
//     // _userctrl.setPlayerID();
//   });
//   OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
//     debugPrint("Accepted permission: $accepted");
//   });

//   OneSignal.shared.setNotificationWillShowInForegroundHandler(
//       (OSNotificationReceivedEvent event) {
//     // if (event.notification.body != null) {
//     //   final FlutterTts flutterTts = FlutterTts();
//     //   flutterTts.speak(event.notification.body!);
//     // }
//     debugPrint('FOREGROUND HANDLER CALLED WITH: ${event.notification.body!}');

//     /// Display Notification, send null to not display
//     event.complete(event.notification);
//   });

//   OneSignal.shared
//       .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
//     // Get.off(() => MainPage());
//     // _userctrl.pageController.value.jumpToPage(1);
//     debugPrint('${result.notification.title} ${result.notification.body}');
//   });
// }

// Future<void> getPlayerID(WidgetRef ref) async {
//   final OSDeviceState? deviciestate = await OneSignal.shared.getDeviceState();

//   if (deviciestate?.userId == null) {
//     return getPlayerID(ref);
//   } else {
//     debugPrint(deviciestate!.userId!);
//     ref.watch(onesignalDeviceIDProvider.notifier).state = deviciestate.userId!;
//   }
// }

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerID = ref.watch(onesignalDeviceIDProvider);
    // if (playerID == '') {
    //   getPlayerID(ref);
    // }
    return ScreenUtilInit(
        designSize: const Size(375, 812), // XD Design Size
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'O Laundry Driver',
            localizationsDelegates: const [
              FormBuilderLocalizations.delegate,
            ],

            theme: ThemeData(
              fontFamily: "Open Sans",
            ),
            navigatorKey: ContextLess
                .navigatorkey, //Setting Global navigator key to navigate from anywhere without Context

            onGenerateRoute: (settings) => generatedRoutes(settings),
            initialRoute: Routes.splash,
            builder: EasyLoading.init(),
          );
        });
  }
}
