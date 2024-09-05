import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o_driver/constants/app_colors.dart';
import 'package:o_driver/constants/app_text_decor.dart';
import 'package:o_driver/features/core/views/widgets/home_screen_overview_card.dart';
import 'package:o_driver/features/core/views/widgets/order_tile.dart';
import 'package:o_driver/features/orders/logic/order_provider.dart';
import 'package:o_driver/utils/context_less_nav.dart';
import 'package:o_driver/utils/routes.dart';
import 'package:o_driver/widgets/misc_widgets.dart';
import 'package:o_driver/widgets/nav_bar_home.dart';

class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab> {
  int todaysPending = 0;
  int todaysjob = 0;
  int thisWeekjob = 0;
  int totalAccepted = 0;

  @override
  Widget build(BuildContext context) {
    //For Todays Pending Job
    ref.watch(todaysPendingOrderListProvider).maybeWhen(
        orElse: () {},
        loaded: (data) {
          setState(() {
            todaysPending = data.data?.total ?? 0;
          });
        });
//For Todays Job
    ref.watch(todaysJobListProvider).maybeWhen(
        orElse: () {},
        loaded: (_) {
          setState(() {
            todaysjob = _.data!.orders!.length;
          });
        });

    //For This WeeK Job
    ref.watch(thisWeekDeliveryListProvider).maybeWhen(
        orElse: () {},
        loaded: (_) {
          setState(() {
            thisWeekjob = _.data!.orders!.length;
          });
        });
    //For Total Accepted
    // ref.watch(totalAcceptedOrderListProvider).maybeWhen(
    //     orElse: () {},
    //     loaded: (_) {
    //       setState(() {
    //         totalAccepted = _.data?.total ?? 0;
    //       });
    //     });
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 12.h),
          color: AppColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacerH(44.h),
              const AppNavbarHome(),
              AppSpacerH(18.h),
              Text(
                'Overview',
                style: AppTextDecor.osBold14black,
              ),
              AppSpacerH(8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.nav.pushNamed(Routes.todayspendingJobScreen);
                    },
                    child: HomeScreenOverviewCard(
                      imagePath: 'assets/images/icon_pending.png',
                      subtitle: "Today's Pending",
                      count: todaysPending.toString(),
                      cardColor: AppColors.red,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.nav.pushNamed(Routes.thisWeekDeliveryScreen);
                    },
                    child: HomeScreenOverviewCard(
                      imagePath: 'assets/images/icon_week_delivery.png',
                      subtitle: "This Week Delivery",
                      count: thisWeekjob.toString(),
                      cardColor: AppColors.cardGreen,
                    ),
                  ),
                  HomeScreenOverviewCard(
                    imagePath: 'assets/images/icon_week_total.png',
                    subtitle: "Total Accepted",
                    count: totalAccepted.toString(),
                    cardColor: AppColors.cardDeepGreen,
                  ),
                ],
              )
            ],
          ),
        ),
        AppSpacerH(8.h),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            color: AppColors.white,
            child: Column(
              children: [
                AppSpacerH(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Today's Job",
                          style: AppTextDecor.osBold14black,
                        ),
                        AppSpacerW(4.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 2.h),
                          decoration: BoxDecoration(
                              color: AppColors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4.h)),
                          child: Text(
                            todaysjob.toString(),
                            style: AppTextDecor.osBold10red,
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        context.nav.pushNamed(Routes.todaysjobScreen);
                      },
                      child: Row(
                        children: [
                          Text(
                            "View All",
                            style: AppTextDecor.osBold14black,
                          ),
                          const Icon(Icons.arrow_forward)
                        ],
                      ),
                    )
                  ],
                ),
                AppSpacerH(10.h),
                Expanded(
                  child: ref.watch(todaysJobListProvider).map(
                        initial: (_) => const LoadingWidget(),
                        loading: (_) => const LoadingWidget(),
                        loaded: (_) {
                          if (_.data.data!.orders!.isNotEmpty) {
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: _.data.data!.orders!.length >= 5
                                  ? 5
                                  : _.data.data!.orders!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      context.nav.pushNamed(Routes.orderScreen,
                                          arguments:
                                              _.data.data!.orders![index]);
                                    },
                                    child: OrderTile(
                                        order: _.data.data!.orders![index]),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const MessageTextWidget(
                                msg: 'No Job Available');
                          }
                        },
                        error: (_) {
                          // Future.delayed(AppDurConst.buildDuration).then(
                          //   (value) {
                          //     ref.refresh(todaysJobListProvider);
                          //   },
                          // );
                          return ErrorTextWidget(error: _.error);
                        },
                      ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
