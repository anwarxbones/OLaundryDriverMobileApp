import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:o_driver/constants/app_colors.dart';
import 'package:o_driver/constants/app_durations.dart';
import 'package:o_driver/constants/hive_contants.dart';
import 'package:o_driver/constants/input_field_decorations.dart';
import 'package:o_driver/features/auth/logic/auth_provider.dart';
import 'package:o_driver/features/auth/views/login_screen_wrapper.dart';
import 'package:o_driver/features/notfications/logic/notifications_providers.dart';
import 'package:o_driver/features/orders/logic/order_provider.dart';
import 'package:o_driver/features/profile/logic/profile_provider.dart';
import 'package:o_driver/utils/context_less_nav.dart';
import 'package:o_driver/utils/routes.dart';
import 'package:o_driver/widgets/buttons/full_width_button.dart';
import 'package:o_driver/widgets/misc_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<FocusNode> fNodes = [FocusNode(), FocusNode()];
  final GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();
  bool obsecureText = true;

  @override
  void initState() {
    super.initState();
    for (final element in fNodes) {
      if (element.hasFocus) {
        element.unfocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreenWrapper(
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formkey,
          child: SizedBox(
            height: 812.h,
            width: 375.w,
            child: Column(
              children: [
                SizedBox(
                  height: 230.h,
                  width: 375.w,
                  child: Center(
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/images/driver_app_top_logo.png',
                        height: 150.h,
                        width: 150.h,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    // height: 582.h,
                    // width: 375.w,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        AppSpacerH(33.h),
                        FormBuilderTextField(
                          focusNode: fNodes[0],
                          name: 'email',
                          decoration:
                              AppInputDecor.loginPageInputDecor.copyWith(
                            hintText: 'Email or phone',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()],
                          ),
                        ),
                        AppSpacerH(20.h),
                        FormBuilderTextField(
                          focusNode: fNodes[1],
                          name: 'password',
                          obscureText: obsecureText,
                          decoration:
                              AppInputDecor.loginPageInputDecor.copyWith(
                            hintText: 'Password',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obsecureText = !obsecureText;
                                });
                              },
                              child: Icon(
                                obsecureText
                                    ? Icons.visibility
                                    : Icons.visibility_off_outlined,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()],
                          ),
                        ),
                        AppSpacerH(20.h),
                        AppSpacerH(40.h),
                        SizedBox(
                          height: 50.h,
                          child: Consumer(
                            builder: (context, WidgetRef ref, child) {
                              return ref.watch(loginProvider).map(
                                    error: (_) {
                                      Future.delayed(AppDurConst.buildDuration)
                                          .then((value) {
                                        ref.refresh(loginProvider);
                                      });
                                      EasyLoading.showError(_.error);
                                      return const SizedBox.shrink();
                                    },
                                    loaded: (_) {
                                      final Box box = Hive.box(
                                        AppHSC.authBox,
                                      ); //Stores Auth Data
                                      final Box userBox = Hive.box(
                                        AppHSC.userBox,
                                      ); //Stores User Data
                                      box.putAll(_.data.data!.access!.toMap());
                                      userBox
                                          .putAll(_.data.data!.user!.toMap());
                                      Future.delayed(AppDurConst.buildDuration)
                                          .then((value) {
                                        ref.refresh(
                                          loginProvider,
                                        ); //Refresh This so That App Doesn't Auto Login
                                        //Refresh All Data
                                        ref.refresh(userDetailsProvider);

                                        ref.refresh(orderHistoriesProvider);
                                        ref.refresh(
                                            todaysPendingOrderListProvider);
                                        ref.refresh(todaysJobListProvider);
                                        ref.refresh(acceptOrderProvider);
                                        ref.refresh(
                                            thisWeekDeliveryListProvider);
                                        ref.refresh(orderUpdateProvider);
                                        ref.refresh(allNotificationsProvider);
                                        ref.refresh(userDetailsProvider);
                                        ref.refresh(userProfileUpdateProvider);
                                        ref.refresh(userPasswordUpdateProvider);

                                        Future.delayed(
                                                AppDurConst.buildDuration)
                                            .then((value) {
                                          context.nav.pushNamedAndRemoveUntil(
                                            Routes.homePage,
                                            (route) => false,
                                          );
                                        });
                                      });
                                      return const MessageTextWidget(
                                        msg: 'Success',
                                      );
                                    },
                                    initial: (_) => AppTextButton(
                                      buttonColor: AppColors.goldenButton,
                                      title: 'Login',
                                      titleColor: AppColors.white,
                                      onTap: () {
                                        for (final element in fNodes) {
                                          if (element.hasFocus) {
                                            element.unfocus();
                                          }
                                        }
                                        if (_formkey.currentState != null &&
                                            _formkey.currentState!
                                                .saveAndValidate()) {
                                          final formData =
                                              _formkey.currentState!.fields;
                                          ref
                                              .watch(loginProvider.notifier)
                                              .login(
                                                contact: formData['email']!
                                                    .value as String,
                                                password: formData['password']!
                                                    .value as String,
                                              );
                                        }
                                      },
                                    ),
                                    loading: (_) => const LoadingWidget(),
                                  );
                            },
                          ),
                        ),
                        AppSpacerH(20.h),
                        // GestureDetector(
                        //   onTap: () {
                        //     context.nav.pushNamed(Routes.signUpScreen);
                        //   },
                        //   child: Text("Don't have an account? Sign Up",
                        //       style: AppTextDecor.osBold14black),
                        // ),
                        const Expanded(child: SizedBox())
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
