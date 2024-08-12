import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laundry_customer/constants/app_colors.dart';
import 'package:laundry_customer/constants/app_text_decor.dart';
import 'package:laundry_customer/constants/hive_contants.dart';
import 'package:laundry_customer/misc/global_functions.dart';
import 'package:laundry_customer/models/cart/cart_model.dart';
import 'package:laundry_customer/models/product/product_mode.dart';
import 'package:laundry_customer/providers/product_provider.dart';
import 'package:laundry_customer/screens/homePage/widgets/add_ons_bottom_sheet.dart';
import 'package:laundry_customer/screens/homePage/widgets/inc_dec_button.dart';
import 'package:laundry_customer/services/local_service.dart';
import 'package:laundry_customer/widgets/buttons/cart_item_inc_dec_button.dart';
import 'package:laundry_customer/widgets/misc_widgets.dart';

class ProductCartCard extends ConsumerStatefulWidget {
  final CartModel cartModel;
  const ProductCartCard({
    super.key,
    required this.cartModel,
  });

  @override
  ConsumerState<ProductCartCard> createState() => _ProductCartCardState();
}

class _ProductCartCardState extends ConsumerState<ProductCartCard> {
  @override
  void initState() {
    super.initState();
  }

  final Box appSettingsBox = Hive.box(AppHSC.appSettingsBox);
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: ref.watch(loadingProvider),
      child: GestureDetector(
        onTap: () {
          ref.read(loadingProvider.notifier).state = true;
          ref
              .read(productDetailsProvider.notifier)
              .getProductDetails(id: widget.cartModel.productId)
              .then((product) {
            ref.refresh(loadingProvider.notifier).state;
            if (product != null) {
              _showAddOnsBottomSheet(
                cartModel: widget.cartModel,
                productModel: product,
              );
            }
          });
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
                inCart: true,
                cartCount: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageWidget() {
    return Container(
      width: 56.w,
      decoration: const BoxDecoration(),
      child: CachedNetworkImage(
        imageUrl: widget.cartModel.image,
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
          widget.cartModel.categoryName,
          style: AppTextDecor.osRegular12black
              .copyWith(color: AppColors.navyText, fontSize: 10.sp),
        ),
        Text(
          widget.cartModel.name,
          style: AppTextDecor.osRegular14black
              .copyWith(fontWeight: FontWeight.w700),
        ),
        Row(
          children: [
            if (widget.cartModel.discountPercentage != null)
              Text(
                '${AppGFunctions.getCurrency()}${widget.cartModel.discountPrice} ',
                style: AppTextDecor.osRegular12navy
                    .copyWith(decoration: TextDecoration.lineThrough),
              ),
            Text(
              '${AppGFunctions.getCurrency()}${widget.cartModel.price}',
              style: AppTextDecor.osRegular14black.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            Text(
              ' /${AppGFunctions.soldBy(widget.cartModel.soldBy)}',
              style: AppTextDecor.osRegular14Navy,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCartFunctionWidget({
    required bool inCart,
    required int? cartCount,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (widget.cartModel.discountPercentage != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppColors.red,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Center(
              child: Text(
                '${widget.cartModel.discountPercentage}% OFF',
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
          IncDecButton(ontap: () => null, icon: Icons.add),
        ] else ...[
          IncDecButtonWithValueV2(
            value: widget.cartModel.quantity,
            onInc: () => LocalService().incrementQuantity(
              productId: widget.cartModel.productId,
              isPerPiece: AppGFunctions.isPerPiece(widget.cartModel.soldBy),
            ),
            onDec: () => LocalService().decrementQuantity(
              productId: widget.cartModel.productId,
              isPerPiece: AppGFunctions.isPerPiece(widget.cartModel.soldBy),
            ),
            isPiece: AppGFunctions.isPerPiece(widget.cartModel.soldBy),
          ),
        ],
      ],
    );
  }

  Future _showAddOnsBottomSheet({
    required CartModel? cartModel,
    required ProductModel productModel,
  }) {
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
        product: productModel,
        cartModel: cartModel,
        isUpdate: true,
      ),
    );
  }
}

final loadingProvider = StateProvider<bool>((ref) => false);
