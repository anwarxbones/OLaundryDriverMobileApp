import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laundry_customer/constants/app_colors.dart';
import 'package:laundry_customer/constants/app_text_decor.dart';
import 'package:laundry_customer/constants/hive_contants.dart';
import 'package:laundry_customer/misc/global_functions.dart';
import 'package:laundry_customer/widgets/buttons/cart_item_inc_dec_button.dart';
import 'package:laundry_customer/widgets/misc_widgets.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  void initState() {
    super.initState();
  }

  final Box appSettingsBox = Hive.box(AppHSC.appSettingsBox);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      color: AppColors.white,
      height: 90.h,
      child: Row(
        children: [
          _buildImageWidget(),
          AppSpacerW(8.w),
          _buildProductInfoColumn(),
          const Spacer(),
          _buildCartFunctionWidget(),
        ],
      ),
    );
  }

  Widget _buildImageWidget() {
    return Container(
      width: 56.w,
      color: Colors.red,
    );
  }

  Widget _buildProductInfoColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Iron Service',
          style: AppTextDecor.osRegular12black
              .copyWith(color: AppColors.navyText, fontSize: 10.sp),
        ),
        Text(
          'Shirt',
          style: AppTextDecor.osRegular14black
              .copyWith(fontWeight: FontWeight.w700),
        ),
        Row(
          children: [
            Text(
              '${AppGFunctions.getCurrency()}100',
              style: AppTextDecor.osRegular12navy
                  .copyWith(decoration: TextDecoration.lineThrough),
            ),
            Text(
              ' 0.00',
              style: AppTextDecor.osRegular14black.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCartFunctionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: AppColors.red,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Center(
            child: Text(
              '60% OFF',
              style: AppTextDecor.osRegular14white.copyWith(
                fontSize: 10.sp,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const Spacer(),
        // IncDecButton(ontap: () {}, icon: Icons.add),
        IncDecButtonWithValueV2(value: 1, onInc: () {}, onDec: () {}),
      ],
    );
  }
}
