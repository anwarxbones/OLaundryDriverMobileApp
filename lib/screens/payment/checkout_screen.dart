import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laundry_customer/constants/app_box_decoration.dart';
import 'package:laundry_customer/constants/app_colors.dart';
import 'package:laundry_customer/constants/app_text_decor.dart';
import 'package:laundry_customer/constants/hive_contants.dart';
import 'package:laundry_customer/constants/input_field_decorations.dart';
import 'package:laundry_customer/generated/l10n.dart';
import 'package:laundry_customer/providers/address_provider.dart';
import 'package:laundry_customer/providers/misc_providers.dart';
import 'package:laundry_customer/providers/order_providers.dart';
import 'package:laundry_customer/screens/address/manage_address_screen.dart';
import 'package:laundry_customer/screens/order/payment_method_card.dart';
import 'package:laundry_customer/screens/payment/payment_controller.dart';
import 'package:laundry_customer/screens/payment/payment_section.dart';
import 'package:laundry_customer/screens/payment/schedule_picker_widget.dart';
import 'package:laundry_customer/services/local_service.dart';
import 'package:laundry_customer/utils/context_less_nav.dart';
import 'package:laundry_customer/utils/routes.dart';
import 'package:laundry_customer/widgets/buttons/button_with_icon.dart';
import 'package:laundry_customer/widgets/misc_widgets.dart';
import 'package:laundry_customer/widgets/nav_bar.dart';
import 'package:laundry_customer/widgets/screen_wrapper.dart';

