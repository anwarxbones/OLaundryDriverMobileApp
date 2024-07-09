import 'package:dry_cleaners_driver/constants/app_box_decoration.dart';
import 'package:dry_cleaners_driver/constants/app_colors.dart';
import 'package:dry_cleaners_driver/constants/app_durations.dart';
import 'package:dry_cleaners_driver/constants/app_text_decor.dart';
import 'package:dry_cleaners_driver/constants/hive_contants.dart';
import 'package:dry_cleaners_driver/features/core/views/widgets/order_tile_text_row.dart';
import 'package:dry_cleaners_driver/features/orders/logic/order_provider.dart';
import 'package:dry_cleaners_driver/features/orders/models/pending_order_list_model/order.dart';
import 'package:dry_cleaners_driver/features/orders/models/pending_order_list_model/product.dart';
import 'package:dry_cleaners_driver/utils/global_functions.dart';
import 'package:dry_cleaners_driver/widgets/buttons/full_width_button.dart';
import 'package:dry_cleaners_driver/widgets/misc_widgets.dart';
import 'package:dry_cleaners_driver/widgets/nav_bar.dart';
import 'package:dry_cleaners_driver/widgets/screen_wrapper.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({Key? key, required this.order}) : super(key: key);
  final Order order;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  late Order _order;
  int qty = 0;
  @override
  void initState() {
    _order = widget.order;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderStatus = AppGFunctions.getUserOrderType(_order.orderStatus);
    bool pick = orderStatus == OrderType.pickUp;

    qty = 0;
    for (var element in _order.quantity!.quantity) {
      qty += element.quantity;
    }
    final List<OrderDetailsTile> orderWidgets = [];
    for (var i = 0; i < _order.products!.length; i++) {
      orderWidgets.add(
        OrderDetailsTile(
          product: _order.products![i],
          qty: _order.quantity!.quantity[i].quantity,
        ),
      );
    }

    return ScreenWrapper(
        color: AppColors.white,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 20.w, right: 20.w, bottom: 12.h),
                  decoration: AppBoxDecorations.topBar2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSpacerH(44.h),
                      AppNavbar(
                          showBack: true,
                          title: Center(
                            child: OrderTileTextRow(
                              center: true,
                              title: 'Order ID:',
                              content: '#IM${_order.id}',
                            ),
                          )),
                      AppSpacerH(12.h),
                      Row(
                        children: [
                          SizedBox(
                            height: 60.h,
                            width: 60.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.w),
                              child: Image.network(
                                _order.customer!.user!.profilePhotoPath!,
                                height: 60.h,
                                width: 60.w,
                              ),
                            ),
                          ),
                          AppSpacerW(12.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _order.customer?.user?.name ?? '',
                                style: AppTextDecor.osBold18black,
                              ),
                              Text(
                                _order.customer?.user?.mobile ?? '',
                                style: AppTextDecor.osRegular14black,
                              )
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                          GestureDetector(
                            onTap: () async {
                              await launchUrlString(
                                  'tel:${_order.customer?.user?.mobile}');
                            },
                            child: SvgPicture.asset(
                              'assets/svgs/icon_call.svg',
                              height: 36.h,
                              width: 36.w,
                            ),
                          )
                        ],
                      ),
                      AppSpacerH(16.h),
                      Row(
                        children: [
                          ColumnText(
                              title: 'Pick-up Date:',
                              content: _order.pickDate ?? ''),
                          const Expanded(child: SizedBox()),
                          ColumnText(
                              title: 'Time:', content: _order.pickHour ?? ''),
                        ],
                      ),
                      AppSpacerH(12.h),
                      ColumnText(
                          title: 'Address:',
                          content: AppGFunctions.processAdAddess(_order)
                          //'House #12, Flat #D2, Block #C, Road # 3, Mohammadpur, Dhaka'
                          ),
                      AppSpacerH(8.h),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: ListView(
                      children: [
                        AppSpacerH(16.h),
                        Container(
                          decoration: AppBoxDecorations.borderDecoration,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          child: ExpandablePanel(
                            header: Text(
                              'Total quantity (${qty.toString()})',
                              style: AppTextDecor.osBold14black,
                            ),
                            collapsed: const SizedBox(),
                            expanded: Column(
                              children: orderWidgets,
                            ),
                          ),
                        ),
                        AppSpacerH(10.h),
                        Container(
                          decoration: AppBoxDecorations.grayContainer,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Additional Instruction:',
                                style: AppTextDecor.osRegular12Navy,
                              ),
                              AppSpacerH(15.h),
                              Text(
                                _order.address?.deliveryNote ?? '', //FIXME
                                style: AppTextDecor.osRegular14black,
                              )
                            ],
                          ),
                        ),
                        AppSpacerH(100.h)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (orderStatus == OrderType.pickUp ||
                orderStatus == OrderType.delivery)
              Positioned(
                  bottom: 0,
                  child: Container(
                    width: 375.w,
                    color: AppColors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Center(
                      child: ref.watch(orderUpdateProvider).map(
                          initial: (_) => AppTextButton(
                              onTap: () {
                                ref
                                    .watch(orderUpdateProvider.notifier)
                                    .updateOrder(
                                        id: _order.id.toString(),
                                        status: pick
                                            ? 'picked_order'
                                            : 'delivered');
                              },
                              buttonColor: pick
                                  ? AppColors.goldenButton
                                  : AppColors.cardGreen,
                              title:
                                  pick ? 'I picked it up' : 'I delivered it'),
                          loading: (_) => const LoadingWidget(),
                          loaded: (_) {
                            setState(() {
                              _order = _.data.data!.order!;
                            });
                            Future.delayed(AppDurConst.buildDuration)
                                .then((value) {
                              ref.refresh(orderUpdateProvider);
                              ref.refresh(totalOrderListProvider);
                              ref.refresh(todaysJobListProvider);

                              ref.refresh(todaysPendingOrderListProvider);
                              ref.refresh(thisWeekDeliveryListProvider);
                            });
                            return const MessageTextWidget(msg: 'Succes');
                          },
                          error: (_) {
                            Future.delayed(AppDurConst.buildDuration)
                                .then((value) {
                              ref.refresh(orderUpdateProvider);
                            });
                            return ErrorTextWidget(error: _.error);
                          }),
                    ),
                  ))
          ],
        ));
  }
}

class ColumnText extends StatelessWidget {
  const ColumnText({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextDecor.osRegular12Navy,
        ),
        Text(
          content,
          style: AppTextDecor.osBold12black,
        ),
      ],
    );
  }
}

class OrderDetailsTile extends StatelessWidget {
  const OrderDetailsTile({
    Key? key,
    required this.product,
    required this.qty,
  }) : super(key: key);
  final Product product;
  final int qty;

  @override
  Widget build(BuildContext context) {
    final Box settingsBox = Hive.box(AppHSC.appSettingsBox);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: SizedBox(
        // height: 40.h,
        width: 297.w,
        child: Row(
          children: [
            Image.network(
              product.imagePath!,
              height: 40.h,
              width: 42.w,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name!,
                          style: AppTextDecor.osBold12black,
                        ),
                      ),
                      Text(
                        '$qty',
                        style: AppTextDecor.osBold12gold,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.service?.name ?? '',
                          style: AppTextDecor.osRegular12Navy,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
