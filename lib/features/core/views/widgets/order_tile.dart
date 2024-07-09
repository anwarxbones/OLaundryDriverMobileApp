import 'package:dry_cleaners_driver/constants/app_colors.dart';
import 'package:dry_cleaners_driver/constants/app_text_decor.dart';
import 'package:dry_cleaners_driver/features/core/views/widgets/order_tile_text_row.dart';
import 'package:dry_cleaners_driver/features/orders/models/pending_order_list_model/order.dart';
import 'package:dry_cleaners_driver/utils/global_functions.dart';
import 'package:dry_cleaners_driver/widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    final orderStatus = AppGFunctions.getOrderType(order.driverStatus);
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.gray),
          borderRadius: BorderRadius.circular(2.h)),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(10.h),
            child: Column(
              children: [
                OrderTileTextRow(
                  title: "Order ID:",
                  content: order.orderCode ?? '',
                ),
                AppSpacerH(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OrderTileTextRow(
                      title: "Date:",
                      content: order.deliveryDate ?? '',
                    ),
                    OrderTileTextRow(
                      title: "Time:",
                      content: order.deliveryHour ?? '',
                    ),
                  ],
                ),
                AppSpacerH(10.h),
                Container(
                  color: AppColors.grayBG,
                  width: double.infinity,
                  padding: EdgeInsets.all(8.h),
                  child: Row(
                    children: [
                      const Icon(Icons.location_pin),
                      Expanded(
                        child: Text(AppGFunctions.processAdAddess(order)),
                      ),
                      const Icon(Icons.keyboard_arrow_right_rounded)
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 0.h,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: orderStatus == OrderType.pickUp
                      ? AppColors.goldenButton
                      : orderStatus == OrderType.delivery
                          ? AppColors.cardGreen
                          : Colors.transparent,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(2.h),
                      bottomLeft: Radius.circular(2.h))),
              padding: EdgeInsets.all(4.h),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/svgs/icon_rider_bike.svg',
                    height: 16.h,
                    width: 14.w,
                  ),
                  AppSpacerW(2.w),
                  Text(
                    order.driverStatus != null
                        ? AppGFunctions.capitalizeEveryWord(order.driverStatus!)
                        : '',
                    style: AppTextDecor.osRegular12White,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
