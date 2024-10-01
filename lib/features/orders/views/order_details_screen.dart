import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:o_driver/constants/app_colors.dart';
import 'package:o_driver/constants/app_durations.dart';
import 'package:o_driver/constants/app_text_decor.dart';
import 'package:o_driver/constants/input_field_decorations.dart';
import 'package:o_driver/features/orders/logic/order_provider.dart';
import 'package:o_driver/features/orders/models/pending_order_list_model/order.dart';
import 'package:o_driver/features/orders/views/widgets/phone_num_picker_dialog.dart';
import 'package:o_driver/features/orders/views/widgets/slider_widget.dart';
import 'package:o_driver/utils/context_less_nav.dart';
import 'package:o_driver/utils/global_functions.dart';
import 'package:o_driver/widgets/buttons/full_width_button.dart';
import 'package:o_driver/widgets/misc_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsScreen extends ConsumerWidget {
  OrderDetailsScreen({Key? key, required this.order}) : super(key: key);
  final Order order;
  final TextEditingController _controller =
      TextEditingController(text: 'This is an instruction for delivery');
  final TextEditingController _failureNoteController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            leading: const BackButton(
              color: AppColors.navyText,
            ),
            title: Text(
              'Order Details',
              style: AppTextDecor.osBold14black,
            ),
          ),
          AppSpacerH(16.h),
          Expanded(
            child: Container(
              color: AppColors.white,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.gray, width: 2),
                    borderRadius: BorderRadius.circular(2.h)),
                child: ref.watch(orderDetailsProvider(order.id!)).when(
                      initial: (() => const LoadingWidget()),
                      loading: () => const LoadingWidget(),
                      loaded: (details) {
                        _controller.text = details.instruction ?? '';
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 10.h),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        details.customerName ?? 'Unknown',
                                        style:
                                            AppTextDecor.osBold14black.copyWith(
                                          color: AppColors.navyText,
                                        ),
                                      ),
                                      Text(
                                        details.isTypePickup == true
                                            ? 'P'
                                            : 'D',
                                        style: AppTextDecor.osBold14black
                                            .copyWith(
                                                fontStyle: FontStyle.italic,
                                                color: AppColors.cardDeepGreen),
                                      ),
                                      Text(
                                        details.orderCode ?? '',
                                        style:
                                            AppTextDecor.osBold14black.copyWith(
                                          color: AppColors.navyText,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomSeprator(
                                      color:
                                          AppColors.navyText.withOpacity(0.2),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Text(
                                          AppGFunctions.processAdAddess2(
                                              details.address),
                                          textAlign: TextAlign.center,
                                          style: AppTextDecor.osBold14black
                                              .copyWith(
                                                  color: AppColors.navyText,
                                                  fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                                            onTap: () async {
                                              List<Location> locations =
                                                  await getLatLngFromAddress(
                                                address: AppGFunctions
                                                    .processAdAddess2(
                                                  details.address,
                                                ),
                                              );

                                              if (locations.isNotEmpty) {
                                                final double lat =
                                                    locations.first.latitude;
                                                final double lng =
                                                    locations.first.longitude;
                                                launchGoogleMaps(
                                                    lat: lat, lng: lng);
                                              }
                                            },
                                            child: const CircleAvatar(
                                              backgroundColor:
                                                  AppColors.cardDeepGreen,
                                              child: Center(
                                                child: Icon(
                                                  Icons.directions,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomSeprator(
                                      color:
                                          AppColors.navyText.withOpacity(0.2),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.schedule,
                                              color: AppColors.navyText),
                                          AppSpacerW(5.w),
                                          Text(
                                            details.isTypePickup == true
                                                ? details.pickHour ?? ''
                                                : details.deliveryHour ?? '',
                                            style: AppTextDecor.osBold14black
                                                .copyWith(
                                              color: AppColors.navyText,
                                            ),
                                          ),
                                        ],
                                      ),
                                      AppGFunctions.statusCard(
                                          details.pickAndDelivaryStatus ?? '')
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomSeprator(
                                      color:
                                          AppColors.navyText.withOpacity(0.2),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ref.watch(makeCallProvider).map(
                                            error: (_) {
                                              Future.delayed(const Duration(
                                                      milliseconds: 500))
                                                  .then((value) {
                                                ref.refresh(makeCallProvider);
                                              });
                                              EasyLoading.showError(_.error);
                                              return const SizedBox.shrink();
                                            },
                                            loading: (_) =>
                                                const LoadingWidget(),
                                            initial: (_) {
                                              return GestureDetector(
                                                onTap: () {
                                                  // TODO: Need to show dialog here
                                                  // ref
                                                  //     .read(makeCallProvider
                                                  //         .notifier)
                                                  //     .makeCall(
                                                  //         orderId: details.id!);
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        PhoneNumPickerDialog(
                                                      orderId: details.id!,
                                                    ),
                                                  );
                                                },
                                                child: const CircleAvatar(
                                                  backgroundColor:
                                                      AppColors.cardDeepGreen,
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.phone,
                                                      color: AppColors.white,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            loaded: (data) {
                                              if (data.data == true) {
                                                EasyLoading.showSuccess(
                                                  "Call Sent Successfully",
                                                );
                                              } else {
                                                EasyLoading.showError(
                                                  "Call Not Sent, Please try Again",
                                                );
                                              }
                                              Future.delayed(
                                                      AppDurConst.buildDuration)
                                                  .then((value) {
                                                ref.refresh(makeCallProvider);
                                              });
                                              return const SizedBox.shrink();
                                            },
                                          ),
                                      GestureDetector(
                                        onTap: () => _showSmsBottomSheet(
                                          context: context,
                                          ref: ref,
                                          number: details.phone ?? '',
                                          controller: _smsController,
                                          formKey: _formKey,
                                        ),
                                        child: const CircleAvatar(
                                          backgroundColor:
                                              AppColors.cardDeepGreen,
                                          child: Center(
                                            child: Icon(
                                              Icons.email_outlined,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  AppSpacerH(16.h),
                                  FormBuilderTextField(
                                    readOnly: true,
                                    autofocus: true,
                                    name: 'instructions',
                                    minLines: 4,
                                    maxLines: 4,
                                    controller: _controller,
                                    decoration: AppInputDecor
                                        .loginPageInputDecor
                                        .copyWith(
                                      hintText: '',
                                      enabled: true,
                                    ),
                                  ),
                                  AppSpacerH(40.h),
                                  details.pickAndDelivaryStatus == 'Success' ||
                                          details.pickAndDelivaryStatus ==
                                              'Failed'
                                      ? const SizedBox.shrink()
                                      : ref
                                          .watch(orderProcessUpdaterProvider)
                                          .map(
                                            initial: (_) => SlideToStartWidget(
                                              pickAndDeliveryStatus: details
                                                      .pickAndDelivaryStatus ??
                                                  '',
                                              onSlideCompleted: () {
                                                if (details
                                                        .pickAndDelivaryStatus ==
                                                    'Pending') {
                                                  ref
                                                      .read(acceptOrderProvider
                                                          .notifier)
                                                      .acceptOrder(
                                                        orderId: details.id!,
                                                        isAccepted: true,
                                                      )
                                                      .then((value) {
                                                    ref.refresh(
                                                        orderDetailsProvider(
                                                            details.id!));
                                                  });
                                                } else {
                                                  ref
                                                      .read(
                                                          orderProcessUpdaterProvider
                                                              .notifier)
                                                      .updateOrderProcess(
                                                        orderId: details.id,
                                                        status: getNextStatus(
                                                            status: details
                                                                .pickAndDelivaryStatus),
                                                      );
                                                }
                                              },
                                            ),
                                            loading: (_) => const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            loaded: (_) {
                                              EasyLoading.showSuccess(_.data);
                                              Future.delayed(
                                                      AppDurConst.buildDuration)
                                                  .then((value) {
                                                ref.refresh(
                                                    orderProcessUpdaterProvider);
                                                ref.refresh(
                                                    orderDetailsProvider(
                                                        order.id!));
                                              });
                                              return SlideToStartWidget(
                                                pickAndDeliveryStatus: details
                                                        .pickAndDelivaryStatus ??
                                                    '',
                                                onSlideCompleted: () {
                                                  ref
                                                      .read(
                                                          orderProcessUpdaterProvider
                                                              .notifier)
                                                      .updateOrderProcess(
                                                        orderId: details.id,
                                                        status: getNextStatus(
                                                            status: details
                                                                .pickAndDelivaryStatus),
                                                      );
                                                },
                                              );
                                            },
                                            error: (error) {
                                              EasyLoading.showError(
                                                  error.error);
                                              return SlideToStartWidget(
                                                pickAndDeliveryStatus: details
                                                        .pickAndDelivaryStatus ??
                                                    '',
                                                onSlideCompleted: () {
                                                  ref
                                                      .read(
                                                          orderProcessUpdaterProvider
                                                              .notifier)
                                                      .updateOrderProcess(
                                                        orderId: details.id,
                                                        status: getNextStatus(
                                                            status: details
                                                                .pickAndDelivaryStatus),
                                                      );
                                                },
                                              );
                                            },
                                          ),
                                  SizedBox(height: 20.h),
                                  details.pickAndDelivaryStatus == 'Success' ||
                                          details.pickAndDelivaryStatus ==
                                              'Failed' ||
                                          details.pickAndDelivaryStatus ==
                                              'Pending'
                                      ? const SizedBox.shrink()
                                      : ref
                                          .watch(orderProcessUpdaterProvider)
                                          .map(
                                            initial: (value) => OutlinedButton(
                                              style: ButtonStyle(
                                                  side:
                                                      MaterialStateProperty.all(
                                                    const BorderSide(
                                                        color: Colors.red,
                                                        width:
                                                            1.0), // Set the border color and width
                                                  ),
                                                  minimumSize:
                                                      MaterialStateProperty.all(
                                                    Size.fromHeight(45.h),
                                                  )),
                                              onPressed: () => showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    _buildCancelReasonDialog(
                                                        ref: ref,
                                                        orderId: details.id),
                                              ),
                                              child: Text(
                                                'Fail',
                                                style: AppTextDecor
                                                    .osBold14black
                                                    .copyWith(
                                                        fontSize: 18,
                                                        color: AppColors.red),
                                              ),
                                            ),
                                            loading: (_) =>
                                                const SizedBox.shrink(),
                                            loaded: (_) =>
                                                const SizedBox.shrink(),
                                            error: (error) => OutlinedButton(
                                              style: ButtonStyle(
                                                side: MaterialStateProperty.all(
                                                  const BorderSide(
                                                      color: Colors.red,
                                                      width:
                                                          1.0), // Set the border color and width
                                                ),
                                                minimumSize:
                                                    MaterialStateProperty.all(
                                                  Size.fromHeight(45.h),
                                                ),
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        _buildCancelReasonDialog(
                                                            ref: ref,
                                                            orderId:
                                                                details.id));
                                              },
                                              child: Text(
                                                'Fail',
                                                style: AppTextDecor
                                                    .osBold14black
                                                    .copyWith(
                                                        fontSize: 18,
                                                        color: AppColors.red),
                                              ),
                                            ),
                                          )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      error: (error) => _handleDialogError(ref, error),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _handleDialogError(WidgetRef ref, String error) {
    Future.delayed(AppDurConst.buildDuration).then((_) {
      // ref.refresh(acceptOrderProvider);
    });
    return ErrorTextWidget(error: error);
  }

  // void makePhoneCall(String phoneNumber) async {
  //   final Uri launchUri = Uri(
  //     scheme: 'tel',
  //     path: phoneNumber,
  //   );
  //   await launchUrl(launchUri);
  // }

  Future<List<Location>> getLatLngFromAddress({required String address}) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        double lat = locations.first.latitude;
        double lng = locations.first.longitude;
        print('Latitude: $lat, Longitude: $lng');
      } else {
        print('No coordinates found for the given address.');
      }
      return locations;
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      EasyLoading.showError('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        EasyLoading.showError('Location permissions are denied.');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      EasyLoading.showError(
          'Location permissions are permanently denied, we cannot request permissions.');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When permission are granted, get the current position
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> launchGoogleMaps(
      {required double lat, required double lng}) async {
    try {
      // Get current position
      final position = await getCurrentLocation();
      double currentLat = position.latitude;
      double currentLng = position.longitude;

      // Create a Google Maps URL
      String googleMapsUrl =
          'https://www.google.com/maps/dir/?api=1&origin=$currentLat,$currentLng&destination=$lat,$lng&travelmode=driving';

      // Launch the Google Maps app
      if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
        await launchUrl(Uri.parse(googleMapsUrl),
            mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $googleMapsUrl';
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  String getNextStatus({required String? status}) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return 'Confirme';
      case 'confirmed':
        return 'Started';
      case 'started':
        return 'Arrived';
      case 'arrived':
        return 'Success';
      default:
        return 'Unknown';
    }
  }

  Widget _buildCancelReasonDialog({
    required WidgetRef ref,
    required int? orderId,
  }) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.white,
        ),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormBuilderTextField(
                autofocus: true,
                name: 'instructions',
                minLines: 4,
                maxLines: 4,
                controller: _failureNoteController,
                decoration: AppInputDecor.loginPageInputDecor.copyWith(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: const BorderSide(color: AppColors.gray),
                  ),
                  hintText: 'Write a reason for cancellation',
                  enabled: true,
                  errorMaxLines: 2,
                ),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minWordsCount(6),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              AppTextButton(
                title: 'Submit',
                buttonColor: AppColors.goldenButton,
                titleColor: AppColors.white,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    ref
                        .read(orderProcessUpdaterProvider.notifier)
                        .updateOrderProcess(
                          orderId: orderId,
                          status: 'Failed',
                          note: _failureNoteController.text,
                        );
                    Navigator.pop(ContextLess.context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _showSmsBottomSheet({
  required BuildContext context,
  required WidgetRef ref,
  required TextEditingController controller,
  required String number,
  required GlobalKey<FormBuilderState> formKey,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Consumer(builder: (context, WidgetRef ref, child) {
        return FormBuilder(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // Adjust for the keyboard
            ),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                // height: 300.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    Text(
                      'Send SMS',
                      style: AppTextDecor.osBold18black,
                    ),
                    SizedBox(height: 24.h),
                    FormBuilderTextField(
                      maxLines: 3,
                      controller: controller,
                      name: 'test',
                      decoration: AppInputDecor.loginPageInputDecor.copyWith(
                        hintText: 'Enter your message',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()],
                      ),
                    ),
                    SizedBox(height: 40.h),
                    ref.watch(sendSmsProvider).map(
                          initial: (value) {
                            return AppTextButton(
                              title: "Send",
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  ref.read(sendSmsProvider.notifier).sendSms(
                                        number: number,
                                        message: controller.text,
                                      );
                                }
                              },
                            );
                          },
                          loaded: (data) {
                            Future.delayed(const Duration(milliseconds: 500))
                                .then((value) {
                              ref.refresh(sendSmsProvider);
                              controller.clear();
                            });
                            return const MessageTextWidget(
                              msg: 'Success',
                            );
                          },
                          error: (_) {
                            Future.delayed(const Duration(milliseconds: 500))
                                .then((value) {
                              ref.refresh(sendSmsProvider);
                            });
                            EasyLoading.showError(_.error);
                            return const SizedBox.shrink();
                          },
                          loading: (_) => const LoadingWidget(),
                        )
                  ],
                ),
              ),
            ),
          ),
        );
      });
    },
  );
}
