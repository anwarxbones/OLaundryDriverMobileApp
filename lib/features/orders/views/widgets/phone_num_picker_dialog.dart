// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:o_driver/constants/app_colors.dart';
import 'package:o_driver/constants/input_field_decorations.dart';
import 'package:o_driver/features/orders/logic/order_provider.dart';
import 'package:o_driver/widgets/buttons/full_width_button.dart';
import 'package:o_driver/widgets/misc_widgets.dart';

class PhoneNumPickerDialog extends ConsumerWidget {
  final int orderId;
  const PhoneNumPickerDialog({
    super.key,
    required this.orderId,
  });
  static final GlobalKey<FormBuilderState> _formKey =
      GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      insetPadding: EdgeInsets.all(20.sp),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.sp),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormBuilderTextField(
                name: 'phone',
                decoration: AppInputDecor.loginPageInputDecor.copyWith(
                  hintText: 'Phone',
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(),
                  ],
                ),
              ),
              AppSpacerH(20.h),
              AppTextButton(
                buttonColor: AppColors.goldenButton,
                title: 'Okay',
                onTap: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.saveAndValidate()) {
                    _formKey.currentState?.save();
                    ref.read(makeCallProvider.notifier).makeCall(
                        orderId: orderId,
                        number: _formKey.currentState?.value['phone']);
                  }

                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
