import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o_driver/constants/app_colors.dart';
import 'package:o_driver/constants/app_text_decor.dart';
import 'package:o_driver/features/orders/models/pending_order_list_model/order.dart';
import 'package:o_driver/utils/global_functions.dart';
import 'package:o_driver/widgets/misc_widgets.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.gray, width: 2),
          borderRadius: BorderRadius.circular(2.h)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order.customerName ?? 'Unknown',
                      style: AppTextDecor.osBold14black.copyWith(
                        color: AppColors.navyText,
                      ),
                    ),
                    Text(
                      order.isTypePickup == true ? 'P' : 'D',
                      style: AppTextDecor.osBold14black.copyWith(
                          fontStyle: FontStyle.italic,
                          color: AppColors.cardDeepGreen),
                    ),
                    Text(
                      order.orderCode ?? '',
                      style: AppTextDecor.osBold14black.copyWith(
                        color: AppColors.navyText,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomSeprator(
                    color: AppColors.navyText.withOpacity(0.2),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Text(
                        AppGFunctions.processAdAddess2(order.address),
                        textAlign: TextAlign.center,
                        style: AppTextDecor.osBold14black.copyWith(
                            color: AppColors.navyText,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: AppGFunctions.statusCard(
                            order.pickAndDelivaryStatus ?? ''),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomSeprator(
                    color: AppColors.navyText.withOpacity(0.2),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.schedule, color: AppColors.navyText),
                        AppSpacerW(5.w),
                        Text(
                          order.isTypePickup == true
                              ? order.pickHour ?? ''
                              : order.deliveryHour ?? '',
                          style: AppTextDecor.osBold14black.copyWith(
                            color: AppColors.navyText,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Details >',
                      style: AppTextDecor.osBold14black.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.cardDeepGreen,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
