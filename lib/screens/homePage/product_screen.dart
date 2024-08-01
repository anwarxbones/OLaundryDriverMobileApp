import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:laundry_customer/constants/app_box_decoration.dart';
import 'package:laundry_customer/constants/app_colors.dart';
import 'package:laundry_customer/constants/app_text_decor.dart';
import 'package:laundry_customer/constants/hive_contants.dart';
import 'package:laundry_customer/generated/l10n.dart';
import 'package:laundry_customer/misc/global_functions.dart';
import 'package:laundry_customer/misc/misc_global_variables.dart';
import 'package:laundry_customer/models/category_model/category.dart';
import 'package:laundry_customer/models/hive_cart_item_model.dart';
import 'package:laundry_customer/providers/address_provider.dart';
import 'package:laundry_customer/providers/misc_providers.dart';
import 'package:laundry_customer/providers/order_update_provider.dart';
import 'package:laundry_customer/providers/product_provider.dart';
import 'package:laundry_customer/providers/settings_provider.dart';
import 'package:laundry_customer/screens/homePage/widgets/product_card.dart';
import 'package:laundry_customer/utils/context_less_nav.dart';
import 'package:laundry_customer/utils/routes.dart';
import 'package:laundry_customer/widgets/buttons/full_width_button.dart';
import 'package:laundry_customer/widgets/global_functions.dart';
import 'package:laundry_customer/widgets/misc_widgets.dart';
import 'package:laundry_customer/widgets/nav_bar.dart';
import 'package:laundry_customer/widgets/screen_wrapper.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({
    super.key,
    required this.category,
  });
  final CategoryModel category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Box appSettingsBox = Hive.box(AppHSC.appSettingsBox);
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
                          title: getLng(
                            en: category.name,
                            changeLang: category.name,
                          ),
                          onBack: () {
                            context.nav.pop();
                          },
                        ),
                      ],
                    ),
                  ),
                  ref.watch(productProvider(category.id)).map(
                        initial: (_) => const SizedBox(),
                        loading: (_) => const LoadingWidget(),
                        loaded: (data) => _buildProductListWidget(),
                        error: (error) => _buildProductListWidget(),
                      ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Builder(
                builder: (context) {
                  return ValueListenableBuilder(
                    valueListenable: Hive.box(AppHSC.cartBox).listenable(),
                    builder: (
                      BuildContext context,
                      Box cartBox,
                      Widget? child,
                    ) {
                      final List<CarItemHiveModel> cartItems = [];
                      for (var i = 0; i < cartBox.length; i++) {
                        final Map<String, dynamic> processedData = {};
                        final Map<dynamic, dynamic> unprocessedData =
                            cartBox.getAt(i) as Map<dynamic, dynamic>;

                        unprocessedData.forEach((key, value) {
                          processedData[key.toString()] = value;
                        });

                        cartItems.add(
                          CarItemHiveModel.fromMap(
                            processedData,
                          ),
                        );
                      }

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
                                  S.of(context).ttl,
                                  style: AppTextDecor.osSemiBold18black,
                                ),
                                Text(
                                  '${appSettingsBox.get('currency') ?? '\$'}${calculateTotal(cartItems).toStringAsFixed(2)}',
                                  style: AppTextDecor.osSemiBold18black,
                                ),
                                if (AppGFunctions.calculateTotal(
                                      cartItems,
                                    ).toInt() <
                                    free!) ...[
                                  Text(
                                    'Delivery Charge is ${appSettingsBox.get('currency') ?? '\$'}${AppGFunctions.convertToFixedTwo(dlvrychrg!)}',
                                    style: AppTextDecor.osRegular12black,
                                  ),
                                ] else ...[
                                  Text(
                                    'Delivery Charge is ${appSettingsBox.get('currency') ?? '\$'}0.00',
                                    style: AppTextDecor.osRegular12black,
                                  ),
                                ],
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (calculateTotal(cartItems) < minimum!)
                                  Text(
                                    '${S.of(context).mnmmordramnt} ${appSettingsBox.get('currency') ?? '\$'}${AppGFunctions.convertToFixedTwo(minimum!)}',
                                    style: AppTextDecor.osRegular12red,
                                  ),
                                AppSpacerH(5.h),
                                if (ref.read(orderIdProvider) != '')
                                  AppTextButton(
                                    height: 45.h,
                                    width: 164.w,
                                    title: 'Done',
                                    onTap: () {
                                      context.nav.pop();
                                      ref
                                          .watch(
                                            homeScreenIndexProvider.notifier,
                                          )
                                          .state = 0;
                                      ref
                                          .watch(
                                            homeScreenPageControllerProvider,
                                          )
                                          .animateToPage(
                                            0,
                                            duration: transissionDuration,
                                            curve: Curves.easeInOut,
                                          );
                                    },
                                  )
                                else
                                  AppTextButton(
                                    title: S.of(context).ordrnow,
                                    height: 45.h,
                                    width: 164.w,
                                    onTap: () {
                                      final Box authBox = Hive.box(
                                        AppHSC.authBox,
                                      ); //Stores Auth Data

                                      if (authBox.get(AppHSC.authToken) !=
                                              null &&
                                          authBox.get(AppHSC.authToken) != '') {
                                        if (calculateTotal(cartItems) >=
                                            minimum!) {
                                          ref.refresh(
                                            addresListProvider,
                                          );
                                          context.nav.pushNamed(
                                            Routes.checkOutScreen,
                                          );
                                        } else {
                                          EasyLoading.showError(
                                            '${S.of(context).mnmmordramnt} ${appSettingsBox.get('currency') ?? '\$'}${AppGFunctions.convertToFixedTwo(minimum!)}',
                                          );
                                        }
                                      } else {
                                        context.nav
                                            .pushNamed(Routes.loginScreen);
                                      }
                                    },
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductListWidget() {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.only(bottom: 120.h, top: 16.h),
        itemCount: 10,
        itemBuilder: (context, index) => const ProductCard(),
        separatorBuilder: (context, index) => const Divider(
          height: 0,
        ),
      ),
    );
  }
}

double calculateTotal(List<CarItemHiveModel> cartItems) {
  double amount = 0;
  for (final element in cartItems) {
    if (element.subProduct != null) {
      amount += element.productsQTY *
          (element.unitPrice + element.subProduct!.price!);
    } else {
      amount += element.productsQTY * element.unitPrice;
    }
  }

  return amount;
}
