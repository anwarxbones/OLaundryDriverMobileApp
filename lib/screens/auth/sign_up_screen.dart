import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:laundry_customer/constants/app_colors.dart';
import 'package:laundry_customer/constants/app_text_decor.dart';
import 'package:laundry_customer/constants/hive_contants.dart';
import 'package:laundry_customer/constants/input_field_decorations.dart';
import 'package:laundry_customer/generated/l10n.dart';
import 'package:laundry_customer/misc/misc_global_variables.dart';
import 'package:laundry_customer/providers/auth_provider.dart';
import 'package:laundry_customer/providers/settings_provider.dart';
import 'package:laundry_customer/screens/auth/login_screen_wrapper.dart';
import 'package:laundry_customer/utils/context_less_nav.dart';
import 'package:laundry_customer/utils/routes.dart';
import 'package:laundry_customer/widgets/buttons/full_width_button.dart';
import 'package:laundry_customer/widgets/misc_widgets.dart';

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
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  final GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();
  bool obsecureText = true;
  bool obsecureTextTwo = true;
  bool shouldRemember = false;
  @override
  void initState() {
    super.initState();
    for (final element in fNodes) {
      if (element.hasFocus) {
        element.unfocus();
      }
    }
  }

  String validationError({required String fieldName}) {
    return '$fieldName field cannot be empty!';
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreenWrapper(
      child: FormBuilder(
        key: _formkey,
        child: SizedBox(
          height: 812.h,
          width: 375.w,
          child: Stack(
            children: [
              SizedBox(
                height: 230.h,
                width: 375.w,
                child: Center(
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 100.h,
                      width: 195.w,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 170,
                child: Container(
                  height: 642.h,
                  width: 375.w,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ListView(
                    children: [
                      AppSpacerH(33.h),
                      FormBuilderTextField(
                        focusNode: fNodes[0],
                        name: 'first_name',
                        decoration: AppInputDecor.loginPageInputDecor.copyWith(
                          hintText: 'First Name',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(
                              errorText:
                                  validationError(fieldName: 'First Name'),
                            ),
                          ],
                        ),
                      ),
                      AppSpacerH(20.h),
                      FormBuilderTextField(
                        focusNode: fNodes[1],
                        name: 'last_name',
                        decoration: AppInputDecor.loginPageInputDecor.copyWith(
                          hintText: "Last Name",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(
                              errorText:
                                  validationError(fieldName: 'First Name'),
                            ),
                          ],
                        ),
                      ),
                      AppSpacerH(20.h),
                      FormBuilderTextField(
                        focusNode: fNodes[2],
                        name: 'business_name',
                        decoration: AppInputDecor.loginPageInputDecor.copyWith(
                          hintText: "Business Name",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      AppSpacerH(20.h),
                      FormBuilderTextField(
                        focusNode: fNodes[3],
                        name: 'email',
                        decoration: AppInputDecor.loginPageInputDecor.copyWith(
                          hintText: S.of(context).email,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.email(),
                            FormBuilderValidators.required(
                              errorText: validationError(fieldName: 'Email'),
                            ),
                          ],
                        ),
                      ),
                      AppSpacerH(20.h),
                      FormBuilderTextField(
                        focusNode: fNodes[4],
                        name: 'mobile',
                        decoration: AppInputDecor.loginPageInputDecor.copyWith(
                          hintText: S.of(context).phoneNumber,
                        ),
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(
                              errorText: validationError(fieldName: 'Mobile'),
                            ),
                            FormBuilderValidators.maxLength(13),
                            FormBuilderValidators.minLength(10),
                          ],
                        ),
                      ),
                      AppSpacerH(20.h),
                      GestureDetector(
                        onTap: () {
                          _selectDate(context).then((value) {
                            if (value != null) {
                              final String date =
                                  DateFormat('MM/dd/yyyy').format(value);
                              fNodes[5].requestFocus();
                              _formkey.currentState!.fields['date_of_birth']!
                                  .didChange(date);
                            }
                          });
                        },
                        child: FormBuilderTextField(
                          enabled: false,
                          focusNode: fNodes[5],
                          name: 'date_of_birth',
                          decoration:
                              AppInputDecor.loginPageInputDecor.copyWith(
                            hintText: 'Date Of Birth',
                          ),
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(
                                errorText:
                                    validationError(fieldName: 'Date Of Birth'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AppSpacerH(20.h),
                      FormBuilderTextField(
                        focusNode: fNodes[6],
                        name: 'city',
                        decoration: AppInputDecor.loginPageInputDecor.copyWith(
                          hintText: 'City',
                        ),
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(
                              errorText: validationError(fieldName: 'City'),
                            ),
                          ],
                        ),
                      ),
                      AppSpacerH(20.h),
                      FormBuilderTextField(
                        focusNode: fNodes[7],
                        name: 'state',
                        decoration: AppInputDecor.loginPageInputDecor.copyWith(
                          hintText: 'State',
                        ),
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(
                              errorText: validationError(fieldName: 'State'),
                            ),
                          ],
                        ),
                      ),
                      AppSpacerH(20.h),
                      FormBuilderTextField(
                        focusNode: fNodes[8],
                        name: 'zip_code',
                        decoration: AppInputDecor.loginPageInputDecor.copyWith(
                          hintText: 'Zip Code',
                        ),
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(
                              errorText: validationError(fieldName: 'Zip Code'),
                            ),
                          ],
                        ),
                      ),
                      AppSpacerH(20.h),
                      FormBuilderTextField(
                        focusNode: fNodes[9],
                        name: 'address_line',
                        decoration: AppInputDecor.loginPageInputDecor.copyWith(
                          hintText: 'Address 1',
                        ),
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(
                              errorText:
                                  validationError(fieldName: 'Addresss 1'),
                            ),
                          ],
                        ),
                      ),
                      AppSpacerH(20.h),
                      FormBuilderTextField(
                        focusNode: fNodes[10],
                        name: 'address_line2',
                        decoration: AppInputDecor.loginPageInputDecor.copyWith(
                          hintText: 'Address 2',
                        ),
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(
                              errorText:
                                  validationError(fieldName: 'Addresss 2'),
                            ),
                          ],
                        ),
                      ),
                      AppSpacerH(20.h),
                      FormBuilderTextField(
                        focusNode: fNodes[11],
                        name: 'password',
                        obscureText: obsecureText,
                        decoration: AppInputDecor.loginPageInputDecor.copyWith(
                          hintText: S.of(context).createPassword,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obsecureText = !obsecureText;
                              });
                            },
                            child: Icon(
                              obsecureText
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(
                              errorText: validationError(fieldName: 'Password'),
                            ),
                          ],
                        ),
                      ),
                      AppSpacerH(20.h),
                      FormBuilderTextField(
                        focusNode: fNodes[12],
                        name: 'password_confirmation',
                        obscureText: obsecureTextTwo,
                        decoration: AppInputDecor.loginPageInputDecor.copyWith(
                          hintText: S.of(context).confirmPassword,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obsecureTextTwo = !obsecureTextTwo;
                              });
                            },
                            child: Icon(
                              obsecureTextTwo
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(
                              errorText: validationError(
                                fieldName: 'Confirm Password',
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppSpacerH(20.h),
                      SizedBox(
                        width: 335.w,
                        child: Wrap(
                          runSpacing: 10.h,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  shouldRemember = !shouldRemember;
                                });
                              },
                              child: SvgPicture.asset(
                                shouldRemember
                                    ? 'assets/svgs/icon_selection_ticked.svg'
                                    : 'assets/svgs/icon_selection_unticked.svg',
                                semanticsLabel: 'Top Logo',
                                height: 17.h,
                                width: 17.w,
                              ),
                            ),
                            AppSpacerW(6.w),
                            Text(
                              '${S.of(context).iAcceptAndAgreeToThe} ',
                              style: AppTextDecor.osRegular12black,
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Consumer(
                                        builder: (context, ref, child) {
                                          ref.watch(tosProvider);
                                          // ignore: use_decorated_box
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                20.h,
                                              ),
                                            ),
                                            child: ref.watch(tosProvider).map(
                                                  initial: (_) =>
                                                      const SizedBox(),
                                                  loading: (_) =>
                                                      const LoadingWidget(),
                                                  loaded: (_) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                      10.0,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          _.data.data!.setting!
                                                              .title!,
                                                          style: AppTextDecor
                                                              .osBold24black,
                                                        ),
                                                        const AppSpacerH(20),
                                                        Expanded(
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Html(
                                                              style: {
                                                                '*': Style(
                                                                  color: AppColors
                                                                      .navyText,
                                                                  fontSize:
                                                                      FontSize(
                                                                    14.sp,
                                                                  ),
                                                                  fontFamily:
                                                                      'Open Sans',
                                                                ),
                                                              },
                                                              data:
                                                                  '${_.data.data!.setting!.content!}<p></p><p></p><p></p><p></p><p></p>',
                                                            ),
                                                          ),
                                                        ),
                                                        AppTextButton(
                                                          title: S
                                                              .of(context)
                                                              .okay,
                                                          onTap: () {
                                                            context.nav.pop();
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  error: (_) => ErrorTextWidget(
                                                    error: _.error,
                                                  ),
                                                ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text(
                                '${S.of(context).termsAndConditions} ',
                                style: AppTextDecor.osBold12gold,
                              ),
                            ),
                            Text(
                              '${S.of(context).and} ',
                              style: AppTextDecor.osRegular12black,
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Consumer(
                                        builder: (context, ref, child) {
                                          ref.watch(privacyProvider);
                                          // ignore: use_decorated_box
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                20.h,
                                              ),
                                            ),
                                            child: ref
                                                .watch(privacyProvider)
                                                .map(
                                                  initial: (_) =>
                                                      const SizedBox(),
                                                  loading: (_) =>
                                                      const LoadingWidget(),
                                                  loaded: (_) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                      10.0,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          _.data.data!.setting!
                                                              .title!,
                                                          style: AppTextDecor
                                                              .osBold24black,
                                                        ),
                                                        const AppSpacerH(20),
                                                        Expanded(
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Html(
                                                              style: {
                                                                '*': Style(
                                                                  color: AppColors
                                                                      .navyText,
                                                                  fontSize:
                                                                      FontSize(
                                                                    14.sp,
                                                                  ),
                                                                  fontFamily:
                                                                      'Open Sans',
                                                                ),
                                                              },
                                                              data:
                                                                  '${_.data.data!.setting!.content!}<p></p><p></p><p></p><p></p><p></p>',
                                                            ),
                                                          ),
                                                        ),
                                                        AppTextButton(
                                                          title: S
                                                              .of(context)
                                                              .okay,
                                                          onTap: () {
                                                            context.nav.pop();
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  error: (_) => ErrorTextWidget(
                                                    error: _.error,
                                                  ),
                                                ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text(
                                S.of(context).privacyPolicy,
                                style: AppTextDecor.osBold12gold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppSpacerH(60.h),
                      SizedBox(
                        height: 50.h,
                        child: Consumer(
                          builder: (context, ref, child) {
                            return ref.watch(registrationProvider).map(
                                  initial: (_) {
                                    return AppTextButton(
                                      buttonColor: AppColors.primary,
                                      title: S.of(context).signUp,
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
                                          if (shouldRemember) {
                                            ref
                                                .watch(
                                                  registrationProvider.notifier,
                                                )
                                                .register(
                                                  _formkey.currentState!.value,
                                                );
                                          } else {
                                            EasyLoading.showError(
                                              S
                                                  .of(context)
                                                  .acceptTermsAndConditions,
                                            );
                                          }
                                        }
                                      },
                                    );
                                  },
                                  loading: (_) => const LoadingWidget(),
                                  loaded: (_) {
                                    final Box box = Hive.box(
                                      AppHSC.authBox,
                                    ); //Stores Auth Data
                                    final Box userBox = Hive.box(
                                      AppHSC.userBox,
                                    ); //Stores User Data
                                    box.putAll(_.data.data!.access!.toMap());
                                    userBox.putAll(_.data.data!.user!.toMap());
                                    Future.delayed(transissionDuration)
                                        .then((value) {
                                      ref.refresh(
                                        registrationProvider,
                                      ); //Refresh This so That App Doesn't Auto Login

                                      Future.delayed(buildDuration)
                                          .then((value) {
                                        context.nav.pushNamed(
                                          Routes.signUpImageUpload,
                                        );
                                      });
                                    });
                                    return MessageTextWidget(
                                      msg: S.of(context).scs,
                                    );
                                  },
                                  error: (_) {
                                    Future.delayed(transissionDuration)
                                        .then((value) {
                                      ref.refresh(registrationProvider);
                                    });
                                    return ErrorTextWidget(error: _.error);
                                  },
                                );
                          },
                        ),
                      ),
                      AppSpacerH(77.h),
                      SizedBox(
                        height: 18.h,
                        width: 335.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${S.of(context).alreadyHaveAnAccount} ",
                              style: AppTextDecor.osRegular12black,
                            ),
                            GestureDetector(
                              onTap: () {
                                context.nav.pushNamed(Routes.loginScreen);
                              },
                              child: Text(
                                S.of(context).login,
                                style: AppTextDecor.osBold12gold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppSpacerH(44.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Pick the date of birth

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    return picked;
  }
}