class CheckOutScreen extends ConsumerStatefulWidget {
  const CheckOutScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends ConsumerState<CheckOutScreen> {
  final PaymentController pay = PaymentController();
  final TextEditingController _instruction = TextEditingController();
  final TextEditingController _couponCode = TextEditingController();
  final Box appSettingsBox = Hive.box(AppHSC.appSettingsBox);
  PaymentType selectedPaymentType = PaymentType.cod;
  int deliveryCost = 0;
  int couponDiscount = 0;
  int feeCost = 0;
  int minimumCost = 0;

  @override
  Widget build(BuildContext context) {
    int? couponID;
    ref.watch(addressIDProvider);
    ref.watch(dateProvider('Pick Up'));
    ref.watch(dateProvider('Delivery'));
    ref.watch(couponProvider).maybeWhen(
          orElse: () {},
          loaded: (_) {
            couponID = _.data?.coupon?.id;
          },
          error: (error) => print('This is a coupon error $error'),
        );
    deliveryCost = appSettingsBox.get('delivery_cost') as int;
    feeCost = appSettingsBox.get('fee_cost') as int;
    minimumCost = appSettingsBox.get('minimum_cost') as int;
    print("This is a fee cost: $feeCost");
    return PopScope(
      onPopInvoked: (value) {
        ref.watch(dateProvider('Pick Up').notifier).state = null;
        ref.watch(dateProvider('Delivery').notifier).state = null;
      },
      child: ScreenWrapper(
        padding: EdgeInsets.zero,
        child: Container(
          height: 812.h,
          width: 375.w,
          color: AppColors.grayBG,
          child: Stack(
            children: [
              Column(
                children: [
                  _buildHeaderWidget(context),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        AppSpacerH(10.h),
                        _buildScheduleWidget(context),
                        AppSpacerH(10.h),
                        Container(
                          width: 375.w,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 15.h,
                          ),
                          decoration: AppBoxDecorations.pageCommonCard,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 335.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).adrs,
                                      style: AppTextDecor.osSemiBold18black,
                                    ),
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     context.nav.pushNamed(
                                    //       Routes.manageAddressScreen,
                                    //     );
                                    //   },
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //       color: AppColors.grayBG,
                                    //       borderRadius:
                                    //           BorderRadius.circular(5.w),
                                    //     ),
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.all(3.0),
                                    //       child: Text(
                                    //         S.of(context).mngaddrs,
                                    //         style:
                                    //             AppTextDecor.osSemiBold14navy,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              AppSpacerH(11.h),
                              ref.watch(addresListProvider).map(
                                    initial: (_) => const SizedBox(),
                                    loading: (_) => const LoadingWidget(),
                                    loaded: (_) {
                                      Future.delayed(Duration.zero, () {
                                        ref
                                                .watch(
                                                  addressIDProvider.notifier,
                                                )
                                                .state =
                                            _.data.data!.addresses![0].id
                                                .toString();
                                      });
                                      return _.data.data!.addresses!.isEmpty
                                          ? AppIconTextButton(
                                              icon: Icons.add,
                                              title: S.of(context).adadres,
                                              onTap: () {
                                                context.nav.pushNamed(
                                                  Routes
                                                      .addOrUpdateAddressScreen,
                                                );
                                              },
                                            )
                                          : AddressCard(
                                              editable: false,
                                              address:
                                                  _.data.data!.addresses![0],
                                            );
                                    },

                                    // FormBuilderDropdown(
                                    //     decoration: AppInputDecor
                                    //         .loginPageInputDecor
                                    //         .copyWith(
                                    //       hintText: S.of(context).chsadrs,
                                    //     ),
                                    //     onChanged: (val) {
                                    //       ref
                                    //           .watch(
                                    //             addressIDProvider.notifier,
                                    //           )
                                    //           .state = val.toString();
                                    //     },
                                    //     name: 'address',
                                    //     items: _.data.data!.addresses!
                                    //         .map(
                                    //           (e) => DropdownMenuItem(
                                    //             value: e.id.toString(),
                                    //             child: Text(
                                    //               AppGFunctions
                                    //                   .processAdAddess(
                                    //                 e,
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         )
                                    //         .toList(),
                                    //   ),
                                    error: (_) =>
                                        ErrorTextWidget(error: _.error),
                                  ),
                            ],
                          ),
                        ),
                        AppSpacerH(10.h),
                        Container(
                          width: 375.w,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 15.h,
                          ),
                          decoration: AppBoxDecorations.pageCommonCard,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).instrctn,
                                style: AppTextDecor.osSemiBold18black,
                              ),
                              AppSpacerH(11.h),
                              TextField(
                                controller: _instruction,
                                decoration:
                                    AppInputDecor.loginPageInputDecor.copyWith(
                                  hintText: S.of(context).adinstrctnop,
                                ),
                                maxLines: 3,
                              ),
                            ],
                          ),
                        ),
                        AppSpacerH(10.h),
                        Container(
                          width: 375.w,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 15.h,
                          ),
                          decoration: AppBoxDecorations.pageCommonCard,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).pymntmthd,
                                style: AppTextDecor.osSemiBold18black,
                              ),
                              AppSpacerH(11.h),
                              PaymentMethodCard(
                                onTap: () {
                                  setState(() {
                                    selectedPaymentType = PaymentType.cod;
                                  });
                                },
                                imageLocation: 'assets/images/logo_cod.png',
                                title: S.of(context).cshondlvry,
                                subtitle: S.of(context).pywhndlvry,
                                isSelected:
                                    selectedPaymentType == PaymentType.cod,
                              ),
                              AppSpacerH(11.h),
                              PaymentMethodCard(
                                onTap: () {
                                  setState(() {
                                    selectedPaymentType =
                                        PaymentType.onlinePayment;
                                  });
                                },
                                imageLocation:
                                    'assets/images/logo_master_card.png',
                                title: S.of(context).mkpymnt,
                                subtitle: S.of(context).payonlinewithcard,
                                isSelected: selectedPaymentType ==
                                    PaymentType.onlinePayment,
                              ),
                            ],
                          ),
                        ),
                        _buildCouponAndSummaryWidget(context),
                        PaymentSection(
                          instruction: _instruction,
                          selectedPaymentType: selectedPaymentType,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildScheduleWidget(BuildContext context) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 15.h,
      ),
      decoration: AppBoxDecorations.pageCommonCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).shpngschdl,
            style: AppTextDecor.osSemiBold18black,
          ),
          AppSpacerH(10.h),
          Row(
            children: [
              Expanded(
                child: ShedulePicker(
                  image: 'assets/images/pickup-car.png',
                  title: S.of(context).pickupat,
                ),
              ),
              AppSpacerW(10.w),
              Expanded(
                child: ShedulePicker(
                  image: 'assets/images/pick-up-truck.png',
                  title: S.of(context).dlvryat,
                ),
              ),
            ],
          ),
          AppSpacerH(10.h),
        ],
      ),
    );
  }

  Container _buildHeaderWidget(BuildContext context) {
    return Container(
      color: AppColors.primary,
      height: 108.h,
      width: 375.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          children: [
            AppSpacerH(44.h),
            AppNavbar(
              backgroundColor: AppColors.primary,
              titleColor: AppColors.white,
              title: S.of(context).shpngndpymnt,
              onBack: () {
                context.nav.pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponAndSummaryWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.only(top: 10.h),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCouponWidget(),
          AppSpacerH(16.h),
          Text(
            'Order Summary',
            style: AppTextDecor.osBold14black,
          ),
          AppSpacerH(10.h),
          _buildSummaryWidget(),
        ],
      ),
    );
  }

  Widget _buildCouponWidget() {
    return Row(
      children: [
        Flexible(
          flex: 4,
          child: FormBuilderTextField(
            name: 'coupon',
            controller: _couponCode,
            decoration: AppInputDecor.loginPageInputDecor.copyWith(
              hintText: S.of(context).enterCouponCode,
              prefixIcon: Padding(
                padding: EdgeInsets.all(10.w),
                child: SizedBox(
                  width: 10,
                  child: Image.asset(
                    'assets/images/coupon.png',
                  ),
                ),
              ),
            ),
            onChanged: (value) {},
          ),
        ),
        AppSpacerW(10.w),
        Flexible(
          child: ref.watch(couponProvider).map(
                initial: (_) => GestureDetector(
                  onTap: () {
                    if (_couponCode.text.isNotEmpty) {
                      ref
                          .read(couponProvider.notifier)
                          .applyCoupon(coupon: _couponCode.text, amount: '100');
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Text(
                      S.of(context).apply,
                      style: AppTextDecor.osBold14black
                          .copyWith(color: AppColors.primary),
                    ),
                  ),
                ),
                loading: (_) => const CircularProgressIndicator(),
                loaded: (value) => GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.primary,
                    ),
                    child: Text(
                      S.of(context).applied,
                      style: AppTextDecor.osBold14white
                          .copyWith(color: AppColors.white),
                    ),
                  ),
                ),
                error: (_) => GestureDetector(
                  onTap: () {
                    ref
                        .read(couponProvider.notifier)
                        .applyCoupon(coupon: 'sdfsdf', amount: '100');
                  },
                  child: Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Text(
                      'Apply',
                      style: AppTextDecor.osBold14black
                          .copyWith(color: AppColors.primary),
                    ),
                  ),
                ),
              ),
        ),
      ],
    );
  }

  Widget _buildSummaryWidget() {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.lightgray,
      ),
      child: Column(
        children: [
          _buildSummaryRowWidget(
            title: S.of(context).subtotal,
            value: LocalService()
                .calculateTotal(cartItems: LocalService().getCart()),
          ),
          AppSpacerH(8.h),
          _buildSummaryRowWidget(
            title: S.of(context).discount,
            value: ref.watch(discountAmountProvider),
            isDiscount: true,
          ),
          const Divider(),
          _buildSummaryRowWidget(
            title: S.of(context).total,
            value: LocalService()
                    .calculateTotal(cartItems: LocalService().getCart()) -
                ref.watch(discountAmountProvider),
          ),
          AppSpacerH(8.h),
          _buildSummaryRowWidget(
            title: S.of(context).deliveryCharge,
            value: LocalService()
                        .calculateTotal(cartItems: LocalService().getCart()) <
                    minimumCost
                ? deliveryCost.toDouble()
                : 0,
          ),
          const Divider(),
          _buildSummaryRowWidget(
            title: S.of(context).payable,
            value: LocalService()
                    .calculateTotal(cartItems: LocalService().getCart()) -
                (ref.watch(discountAmountProvider) + deliveryCost),
            isPayable: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRowWidget({
    required String title,
    required double value,
    bool isDiscount = false,
    bool isPayable = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextDecor.osRegular14Navy
              .copyWith(fontWeight: isPayable ? FontWeight.w600 : null),
        ),
        Text(
          isDiscount
              ? '-' +
                  '${appSettingsBox.get('currency') ?? '\$'}${value.toStringAsFixed(2)}'
              : '${appSettingsBox.get('currency') ?? '\$'}${value.toStringAsFixed(2)}',
          style: AppTextDecor.osRegular14black.copyWith(
            color: isDiscount ? AppColors.red : AppColors.black,
            fontWeight: isPayable ? FontWeight.w600 : null,
          ),
        ),
      ],
    );
  }
}

enum PaymentType { cod, onlinePayment }
