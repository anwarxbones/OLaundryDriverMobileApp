import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:laundry_customer/constants/app_box_decoration.dart';
import 'package:laundry_customer/constants/app_colors.dart';
import 'package:laundry_customer/constants/app_text_decor.dart';
import 'package:laundry_customer/constants/hive_contants.dart';
import 'package:laundry_customer/generated/l10n.dart';
import 'package:laundry_customer/misc/global_functions.dart';
import 'package:laundry_customer/models/order_model.dart/order_model.dart';
import 'package:laundry_customer/utils/context_less_nav.dart';
import 'package:laundry_customer/widgets/dashed_line.dart';
import 'package:laundry_customer/widgets/global_functions.dart';
import 'package:laundry_customer/widgets/misc_widgets.dart';
import 'package:laundry_customer/widgets/nav_bar.dart';
import 'package:laundry_customer/widgets/screen_wrapper.dart';

class OrderDetails extends ConsumerStatefulWidget {
  const OrderDetails({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  ConsumerState<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends ConsumerState<OrderDetails> {
  bool isChatAble = false;

  @override
  Widget build(BuildContext context) {
    final Box settingsBox = Hive.box(AppHSC.appSettingsBox);

    return ScreenWrapper(
      padding: EdgeInsets.zero,
      child: Container(
        height: 812.h,
        width: 375.w,
        color: AppColors.grayBG,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              _buildOrderDetails(settingsBox, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.primary,
          width: 375.w,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              children: [
                AppSpacerH(44.h),
                AppNavbar(
                  backgroundColor: AppColors.primary,
                  titleColor: AppColors.white,
                  title: S.of(context).ordrdtls,
                  onBack: () => context.nav.pop(),
                ),
                AppSpacerH(12.h),
              ],
            ),
          ),
        ),
        // Add conditional chat button here if needed
      ],
    );
  }

  Widget _buildOrderDetails(Box settingsBox, BuildContext context) {
    return Container(
      height: 724.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ListView(
        padding: EdgeInsets.only(bottom: 40.h),
        children: [
          AppSpacerH(10.h),
          _buildItemDetails(),
          AppSpacerH(15.h),
          _buildShippingAddress(context),
          AppSpacerH(15.h),
          _buildOrderSummary(settingsBox, context),
          AppSpacerH(8.h),
        ],
      ),
    );
  }

  Widget _buildItemDetails() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: AppBoxDecorations.pageCommonCard,
      child: ExpandablePanel(
        header: Text(
          '${S.of(context).itms} (${widget.order.products.length})',
          style: AppTextDecor.osBold14black,
        ),
        collapsed: const SizedBox(),
        expanded: Column(
          children: widget.order.products.map((product) {
            return OrderDetailsTile(
              product: product,
              qty: product.quantity,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildShippingAddress(BuildContext context) {
    final customer = widget.order.customer;
    final address = widget.order.address;

    return Container(
      width: 335.w,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: AppBoxDecorations.pageCommonCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S.of(context).shpngadrs, style: AppTextDecor.osBold14black),
          Row(
            children: [
              Icon(Icons.location_pin, size: 40.w),
              AppSpacerW(10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer.name ?? '',
                    style: AppTextDecor.osRegular14black,
                  ),
                  if (customer.mobile != null)
                    Text(
                      customer.mobile ?? '',
                      style: AppTextDecor.osRegular14black,
                    ),
                  Text(
                    address.addressLine ?? '',
                    style: AppTextDecor.osRegular14black,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.6,
                    child: Text(
                      "${address.addressName}, ${address.addressLine ?? ''} - ${address.zipCode}",
                      style: AppTextDecor.osRegular14black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(Box settingsBox, BuildContext context) {
    final order = widget.order;

    return Container(
      width: 335.w,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: AppBoxDecorations.pageCommonCard,
      child: Column(
        children: [
          Table(
            children: [
              AppGFunctions.tableTitleTextRow(
                title: S.of(context).ordrid,
                data: '#${order.orderCode}',
              ),
              AppGFunctions.tableTextRow(
                title: S.of(context).pickupat,
                data: '${order.pickDate} - ${order.pickHour}',
              ),
              AppGFunctions.tableTextRow(
                title: S.of(context).dlvryat,
                data: '${order.deliveryDate} - ${order.deliveryHour}',
              ),
              AppGFunctions.tableTextRow(
                title: S.of(context).ordrstats,
                data: getLng(
                  en: order.orderStatus,
                  changeLang: order.orderStatus,
                ),
              ),
              AppGFunctions.tableTextRow(
                title: S.of(context).pymntstats,
                data: getLng(
                  en: order.paymentStatus,
                  changeLang: order.paymentStatus,
                ),
              ),
              AppGFunctions.tableTextRow(
                title: S.of(context).sbttl,
                data:
                    '${settingsBox.get('currency') ?? '\$'}${AppGFunctions.convertToFixedTwo(order.amount)}',
              ),
              AppGFunctions.tableTextRow(
                title: S.of(context).dlvrychrg,
                data:
                    '${settingsBox.get('currency') ?? '\$'}${AppGFunctions.convertToFixedTwo(order.deliveryCharge)}',
              ),
              AppGFunctions.tableDiscountTextRow(
                title: S.of(context).dscnt,
                data:
                    '${settingsBox.get('currency') ?? '\$'}${AppGFunctions.convertToFixedTwo(order.discount)}',
              ),
            ],
          ),
          const MySeparator(),
          AppSpacerH(8.5.h),
          _buildTotalAmount(settingsBox),
        ],
      ),
    );
  }

  Widget _buildTotalAmount(Box settingsBox) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(S.of(context).ttl, style: AppTextDecor.osBold14black),
        Text(
          '${settingsBox.get('currency') ?? '\$'}${AppGFunctions.convertToFixedTwo(widget.order.totalAmount)}',
          style: AppTextDecor.osBold14black,
        ),
      ],
    );
  }
}

class OrderDetailsTile extends StatelessWidget {
  const OrderDetailsTile({
    super.key,
    required this.product,
    required this.qty,
    this.subprice,
  });

  final Product product;
  final int qty;
  final int? subprice;

  @override
  Widget build(BuildContext context) {
    final Box settingsBox = Hive.box(AppHSC.appSettingsBox);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: SizedBox(
        width: 297.w,
        child: Row(
          children: [
            Image.network(
              product.imagePath,
              height: 40.h,
              width: 42.w,
            ), // Uncomment if needed
            SizedBox(width: 5.w),
            Expanded(
              child: Column(
                children: [
                  _buildProductNameAndPrice(settingsBox),
                  _buildProductCategoryAndQty(settingsBox),
                  const Divider(),
                  _buildSubProductsWidget(settingsBox),
                  if (product.additionalNotes != null) _buildNoteWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductNameAndPrice(Box settingsBox) {
    final price = (product.price + (subprice ?? 0)) * qty;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(product.productName, style: AppTextDecor.osBold12black),
        ),
        Text(
          '${settingsBox.get('currency') ?? '\$'}${(AppGFunctions.convertToFixedTwo(price) + getSubTotalOfSubProducts(product.subProducts)).toStringAsFixed(2)}',
          style: AppTextDecor.osBold12gold,
        ),
      ],
    );
  }

  Widget _buildProductCategoryAndQty(Box settingsBox) {
    final unitPrice = product.price;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            product.categoryName,
            style: AppTextDecor.osRegular12navy,
            maxLines: 3,
          ),
        ),
        Text(
          '${qty}x${settingsBox.get('currency') ?? '\$'}${AppGFunctions.convertToFixedTwo(unitPrice)}',
          style: AppTextDecor.osRegular12black,
        ),
      ],
    );
  }

  Widget _buildSubProductsWidget(Box settingsBox) {
    if (product.subProducts.isEmpty) {
      return const SizedBox();
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 10.0,
        children: List.generate(product.subProducts.length, (index) {
          final subProduct = product.subProducts[index];
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 2,
                backgroundColor: AppColors.gray,
              ),
              const SizedBox(
                width: 10,
              ),
              Text('${subProduct.name}:', style: AppTextDecor.osBold12black),
              const SizedBox(
                width: 5,
              ),
              Text(
                '  ${product.quantity} x ${settingsBox.get('currency') ?? '\$'}${subProduct.price}',
                style: AppTextDecor.osRegular12black,
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildNoteWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: AppColors.grayBG,
      ),
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
      child: Text(
        product.additionalNotes ?? '',
      ),
    );
  }

  double getSubTotalOfSubProducts(List<SubProduct> subProducts) {
    double subTotal = 0;
    for (final subProduct in subProducts) {
      subTotal += subProduct.price;
    }
    return subTotal;
  }
}
