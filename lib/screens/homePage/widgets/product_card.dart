import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laundry_customer/constants/app_colors.dart';
import 'package:laundry_customer/constants/app_text_decor.dart';
import 'package:laundry_customer/constants/hive_contants.dart';
import 'package:laundry_customer/misc/global_functions.dart';
import 'package:laundry_customer/models/cart/cart_model.dart';
import 'package:laundry_customer/models/product/product_mode.dart';
import 'package:laundry_customer/screens/homePage/widgets/add_ons_bottom_sheet.dart';
import 'package:laundry_customer/screens/homePage/widgets/inc_dec_button.dart';
import 'package:laundry_customer/services/local_service.dart';
import 'package:laundry_customer/widgets/buttons/cart_item_inc_dec_button.dart';
import 'package:laundry_customer/widgets/misc_widgets.dart';

class ProductCard extends StatefulWidget {
  final ProductModel productModel;
  const ProductCard({
    super.key,
    required this.productModel,
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
    return ValueListenableBuilder(
      valueListenable: Hive.box<CartModel>(AppHSC.cartBox).listenable(),
      builder: (context, Box<CartModel> box, _) {
        final CartModel? cartModel = box.get(widget.productModel.productId);
        final bool inCart = cartModel != null;
        return GestureDetector(
          onTap: () {
            if (inCart) {
              _showAddOnsBottomSheet(cartModel: cartModel);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            color: AppColors.white,
            height: 90.h,
            child: Row(
              children: [
                _buildImageWidget(),
                AppSpacerW(8.w),
                _buildProductInfoColumn(),
                const Spacer(),
                _buildCartFunctionWidget(
                  inCart: inCart,
                  cartCount: cartModel?.quantity,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageWidget() {
    return Container(
      width: 56.w,
      decoration: const BoxDecoration(),
      child: CachedNetworkImage(
        imageUrl: widget.productModel.image,
        progressIndicatorBuilder: (context, url, progress) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  Widget _buildProductInfoColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.productModel.categoryName,
          style: AppTextDecor.osRegular12black
              .copyWith(color: AppColors.navyText, fontSize: 10.sp),
        ),
        Text(
          widget.productModel.productName,
          style: AppTextDecor.osRegular14black
              .copyWith(fontWeight: FontWeight.w700),
        ),
        Row(
          children: [
            if (widget.productModel.discountPercentage != null)
              Text(
                '${AppGFunctions.getCurrency()}${widget.productModel.discountPrice} ',
                style: AppTextDecor.osRegular12navy
                    .copyWith(decoration: TextDecoration.lineThrough),
              ),
            Text(
              '${AppGFunctions.getCurrency()}${widget.productModel.previousPrice}',
              style: AppTextDecor.osRegular14black.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            Text(
              ' /${AppGFunctions.soldBy(widget.productModel.soldBy)}',
              style: AppTextDecor.osRegular14Navy,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCartFunctionWidget({
    required bool inCart,
    required double? cartCount,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (widget.productModel.discountPercentage != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppColors.red,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Center(
              child: Text(
                '${widget.productModel.discountPercentage}% OFF',
                style: AppTextDecor.osRegular14white.copyWith(
                  fontSize: 10.sp,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        const Spacer(),
        if (!inCart) ...[
          IncDecButton(
            ontap: () => _showAddOnsBottomSheet(cartModel: null),
            icon: Icons.add,
          ),
        ] else ...[
          IncDecButtonWithValueV2(
            value: cartCount!,
            onInc: () => LocalService().incrementQuantity(
              productId: widget.productModel.productId,
              isPerPiece: AppGFunctions.isPerPiece(widget.productModel.soldBy),
            ),
            onDec: () => LocalService().decrementQuantity(
              productId: widget.productModel.productId,
              isPerPiece: AppGFunctions.isPerPiece(widget.productModel.soldBy),
            ),
            isPiece: AppGFunctions.isPerPiece(widget.productModel.soldBy),
          ),
        ],
      ],
    );
  }

  Future _showAddOnsBottomSheet({required CartModel? cartModel}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      backgroundColor: AppColors.white,
      builder: (context) => AddOnsBottomSheet(
        product: widget.productModel,
        cartModel: cartModel,
      ),
    );
  }
}
