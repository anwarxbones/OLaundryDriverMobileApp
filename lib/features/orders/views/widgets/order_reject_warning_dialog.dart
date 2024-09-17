import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o_driver/constants/app_colors.dart';
import 'package:o_driver/constants/app_durations.dart';
import 'package:o_driver/constants/app_text_decor.dart';
import 'package:o_driver/features/orders/logic/order_provider.dart';
import 'package:o_driver/utils/context_less_nav.dart';
import 'package:o_driver/utils/routes.dart';
import 'package:o_driver/widgets/buttons/full_width_button.dart';
import 'package:o_driver/widgets/misc_widgets.dart';

class OrderRejectWarningDialog extends ConsumerWidget {
  const OrderRejectWarningDialog(this.orderId, {super.key});
  final int? orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure you want to reject this order?',
              style: AppTextDecor.osBold18black,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ref.watch(acceptOrderProvider).map(
                  initial: (_) => Row(
                    children: [
                      Expanded(
                        child: AppTextButton(
                          onTap: () {
                            ref.watch(acceptOrderProvider.notifier).acceptOrder(
                                  orderId: orderId!,
                                  isAccepted: false,
                                );
                          },
                          buttonColor: AppColors.red,
                          title: 'Yes',
                        ),
                      ),
                      AppSpacerW(10.w),
                      Expanded(
                        child: AppTextButton(
                          onTap: () => context.nav.pop(),
                          title: 'No',
                        ),
                      ),
                    ],
                  ),
                  error: (_) {
                    Future.delayed(AppDurConst.buildDuration).then((_) {
                      ref.refresh(acceptOrderProvider);
                    });
                    return const SizedBox();
                  },
                  loaded: (value) =>
                      _handleDialogSuccess(context, ref, value.data),
                  loading: (_) => const LoadingWidget(),
                )
          ],
        ),
      ),
    );
  }

  Widget _handleDialogSuccess(
      BuildContext context, WidgetRef ref, String message) {
    Future.delayed(AppDurConst.buildDuration).then((_) {
      ref.refresh(totalOrderListProvider);
      ref.refresh(acceptOrderProvider);
      context.nav.popAndPushNamed(Routes.homePage);
    });
    return MessageTextWidget(msg: message);
  }
}
