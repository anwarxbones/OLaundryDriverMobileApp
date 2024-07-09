import 'package:dry_cleaners_driver/constants/app_box_decoration.dart';
import 'package:dry_cleaners_driver/constants/app_colors.dart';
import 'package:dry_cleaners_driver/constants/app_durations.dart';
import 'package:dry_cleaners_driver/constants/app_text_decor.dart';
import 'package:dry_cleaners_driver/constants/input_field_decorations.dart';
import 'package:dry_cleaners_driver/features/profile/logic/profile_provider.dart';
import 'package:dry_cleaners_driver/utils/context_less_nav.dart';
import 'package:dry_cleaners_driver/widgets/buttons/full_width_button.dart';
import 'package:dry_cleaners_driver/widgets/misc_widgets.dart';
import 'package:dry_cleaners_driver/widgets/nav_bar.dart';
import 'package:dry_cleaners_driver/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EditPasswordScreen extends ConsumerStatefulWidget {
  const EditPasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditPasswordScreenState();
}

class _EditPasswordScreenState extends ConsumerState<EditPasswordScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        child: Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 12.h),
          decoration: AppBoxDecorations.topBar2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacerH(44.h),
              AppNavbar(
                  title: Center(
                    child: Text(
                      "Set Password",
                      style: AppTextDecor.osBold12black,
                    ),
                  ),
                  showBack: true),
            ],
          ),
        ),
        Expanded(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          color: AppColors.white,
          child: FormBuilder(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                AppSpacerH(10.h),
                EditPasswordTextField(
                  fieldName: 'current_password',
                  title: 'Old Password',
                  hintText: 'Enter your old password',
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                ),
                AppSpacerH(10.h),
                EditPasswordTextField(
                  fieldName: 'password',
                  title: 'Create New Password',
                  hintText: 'Enter your new password',
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                ),
                AppSpacerH(10.h),
                EditPasswordTextField(
                  fieldName: 'password_confirmation',
                  title: 'Confirm New Password',
                  hintText: 'Confirm your new password',
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                ),
                AppSpacerH(20.h),
                ref.watch(userPasswordUpdateProvider).map(
                    initial: (_) => AppTextButton(
                          title: 'Create Password',
                          onTap: () {
                            if (_formKey.currentState!.saveAndValidate()) {
                              var formFields = _formKey.currentState!.fields;
                              if (formFields['password']!.value ==
                                  formFields['password_confirmation']!.value) {
                                ref
                                    .watch(userPasswordUpdateProvider.notifier)
                                    .updatePassword(
                                        data: _formKey.currentState!.value);
                              } else {
                                EasyLoading.showError(
                                    "New Password And Password Confirmation Doesn't Match");
                              }
                            }
                          },
                        ),
                    loading: (_) => const LoadingWidget(),
                    loaded: (_) {
                      Future.delayed(AppDurConst.buildDuration).then((e) {
                        ref.refresh(userPasswordUpdateProvider);
                        ref.refresh(userDetailsProvider);
                        context.nav.pop();
                      });
                      return MessageTextWidget(msg: _.data);
                    },
                    error: (_) {
                      EasyLoading.showError(_.error);
                      Future.delayed(AppDurConst.twoSec).then((e) {
                        ref.refresh(userPasswordUpdateProvider);
                        ref.refresh(userDetailsProvider);
                      });
                      return ErrorTextWidget(error: _.error);
                    })
              ],
            ),
          ),
        ))
      ],
    ));
  }
}

class EditPasswordTextField extends StatefulWidget {
  const EditPasswordTextField({
    Key? key,
    required this.title,
    required this.fieldName,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    required this.hintText,
  }) : super(key: key);
  final String title;
  final String fieldName;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  State<EditPasswordTextField> createState() => _EditPasswordTextFieldState();
}

class _EditPasswordTextFieldState extends State<EditPasswordTextField> {
  bool showpass = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppTextDecor.osBold14black,
        ),
        AppSpacerH(10.h),
        FormBuilderTextField(
          name: widget.fieldName,
          obscureText: !showpass,
          decoration: AppInputDecor.editProfileInputDecor.copyWith(
              hintText: widget.hintText,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    showpass = !showpass;
                  });
                },
                child: Icon(
                  showpass ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.black,
                ),
              )),
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
        ),
      ],
    );
  }
}
