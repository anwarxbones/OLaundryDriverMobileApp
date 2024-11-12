import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:o_driver/constants/app_colors.dart';
import 'package:o_driver/constants/app_durations.dart';
import 'package:o_driver/constants/app_text_decor.dart';
import 'package:o_driver/constants/input_field_decorations.dart';
import 'package:o_driver/features/auth/logic/auth_provider.dart';
import 'package:o_driver/features/auth/views/login_screen_wrapper.dart';
import 'package:o_driver/utils/context_less_nav.dart';
import 'package:o_driver/utils/routes.dart';
import 'package:o_driver/widgets/buttons/full_width_button.dart';
import 'package:o_driver/widgets/misc_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final List<FocusNode> fNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];
  final GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();
  bool obsecureText = true;
  bool obsecure2Text = true;

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
      child: FormBuilder(
        key: _formkey,
        child: SizedBox(
          height: 812.h,
          width: 375.w,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView(
              padding: EdgeInsets.zero,
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
                AppSpacerH(33.h),
                FormBuilderTextField(
                  focusNode: fNodes[0],
                  name: 'first_name',
                  decoration: AppInputDecor.loginPageInputDecor.copyWith(
                    hintText: 'First Name',
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                AppSpacerH(20.h),
                FormBuilderTextField(
                  focusNode: fNodes[1],
                  name: 'last_name',
                  decoration: AppInputDecor.loginPageInputDecor.copyWith(
                    hintText: 'Last Name',
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                AppSpacerH(20.h),
                FormBuilderTextField(
                  focusNode: fNodes[2],
                  name: 'email',
                  decoration: AppInputDecor.loginPageInputDecor.copyWith(
                    hintText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                AppSpacerH(20.h),
                FormBuilderTextField(
                  focusNode: fNodes[3],
                  name: 'mobile',
                  decoration: AppInputDecor.loginPageInputDecor.copyWith(
                    hintText: 'phone',
                  ),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                AppSpacerH(20.h),
                FormBuilderTextField(
                  focusNode: fNodes[4],
                  name: 'password',
                  obscureText: obsecureText,
                  decoration: AppInputDecor.loginPageInputDecor.copyWith(
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
                FormBuilderTextField(
                  focusNode: fNodes[5],
                  name: 'password_confirmation',
                  obscureText: obsecure2Text,
                  decoration: AppInputDecor.loginPageInputDecor.copyWith(
                    hintText: 'Confirm Password',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          obsecure2Text = !obsecure2Text;
                        });
                      },
                      child: Icon(
                        obsecure2Text
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
                      return ref.watch(registerProvider).map(
                            error: (_) {
                              Future.delayed(AppDurConst.buildDuration)
                                  .then((value) {
                                ref.refresh(registerProvider);
                              });
                              return ErrorTextWidget(error: _.error);
                            },
                            loaded: (_) {
                              Future.delayed(AppDurConst.buildDuration)
                                  .then((value) {
                                context.nav.pushNamedAndRemoveUntil(
                                  Routes.signUpSuccessScreen,
                                  (route) => false,
                                );
                              });

                              return const MessageTextWidget(
                                msg: 'Success',
                              );
                            },
                            initial: (_) => AppTextButton(
                              buttonColor: AppColors.goldenButton,
                              title: 'Register',
                              titleColor: AppColors.white,
                              onTap: () {
                                // Future.delayed(const Duration(milliseconds: 50),
                                //     () {
                                //   EasyLoading.showInfo(
                                //       "This page are only available only for live version",
                                //       duration: const Duration(seconds: 5));
                                // });
                                for (final element in fNodes) {
                                  if (element.hasFocus) {
                                    element.unfocus();
                                  }
                                }
                                if (_formkey.currentState != null &&
                                    _formkey.currentState!.saveAndValidate()) {
                                  final formData = _formkey.currentState!.value;

                                  ref
                                      .watch(registerProvider.notifier)
                                      .register(data: formData);
                                }
                              },
                            ),
                            loading: (_) => const LoadingWidget(),
                          );
                    },
                  ),
                ),
                AppSpacerH(20.h),
                GestureDetector(
                  onTap: () {
                    context.nav.pushNamed(Routes.loginScreen);
                  },
                  child: Text("Already have an account? Login",
                      style: AppTextDecor.osBold18black),
                ),
                AppSpacerH(50.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
