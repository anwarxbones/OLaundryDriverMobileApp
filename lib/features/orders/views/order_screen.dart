import 'package:dry_cleaners_driver/constants/app_colors.dart';
import 'package:dry_cleaners_driver/constants/app_text_decor.dart';
import 'package:dry_cleaners_driver/constants/input_field_decorations.dart';
import 'package:dry_cleaners_driver/features/orders/models/pending_order_list_model/order.dart';
import 'package:dry_cleaners_driver/features/orders/views/widgets/slider_widget.dart';
import 'package:dry_cleaners_driver/utils/global_functions.dart';
import 'package:dry_cleaners_driver/widgets/misc_widgets.dart';
import 'package:dry_cleaners_driver/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderScreen extends ConsumerWidget {
  OrderScreen({Key? key, required this.order}) : super(key: key);
  final Order order;
  final TextEditingController _controller =
      TextEditingController(text: 'This is an instruction for delivery');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenWrapper(
      child: Column(
        children: [
          AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            leading: const BackButton(
              color: AppColors.navyText,
            ),
            title: Text(
              'Order Details',
              style: AppTextDecor.osBold14black,
            ),
          ),
          AppSpacerH(16.h),
          Container(
            color: AppColors.white,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.gray, width: 2),
                  borderRadius: BorderRadius.circular(2.h)),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
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
                            const Icon(Icons.delivery_dining),
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
                            const Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  backgroundColor: AppColors.cardDeepGreen,
                                  child: Center(
                                    child: Icon(
                                      Icons.directions,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
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
                                const Icon(Icons.schedule,
                                    color: AppColors.navyText),
                                AppSpacerW(5.w),
                                Text(
                                  AppGFunctions.pickUpOrDeliveryHour(
                                    hour: order.isTypePickup == true
                                        ? order.pickHour
                                        : order.deliveryHour,
                                  ),
                                  style: AppTextDecor.osBold14black.copyWith(
                                    color: AppColors.navyText,
                                  ),
                                ),
                              ],
                            ),
                            AppGFunctions.statusCard(order.orderStatus ?? '')
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomSeprator(
                            color: AppColors.navyText.withOpacity(0.2),
                          ),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.cardDeepGreen,
                              child: Center(
                                child: Icon(
                                  Icons.phone,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: AppColors.cardDeepGreen,
                              child: Center(
                                child: Icon(
                                  Icons.email_outlined,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        AppSpacerH(16.h),
                        FormBuilderTextField(
                          readOnly: true,
                          autofocus: true,
                          name: 'instructions',
                          minLines: 4,
                          maxLines: 4,
                          controller: _controller,
                          decoration:
                              AppInputDecor.loginPageInputDecor.copyWith(
                            hintText: '',
                            enabled: true,
                          ),
                        ),
                        AppSpacerH(16.h),
                        SlideToStartWidget(onSlideCompleted: () {
                          print('completed');
                        })
                        // Container(
                        //   padding: EdgeInsets.symmetric(
                        //     horizontal: 8.w,
                        //     vertical: 6.h,
                        //   ),
                        //   width: double.infinity,
                        //   decoration: BoxDecoration(
                        //     border: Border.all(color: AppColors.gray, width: 2),
                        //     borderRadius: BorderRadius.circular(2.h),
                        //   ),
                        //   child: const Text('This is an instructions.'),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
