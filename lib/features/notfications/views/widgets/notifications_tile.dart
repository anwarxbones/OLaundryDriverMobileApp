import 'package:dry_cleaners_driver/constants/app_colors.dart';
import 'package:dry_cleaners_driver/constants/app_text_decor.dart';
import 'package:dry_cleaners_driver/features/notfications/logic/notifications_providers.dart';
import 'package:dry_cleaners_driver/features/notfications/models/notification_list_model/notification.dart'
    as n;
import 'package:dry_cleaners_driver/widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/helper_functions.notification.dart';

class NotificationTile extends ConsumerWidget {
  const NotificationTile({
    Key? key,
    required this.notification,
  }) : super(key: key);
  final n.Notification notification;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String>? texts = notification.message?.split('.');
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: Slidable(
        key: ValueKey(notification.id),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {
            _read(ref);
          }),
          children: [
            SlidableAction(
              onPressed: (context) async {
                await _read(ref);
              },
              backgroundColor: AppColors.cardDeepGreen,
              foregroundColor: Colors.white,
              icon: Icons.read_more,
              label: 'Read',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {
            _delete(ref);
          }),
          children: [
            SlidableAction(
              onPressed: (context) {
                _delete(ref);
              },
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(2.h),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(0.2),
                  offset: const Offset(0, 2),
                  blurRadius: 2,
                )
              ]),
          padding: EdgeInsets.all(10.h),
          child: Row(
            children: [
              Container(
                height: 32.h,
                width: 32.w,
                decoration: BoxDecoration(
                    color: AppColors.goldenButton.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16.h)),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/svgs/icon_pickup.svg',
                    height: 16.h,
                    width: 14.w,
                  ),
                ),
              ),
              AppSpacerW(10.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      texts?.first ?? '',
                      style: notification.isRead == 0
                          ? AppTextDecor.osBold14black
                          : AppTextDecor.osRegular14black,
                    ),
                    Row(
                      children: [
                        Text(
                          texts?.last ?? '',
                          style: notification.isRead == 0
                              ? AppTextDecor.osBold12black
                              : AppTextDecor.osRegular12black,
                        ),
                        const Expanded(child: SizedBox()),
                        // Text(
                        //   "View Details",
                        //   style: AppTextDecor.osRegular12Gold,
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _read(WidgetRef ref) {
    NotficationHelper.readNotfication(id: notification.id!.toString())
        .then((value) {
      ref.refresh(allNotificationsProvider);
    });
  }

  _delete(WidgetRef ref) {
    NotficationHelper.deleteNotfication(id: notification.id!.toString())
        .then((value) {
      ref.refresh(allNotificationsProvider);
    });
  }
}
