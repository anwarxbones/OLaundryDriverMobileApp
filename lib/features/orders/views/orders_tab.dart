import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:o_driver/constants/app_colors.dart';
import 'package:o_driver/constants/app_durations.dart';
import 'package:o_driver/constants/app_text_decor.dart';
import 'package:o_driver/features/core/logic/misc_provider.dart';
import 'package:o_driver/features/core/views/widgets/order_tile.dart';
import 'package:o_driver/features/orders/logic/order_provider.dart';
import 'package:o_driver/utils/context_less_nav.dart';
import 'package:o_driver/utils/routes.dart';
import 'package:o_driver/widgets/buttons/full_width_button.dart';
import 'package:o_driver/widgets/misc_widgets.dart';
import 'package:o_driver/widgets/nav_bar_home.dart';

class OrdersTab extends ConsumerWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(totalOrderListProvider);
    return Column(
      children: [
        _buildTopSection(context, ref),
        AppSpacerH(8.h),
        _buildOrderList(context, ref),
      ],
    );
  }

  Widget _buildTopSection(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacerH(44.h),
          _buildNavbarHome(context, ref),
          AppSpacerH(20.h),
          CustomSeprator(),
          AppSpacerH(10.h),
          _buildTabSelector(ref),
        ],
      ),
    );
  }

  Widget _buildNavbarHome(BuildContext context, WidgetRef ref) {
    return AppNavbarHome(
      showCalendar: true,
      selectedDate: ref.watch(selectedDateProvider),
      onPressedCalendar: () => _selectDate(context, ref),
      onPressed: () => ref.refresh(totalOrderListProvider),
    );
  }

  Widget _buildTabSelector(WidgetRef ref) {
    return SizedBox(
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
              return _buildTabItem(ref, index);
            },
          ),
        );
      }),
    );
  }

  Widget _buildTabItem(WidgetRef ref, int index) {
    final isSelected = ref.read(orderTabIndexProvider) == index;
    final tabName = _getTabName(index);

    return Padding(
      padding: EdgeInsets.all(5.w),
      child: GestureDetector(
        onTap: () => _onTabSelected(ref, index),
        child: Container(
          padding: EdgeInsets.only(bottom: 6.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.goldenButton : Colors.transparent,
                width: 3.h,
              ),
            ),
          ),
          child: Text(tabName),
        ),
      ),
    );
  }

  String _getTabName(int index) {
    switch (index) {
      case 0:
        return 'Pending';
      case 1:
        return 'Accepted';
      case 2:
        return 'History';
      default:
        return '';
    }
  }

  void _onTabSelected(WidgetRef ref, int index) {
    final tabStatus = ['pending', 'accepted', 'history'][index];
    ref.watch(appOrderTabStatusProvider.notifier).state = tabStatus;
    ref.read(orderTabIndexProvider.notifier).state = index;
  }

  Widget _buildOrderList(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        color: AppColors.white,
        child: ref.watch(totalOrderListProvider).map(
              initial: (_) => const LoadingWidget(),
              loading: (_) => const LoadingWidget(),
              loaded: (_) => _buildOrderItemsList(context, ref, _),
              error: (_) => ErrorTextWidget(error: _.error),
            ),
      ),
    );
  }

  Widget _buildOrderItemsList(BuildContext context, WidgetRef ref, var _) {
    if (_.data.data!.orders!.isNotEmpty) {
      return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: _.data.data!.orders!.length,
        itemBuilder: (context, index) {
          return _buildOrderItem(context, ref, _, index);
        },
      );
    } else {
      return const MessageTextWidget(msg: 'No Orders Available');
    }
  }

  Widget _buildOrderItem(
      BuildContext context, WidgetRef ref, var _, int index) {
    final order = _.data.data!.orders![index];
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: GestureDetector(
        onTap: () => _onOrderItemTap(context, ref, order),
        child: OrderTile(order: order),
      ),
    );
  }

  void _onOrderItemTap(BuildContext context, WidgetRef ref, var order) {
    final int orderId = order.id!;
    if (ref.read(orderTabIndexProvider) == 0) {
      _orderAcceptDialog(context: context, orderId: orderId);
    } else {
      context.nav.pushNamed(Routes.orderScreen, arguments: order);
    }
  }

  Future<void> _selectDate(BuildContext context, WidgetRef ref) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: ref.watch(selectedDateProvider),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != ref.watch(selectedDateProvider)) {
      ref.watch(selectedDateProvider.notifier).update((state) => picked);
      ref.refresh(totalOrderListProvider);
      DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  Future<dynamic> _orderAcceptDialog({
    required BuildContext context,
    required int orderId,
  }) {
    return showDialog(
      context: context,
      builder: (context) => Center(
        child: Consumer(
          builder: (context, ref, child) {
            ref.watch(acceptOrderProvider);
            return _buildOrderDialogContent(ref, orderId);
          },
        ),
      ),
    );
  }

  Widget _buildOrderDialogContent(WidgetRef ref, int orderId) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Container(
        width: 375.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.h),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Do you Want to Accept This Order',
                style: AppTextDecor.osBold18black,
              ),
              AppSpacerH(20.h),
              _buildDialogActions(ref, orderId),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialogActions(WidgetRef ref, int orderId) {
    return ref.watch(acceptOrderProvider).map(
          initial: (_) => Row(
            children: [
              Expanded(
                child: AppTextButton(
                  onTap: () => _onRejectOrder(ref),
                  buttonColor: AppColors.red,
                  title: 'Reject',
                ),
              ),
              AppSpacerW(10.w),
              Expanded(
                child: AppTextButton(
                  onTap: () => _onAcceptOrder(ref, orderId),
                  title: 'Accept',
                ),
              ),
            ],
          ),
          error: (_) => _handleDialogError(ref, _.error),
          loaded: (_) => _handleDialogSuccess(ContextLess.context, ref, _.data),
          loading: (_) => const LoadingWidget(),
        );
  }

  void _onRejectOrder(WidgetRef ref) {
    EasyLoading.showSuccess(
      "We need to confirm that this feature will be implemented or not",
    );
  }

  void _onAcceptOrder(WidgetRef ref, int orderId) {
    ref.watch(acceptOrderProvider.notifier).acceptOrder(
          orderId: orderId,
          isAccepted: true,
        );
    ref.refresh(totalOrderListProvider);
    ref.refresh(todaysJobListProvider);
  }

  Widget _handleDialogError(WidgetRef ref, String error) {
    Future.delayed(AppDurConst.buildDuration).then((_) {
      ref.refresh(acceptOrderProvider);
    });
    return ErrorTextWidget(error: error);
  }

  Widget _handleDialogSuccess(
      BuildContext context, WidgetRef ref, String message) {
    Future.delayed(AppDurConst.buildDuration).then((_) {
      ref.refresh(acceptOrderProvider);
      ref.refresh(totalOrderListProvider);
      ref.refresh(todaysJobListProvider);
      context.nav.pop();
      ref.refresh(todaysPendingOrderListProvider);
      ref.refresh(thisWeekDeliveryListProvider);
    });
    return MessageTextWidget(msg: message);
  }
}

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
