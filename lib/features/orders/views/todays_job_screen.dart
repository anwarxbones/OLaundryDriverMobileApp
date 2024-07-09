import 'package:dry_cleaners_driver/constants/app_colors.dart';
import 'package:dry_cleaners_driver/constants/app_text_decor.dart';
import 'package:dry_cleaners_driver/features/core/views/widgets/order_tile.dart';
import 'package:dry_cleaners_driver/features/orders/logic/order_provider.dart';
import 'package:dry_cleaners_driver/utils/context_less_nav.dart';
import 'package:dry_cleaners_driver/utils/routes.dart';
import 'package:dry_cleaners_driver/widgets/misc_widgets.dart';
import 'package:dry_cleaners_driver/widgets/nav_bar.dart';
import 'package:dry_cleaners_driver/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodaysJobScreen extends ConsumerWidget {
  const TodaysJobScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenWrapper(
      child: Column(
        children: [
          Container(
            color: AppColors.white,
            width: 375.w,
            child: Column(
              children: [
                AppSpacerH(44.h),
                AppNavbar(
                  title: Center(
                      child: Text(
                    'Todays Job',
                    style: AppTextDecor.osBold18black,
                  )),
                  showBack: true,
                ),
                AppSpacerH(10.h)
              ],
            ),
          ),
          Expanded(
              child: ref.watch(todaysJobListProvider).map(
                  initial: (_) => const LoadingWidget(),
                  loading: (_) => const LoadingWidget(),
                  loaded: (_) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: _.data.data!.orders!.isNotEmpty
                            ? ListView.builder(
                                itemCount: _.data.data!.orders!.length,
                                itemBuilder: (context, index) {
                                  final orderData = _.data.data!.orders![index];
                                  return GestureDetector(
                                      onTap: () {
                                        context.nav.pushNamed(
                                            Routes.orderScreen,
                                            arguments: orderData);
                                      },
                                      child: OrderTile(order: orderData));
                                },
                              )
                            : const MessageTextWidget(msg: 'No Job Available'),
                      ),
                  error: (_) => ErrorTextWidget(error: _.error)))
        ],
      ),
    );
  }
}
