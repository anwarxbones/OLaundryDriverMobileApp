import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:laundry_customer/constants/app_colors.dart';
import 'package:laundry_customer/constants/app_text_decor.dart';
import 'package:laundry_customer/constants/input_field_decorations.dart';
import 'package:laundry_customer/models/schedule_model.dart';
import 'package:laundry_customer/providers/misc_providers.dart';
import 'package:laundry_customer/utils/context_less_nav.dart';
import 'package:laundry_customer/utils/routes.dart';
import 'package:laundry_customer/widgets/buttons/full_width_button.dart';
import 'package:laundry_customer/widgets/misc_widgets.dart';

class QuickOrder extends ConsumerWidget {
  QuickOrder({super.key});

  final List<FocusNode> fNodes = [FocusNode(), FocusNode()];
  final GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      onPopInvoked: (didPop) => ref.refresh(scheduleProvider('Pick Up')),
      child: Scaffold(
        backgroundColor: AppColors.lightgray,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: const Text('Quick Order'),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return FormBuilder(
      key: _formkey,
      child: Column(
        children: [
          AppSpacerH(12.h),
          _buildPickupScheduleWidget(),
          AppSpacerH(12.h),
          _buildButtonWidget(),
        ],
      ),
    );
  }

  Widget _buildPickupScheduleWidget() {
    return Consumer(
      builder: (context, ref, _) {
        final ScheduleModel? data = ref.watch(scheduleProvider('Pick Up'));
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _setDateTime(data);
        });
        return Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pick-up Schedule', style: AppTextDecor.osBold14black),
              AppSpacerH(16.h),
              FormBuilderTextField(
                focusNode: fNodes[0],
                onTap: () {
                  ContextLess.context.nav
                      .pushNamed(Routes.schedulePickerScreen);
                },
                readOnly: true,
                name: 'pick_up_date',
                decoration: AppInputDecor.loginPageInputDecor
                    .copyWith(
                      hintText: 'Pick-up Date',
                    )
                    .copyWith(
                      suffixIcon: const Icon(Icons.calendar_month),
                    ),
                onChanged: (value) {},
              ),
              AppSpacerH(16.h),
              FormBuilderTextField(
                focusNode: fNodes[1],
                onTap: () {},
                readOnly: true,
                name: 'pick_up_time',
                decoration: AppInputDecor.loginPageInputDecor.copyWith(
                  hintText: 'Pick-up Time',
                ),
                onChanged: (value) {},
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButtonWidget() {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: AppTextButton(
        title: 'Place Order',
        onTap: () {},
      ),
    );
  }

  void _setDateTime(ScheduleModel? data) {
    if (data != null) {
      _formkey.currentState?.fields['pick_up_date']
          ?.didChange(DateFormat('dd/MM/yyyy').format(data.dateTime));

      _formkey.currentState?.fields['pick_up_time']
          ?.didChange(data.schedule.title);
    }
  }
}
