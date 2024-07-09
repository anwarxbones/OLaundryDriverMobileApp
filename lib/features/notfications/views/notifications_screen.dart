import 'package:dry_cleaners_driver/constants/app_box_decoration.dart';
import 'package:dry_cleaners_driver/constants/app_colors.dart';
import 'package:dry_cleaners_driver/constants/app_text_decor.dart';
import 'package:dry_cleaners_driver/features/notfications/logic/notifications_providers.dart';
import 'package:dry_cleaners_driver/features/notfications/views/widgets/notifications_tile.dart';
import 'package:dry_cleaners_driver/widgets/misc_widgets.dart';
import 'package:dry_cleaners_driver/widgets/nav_bar.dart';
import 'package:dry_cleaners_driver/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  List<Widget> notifications = [];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    ref.watch(allNotificationsProvider).when(initial: () {
      notifications = [];
      notifications.add(const LoadingWidget());
    }, loading: () {
      notifications = [];
      notifications.add(const LoadingWidget());
    }, error: (_) {
      notifications = [];
      notifications.add(ErrorTextWidget(
        error: _,
      ));
    }, loaded: (data) {
      notifications = [];
      if (data.data!.notification!.isNotEmpty) {
        setState(() {
          count = data.data!.notification!.length;
        });
        for (var element in data.data!.notification!) {
          notifications.add(NotificationTile(
            notification: element,
          ));
        }
      } else {
        notifications.add(const MessageTextWidget(msg: 'No Notfiation Found'));
      }
    });
    return ScreenWrapper(
        child: Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 12.h),
          decoration: AppBoxDecorations.topBar2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacerH(44.h),
              AppNavbar(
                  title: Center(
                    child: Text(
                      "Notifications",
                      style: AppTextDecor.osBold12black,
                    ),
                  ),
                  showBack: true),
            ],
          ),
        ),
        AppSpacerH(8.h),
        Expanded(
            child: Container(
          color: AppColors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              AppSpacerH(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text(
                      "New",
                      style: AppTextDecor.osBold14black,
                    ),
                    AppSpacerW(4.w),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      decoration: BoxDecoration(
                          color: AppColors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4.h)),
                      child: Text(
                        count.toString(),
                        style: AppTextDecor.osBold10red,
                      ),
                    )
                  ],
                ),
              ),
              AppSpacerH(10.h),
              ...notifications
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20.w),
              //   child: Row(
              //     children: [
              //       Text(
              //         "Last Week",
              //         style: AppTextDecor.osBold14black,
              //       ),
              //       AppSpacerW(4.w),
              //       Container(
              //         padding:
              //             EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              //         decoration: BoxDecoration(
              //             color: AppColors.red.withOpacity(0.1),
              //             borderRadius: BorderRadius.circular(4.h)),
              //         child: Text(
              //           "4",
              //           style: AppTextDecor.osBold10red,
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ))
      ],
    ));
  }
}
