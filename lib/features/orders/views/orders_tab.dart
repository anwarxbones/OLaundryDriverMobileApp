import 'package:dry_cleaners_driver/constants/app_colors.dart';
import 'package:dry_cleaners_driver/constants/app_durations.dart';
import 'package:dry_cleaners_driver/constants/app_text_decor.dart';
import 'package:dry_cleaners_driver/features/core/logic/misc_provider.dart';
import 'package:dry_cleaners_driver/features/core/views/widgets/order_tile.dart';
import 'package:dry_cleaners_driver/features/orders/logic/order_provider.dart';
import 'package:dry_cleaners_driver/features/orders/models/pending_order_list_model/order.dart';
import 'package:dry_cleaners_driver/utils/context_less_nav.dart';
import 'package:dry_cleaners_driver/utils/routes.dart';
import 'package:dry_cleaners_driver/widgets/buttons/full_width_button.dart';
import 'package:dry_cleaners_driver/widgets/misc_widgets.dart';
import 'package:dry_cleaners_driver/widgets/nav_bar_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersTab extends ConsumerWidget {
  const OrdersTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentIndex = ref.watch(appOrderTabIndexProvider);
    ref.watch(totalOrderListProvider);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
          ),
          color: AppColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacerH(44.h),
              const AppNavbarHome(),
              AppSpacerH(20.h),
              CustomSeprator(),
              AppSpacerH(10.h),
              SizedBox(
                width: 335.w,
                height: 40.h,
                child: Consumer(builder: (context, ref, child) {
                  return Center(
                    child: ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(5.w),
                          child: GestureDetector(
                            onTap: () {
                              ref
                                  .watch(appOrderTabIndexProvider.notifier)
                                  .state = index;
                            },
                            child: Container(
                              padding: EdgeInsets.only(bottom: 6.h),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: currentIndex == index
                                              ? AppColors.goldenButton
                                              : Colors.transparent,
                                          width: 3.h))),
                              child: Text(index == 0
                                  ? 'Pending'
                                  : index == 1
                                      ? 'Accepted'
                                      : 'History'),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              )
            ],
          ),
        ),
        AppSpacerH(8.h),
        Expanded(
            child: Container(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          color: AppColors.white,
          child: currentIndex == 2
              ? ref.watch(orderHistoriesProvider).map(
                  initial: (_) => const LoadingWidget(),
                  loading: (_) => const LoadingWidget(),
                  loaded: (_) {
                    if (_.data.data!.orders!.isNotEmpty) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: _.data.data!.orders!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: GestureDetector(
                                onTap: () {
                                  context.nav.pushNamed(Routes.orderScreen,
                                      arguments: Order.fromMap(
                                          _.data.data!.orders![index].toMap()));
                                },
                                child: OrderTile(
                                    order: Order.fromMap(
                                        _.data.data!.orders![index].toMap()))),
                          );
                        },
                      );
                    } else {
                      return const MessageTextWidget(msg: 'No Oders Available');
                    }
                  },
                  error: (_) => ErrorTextWidget(error: _.error))
              : ref.watch(totalOrderListProvider).map(
                  initial: (_) => const LoadingWidget(),
                  loading: (_) => const LoadingWidget(),
                  loaded: (_) {
                    if (_.data.data!.orders!.isNotEmpty) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: _.data.data!.orders!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: GestureDetector(
                                onTap: () {
                                  if (currentIndex == 0) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Center(
                                        child: Consumer(
                                            builder: (context, ref, child) {
                                          ref.watch(acceptOrderProvider);
                                          return Padding(
                                            padding: EdgeInsets.all(20.w),
                                            child: Container(
                                              width: 375.w,
                                              decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.h)),
                                              child: Padding(
                                                padding: EdgeInsets.all(20.h),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'Do you Want to Accept This Order',
                                                      style: AppTextDecor
                                                          .osBold18black,
                                                    ),
                                                    AppSpacerH(20.h),
                                                    ref
                                                        .watch(
                                                            acceptOrderProvider)
                                                        .map(
                                                            initial: (ini) =>
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                        child: AppTextButton(
                                                                            onTap: () {
                                                                              ref.watch(acceptOrderProvider.notifier).acceptOrder(id: _.data.data!.orders![index].id!.toString(), status: '0');

                                                                              ref.refresh(totalOrderListProvider);
                                                                              ref.refresh(todaysJobListProvider);
                                                                            },
                                                                            buttonColor: AppColors.red,
                                                                            title: 'Reject')),
                                                                    AppSpacerW(
                                                                        10.w),
                                                                    Expanded(
                                                                        child: AppTextButton(
                                                                            onTap: () {
                                                                              ref.watch(acceptOrderProvider.notifier).acceptOrder(id: _.data.data!.orders![index].id!.toString(), status: '1');
                                                                              ref.refresh(totalOrderListProvider);
                                                                              ref.refresh(todaysJobListProvider);
                                                                            },
                                                                            title: 'Accept')),
                                                                  ],
                                                                ),
                                                            error: (_) {
                                                              Future.delayed(
                                                                      AppDurConst
                                                                          .buildDuration)
                                                                  .then(
                                                                      (value) {
                                                                ref.refresh(
                                                                    acceptOrderProvider);
                                                              });
                                                              return ErrorTextWidget(
                                                                  error:
                                                                      _.error);
                                                            },
                                                            loaded: (_) {
                                                              Future.delayed(
                                                                      AppDurConst
                                                                          .buildDuration)
                                                                  .then(
                                                                      (value) {
                                                                // Updating These Providers To See Update In UI
                                                                ref.refresh(
                                                                    acceptOrderProvider);
                                                                ref.refresh(
                                                                    totalOrderListProvider);
                                                                ref.refresh(
                                                                    todaysJobListProvider);
                                                                context.nav
                                                                    .pop();
                                                                ref.refresh(
                                                                    todaysPendingOrderListProvider);
                                                                ref.refresh(
                                                                    thisWeekDeliveryListProvider);
                                                              });
                                                              return MessageTextWidget(
                                                                  msg: _.data);
                                                            },
                                                            loading: (_) =>
                                                                const LoadingWidget()),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    );
                                  } else {
                                    context.nav.pushNamed(Routes.orderScreen,
                                        arguments: _.data.data!.orders![index]);
                                  }
                                },
                                child: OrderTile(
                                    order: _.data.data!.orders![index])),
                          );
                        },
                      );
                    } else {
                      return const MessageTextWidget(msg: 'No Oders Available');
                    }
                  },
                  error: (_) => ErrorTextWidget(error: _.error)),
        ))
      ],
    );
  }
}
