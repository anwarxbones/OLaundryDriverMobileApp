import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:laundry_customer/constants/app_box_decoration.dart';
import 'package:laundry_customer/constants/app_text_decor.dart';
import 'package:laundry_customer/constants/hive_contants.dart';
import 'package:laundry_customer/generated/l10n.dart';
import 'package:laundry_customer/misc/misc_global_variables.dart';
import 'package:laundry_customer/models/cart/cart_model.dart';
import 'package:laundry_customer/models/order_place_model/order_place_mode_new.dart';
import 'package:laundry_customer/providers/misc_providers.dart';
import 'package:laundry_customer/providers/order_providers.dart';
import 'package:laundry_customer/providers/settings_provider.dart';
import 'package:laundry_customer/screens/payment/checkout_screen.dart';
import 'package:laundry_customer/screens/payment/payment_controller.dart';
import 'package:laundry_customer/services/local_service.dart';
import 'package:laundry_customer/utils/context_less_nav.dart';
import 'package:laundry_customer/utils/routes.dart';
import 'package:laundry_customer/widgets/buttons/full_width_button.dart';
import 'package:laundry_customer/widgets/misc_widgets.dart';

// ignore: must_be_immutable
class PaymentSection extends ConsumerStatefulWidget {
  const PaymentSection({
    super.key,
    required this.instruction,
    required this.selectedPaymentType,
  });
  final TextEditingController instruction;
  final PaymentType selectedPaymentType;

  @override
  ConsumerState<PaymentSection> createState() => _PaymentSectionState();
}

class _PaymentSectionState extends ConsumerState<PaymentSection> {
  final Box appSettingsBox = Hive.box(AppHSC.appSettingsBox);

  int? couponID;

  bool isMakingPayment = false;

  bool isPaid = false;

