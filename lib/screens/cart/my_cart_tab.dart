import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laundry_customer/constants/app_box_decoration.dart';
import 'package:laundry_customer/constants/app_colors.dart';
import 'package:laundry_customer/constants/app_text_decor.dart';
import 'package:laundry_customer/constants/hive_contants.dart';
import 'package:laundry_customer/generated/l10n.dart';
import 'package:laundry_customer/misc/global_functions.dart';
import 'package:laundry_customer/models/cart/cart_model.dart';
import 'package:laundry_customer/providers/settings_provider.dart';
import 'package:laundry_customer/screens/cart/widgets/product_cart_card.dart';
import 'package:laundry_customer/services/local_service.dart';
import 'package:laundry_customer/utils/context_less_nav.dart';
import 'package:laundry_customer/utils/routes.dart';
import 'package:laundry_customer/widgets/busy_loader.dart';
import 'package:laundry_customer/widgets/buttons/full_width_button.dart';
import 'package:laundry_customer/widgets/misc_widgets.dart';
import 'package:laundry_customer/widgets/nav_bar.dart';
import 'package:laundry_customer/widgets/screen_wrapper.dart';

class MyCartTab extends ConsumerWidget {
  const MyCartTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int? minimum;
    double? dlvrychrg;
    double? free;

    ref.watch(settingsProvider).whenOrNull(
      loaded: (data) {
        minimum = data.data!.minimumCost;
        dlvrychrg = data.data!.deliveryCost!.toDouble();

        free = data.data!.feeCost!.toDouble();
      },
    );
    return PopScope(
      canPop: false,
      child: ScreenWrapper(
        color: AppColors.grayBG,
        padding: EdgeInsets.zero,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: Hive.box<CartModel>(AppHSC.cartBox).listenable(),
              builder: (context, Box<CartModel> cartBox, child) {
                final List<CartModel> cartItmes = cartBox.values.toList();
                return Stack(
                  children: [
                    SizedBox(
                      height: 812.h,
                      width: 375.w,
                      child: Column(
                        children: [
                          Container(
                            height: 100.h,
                            width: 375.w,
                            decoration: AppBoxDecorations.topBar,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              children: [
                                AppSpacerH(44.h),
                                AppNavbar(
                                  backButtionColor: AppColors.black,
                                  title: 'My Cart(${cartItmes.length})',
                                  showBack: false,
                                ),
                              ],
                            ),
                          ),
                          _buildProductListWidget(cartItems: cartItmes),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 80.h,
                      child: payableAmountWidget(cartItmes, dlvrychrg),
                    ),
                  ],
                );
              },
            ),
            if (ref.watch(loadingProvider))
              const Center(
                child: BusyLoader(
                  size: 120,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductListWidget({required List<CartModel> cartItems}) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.only(bottom: 120.h, top: 16.h),
        itemCount: cartItems.length,
        itemBuilder: (context, index) => ProductCartCard(
          cartModel: cartItems[index],
        ),
        separatorBuilder: (context, index) => const Divider(
          height: 0,
        ),
      ),
    );
  }

  Widget payableAmountWidget(
    List<CartModel> cartItems,
    dynamic deliveryCharge,
  ) {
    return Container(
      height: 104.h,
      width: 375.w,
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(ContextLess.context).ttl,
                style: AppTextDecor.osSemiBold18black,
              ),
              Text(
                '${AppGFunctions.getCurrency()}${LocalService().calculateTotal(cartItems: cartItems).toStringAsFixed(2)}',
                style: AppTextDecor.osSemiBold18black,
              ),
              Text(
                'Delivery Charge is ${AppGFunctions.getCurrency()}$deliveryCharge',
                style: AppTextDecor.osRegular12black,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextButton(
                title: S.of(ContextLess.context).ordrnow,
                height: 45.h,
                width: 164.w,
                onTap: () =>
                    ContextLess.context.nav.pushNamed(Routes.checkOutScreen),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