  @override
  Widget build(BuildContext context) {
    ref.watch(couponProvider).maybeWhen(
          orElse: () {},
          loaded: (response) {
            couponID = response.data?.coupon?.id;
          },
        );
    late int? minimum;
    double? dlvrychrg;
    double? free;
    ref.watch(settingsProvider).whenOrNull(
      loaded: (data) {
        minimum = data.data!.minimumCost;
        dlvrychrg = data.data!.deliveryCost!.toDouble();
        free = data.data!.feeCost!.toDouble();
      },
    );
    return ValueListenableBuilder(
      valueListenable: Hive.box<CartModel>(AppHSC.cartBox).listenable(),
      builder: (
        BuildContext context,
        Box cartBox,
        Widget? child,
      ) {
        final List<CartModel> cartItems = LocalService().getCart();
        return Container(
          width: 375.w,
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 25.h,
          ),
          decoration: AppBoxDecorations.pageCommonCard.copyWith(),
          child: SizedBox(
            child: Consumer(
              builder: (context, ref, child) {
                return ref.watch(placeOrdersProvider).map(
                      initial: (_) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).ttlpybl,
                                style: AppTextDecor.osSemiBold18black,
                              ),
                              if (LocalService()
                                      .calculateTotal(cartItems: cartItems) <
                                  free!) ...[
                                Text(
                                  '${appSettingsBox.get('currency') ?? '\$'}${(LocalService().calculateTotal(cartItems: cartItems) + dlvrychrg! - ref.watch(discountAmountProvider)).toStringAsFixed(2)}',
                                  style: AppTextDecor.osBold14black,
                                ),
                              ] else ...[
                                Text(
                                  '${appSettingsBox.get('currency') ?? '\$'}${(LocalService().calculateTotal(cartItems: cartItems) - ref.watch(discountAmountProvider)).toStringAsFixed(2)}',
                                  style: AppTextDecor.osSemiBold18black,
                                ),
                              ],
                            ],
                          ),
                          if (isMakingPayment)
                            const Center(
                              child: CircularProgressIndicator(),
                            )
                          else
                            AppTextButton(
                              title: S.of(context).pynw,
                              onTap: () async {
                                final DateFormat formatter = DateFormat(
                                  'yyyy-MM-dd',
                                );
                                final isOrderProcessing =
                                    ref.watch(orderProcessingProvider);

                                if (!isOrderProcessing) {
                                  ref
                                      .watch(
                                        orderProcessingProvider.notifier,
                                      )
                                      .state = true;
                                  final pickUp = ref.watch(
                                    scheduleProvider('Pick Up'),
                                  );
                                  final delivery = ref.watch(
                                    scheduleProvider(
                                      'Delivery',
                                    ),
                                  );
                                  final address = ref.watch(
                                    addressIDProvider,
                                  );

                                  //Cheks All Reguired Data Is AvailAble
                                  if (pickUp != null &&
                                      delivery != null &&
                                      address != '' &&
                                      cartItems.isNotEmpty) {
                                    //Has All Data

                                    final OrderPlaceModelNew
                                        orderPlaceModelNew = OrderPlaceModelNew(
                                      addressId: address,
                                      pickDate:
                                          "${pickUp.dateTime.year}-${pickUp.dateTime.month}-${pickUp.dateTime.day}",
                                      pickHour: pickUp.schedule.hour.toString(),
                                      deliveryDate:
                                          "${delivery.dateTime.year}-${delivery.dateTime.month}-${delivery.dateTime.day}",
                                      deliveryHour:
                                          delivery.schedule.hour.toString(),
                                      couponId: couponID?.toString(),
                                      instruction: widget.instruction.text,
                                      products:
                                          getProductList(cartItems: cartItems),
                                      subProductIds: getSubProductList(
                                        cartItems: cartItems,
                                      ),
                                    );

                                    print(orderPlaceModelNew.toJson());

                                    // await ref
                                    //     .watch(placeOrdersProvider.notifier)
                                    //     .addOrder(orderPlaceModelNew);
                                  } else {
                                    EasyLoading.showError(
                                      S.of(context).plsslctalflds,
                                    );
                                  }
                                  ref
                                      .watch(orderProcessingProvider.notifier)
                                      .state = false;
                                } else {
                                  EasyLoading.showError(
                                    S.of(context).wrprcsngprvsdlvry,
                                  );
                                }
                              },
                            ),
                        ],
                      ),
                      loading: (_) => const LoadingWidget(),
                      loaded: (response) {
                        final String amount = (LocalService()
                                    .calculateTotal(cartItems: cartItems) -
                                ref.watch(
                                  discountAmountProvider,
                                ))
                            .toStringAsFixed(2);

                        Future.delayed(buildDuration).then((value) async {
                          await cartBox.clear();
                          ref.refresh(placeOrdersProvider);
                          ref.refresh(couponProvider);
                          ref.refresh(
                            discountAmountProvider,
                          );
                          ref
                              .watch(
                                dateProvider('Pick Up').notifier,
                              )
                              .state = null;
                          ref
                              .watch(
                                dateProvider('Delivery').notifier,
                              )
                              .state = null;
                          context.nav.pushNamedAndRemoveUntil(
                            Routes.orderSuccessScreen,
                            arguments: {
                              'id': response.data.data!.order!.orderCode,
                              'amount': amount,
                              'couponID': couponID.toString(),
                              'isCOD':
                                  widget.selectedPaymentType == PaymentType.cod,
                            },
                            (route) => false,
                          );

                          if (widget.selectedPaymentType == PaymentType.cod ||
                              isPaid) {
                            context.nav.pushNamedAndRemoveUntil(
                              Routes.orderSuccessScreen,
                              arguments: {
                                'id': response.data.data!.order!.orderCode,
                                'amount': amount,
                                'couponID': couponID.toString(),
                                'isCOD': widget.selectedPaymentType ==
                                    PaymentType.cod,
                              },
                              (route) => false,
                            );
                          } else {
                            if (!isMakingPayment) {
                              isMakingPayment = true;
                              final PaymentController pay = PaymentController();

                              isPaid = await pay.makePayment(
                                amount: amount,
                                currency: 'GBP',
                                couponID: couponID.toString(),
                                orderID: response.data.data!.order!.orderCode!,
                              );

                              isMakingPayment = false;
                              setState(() {});

                              if (isPaid) {
                                context.nav.pushNamedAndRemoveUntil(
                                  Routes.orderSuccessScreen,
                                  arguments: {
                                    'id': response.data.data!.order!.orderCode,
                                    'amount': amount,
                                    'couponID': couponID.toString(),
                                    'isCOD': widget.selectedPaymentType ==
                                        PaymentType.cod,
                                    "isPaidOnline": true,
                                  },
                                  (route) => false,
                                );
                              } else {
                                context.nav.pushNamedAndRemoveUntil(
                                  Routes.orderSuccessScreen,
                                  arguments: {
                                    'id': response.data.data!.order!.orderCode,
                                    'amount': amount,
                                    'couponID': couponID.toString(),
                                    'isCOD': widget.selectedPaymentType ==
                                        PaymentType.cod,
                                    "isPaidOnline": false,
                                  },
                                  (route) => false,
                                );
                              }
                            }
                          }
                        });
                        return MessageTextWidget(
                          msg: S.of(context).ordrplcd,
                        );
                      },
                      error: (error) {
                        Future.delayed(
                          const Duration(seconds: 2),
                        ).then((value) {
                          final value = ref.refresh(placeOrdersProvider);
                          debugPrint(value.toString());
                        });
                        return ErrorTextWidget(
                          error: error.error,
                        );
                      },
                    );
              },
            ),
          ),
        );
      },
    );
  }

  List<Product> getProductList({required List<CartModel> cartItems}) {
    return cartItems
        .map(
          (product) => Product(
            productId: product.productId,
            quantity: product.quantity,
            instrunction: product.note,
          ),
        )
        .toList();
  }

  List<int> getSubProductList({required List<CartModel> cartItems}) {
    return cartItems
        .expand((product) => product.addOns)
        .map((addOn) => addOn.id)
        .toList();
  }
}
