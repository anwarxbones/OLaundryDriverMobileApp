import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:laundry_customer/constants/app_colors.dart';
import 'package:laundry_customer/constants/app_text_decor.dart';
import 'package:laundry_customer/constants/input_field_decorations.dart';
import 'package:laundry_customer/generated/l10n.dart';
import 'package:laundry_customer/misc/misc_global_variables.dart';
import 'package:laundry_customer/models/schedule_model.dart';
import 'package:laundry_customer/providers/misc_providers.dart';
import 'package:laundry_customer/providers/quick_order_provider.dart';
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
          title: Text(
            S.of(context).quickOrder,
          ),
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
              Text(
                S.of(context).pickupSchedule,
                style: AppTextDecor.osBold14black,
              ),
              AppSpacerH(16.h),
              FormBuilderTextField(
                focusNode: fNodes[0],
                onTap: () {
                  ContextLess.context.nav
                      .pushNamed(Routes.schedulePickerScreen);
                },
                readOnly: true,
                name: 'scheduled_date',
                decoration: AppInputDecor.loginPageInputDecor
                    .copyWith(
                      hintText: S.of(context).pickupDate,
                    )
                    .copyWith(
                      suffixIcon: const Icon(Icons.calendar_month),
                    ),
                validator: FormBuilderValidators.required(),
                onChanged: (value) {},
              ),
              AppSpacerH(16.h),
              FormBuilderTextField(
                focusNode: fNodes[1],
                onTap: () {},
                readOnly: true,
                name: 'scheduled_time',
                decoration: AppInputDecor.loginPageInputDecor.copyWith(
                  hintText: S.of(context).pickupTime,
                ),
                validator: FormBuilderValidators.required(),
                onChanged: (value) {},
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButtonWidget() {
    return Consumer(
      builder: (context, ref, _) {
        return Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: ref.watch(quickOrderProvder).map(
                initial: (_) => AppTextButton(
                  title: S.of(context).placeOrder,
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState?.save();
                      ref
                          .read(quickOrderProvder.notifier)
                          .placeQuickOrder(_formkey.currentState!.value);
                    }
                  },
                ),
                loading: (_) => const LoadingWidget(),
                loaded: (data) {
                  Future.delayed(transissionDuration).then((value) {
                    EasyLoading.showSuccess(data.data.message);
                    ref.refresh(quickOrderProvder);
                    context.nav.pop();
                  });
                  return null;
                },
                error: (error) => ErrorTextWidget(error: error.error),
              ),
        );
      },
    );
  }

  void _setDateTime(ScheduleModel? data) {
    if (data != null) {
      _formkey.currentState?.fields['scheduled_date']
          ?.didChange(DateFormat('yyyy-MM-dd').format(data.dateTime));

      _formkey.currentState?.fields['scheduled_time']
          ?.didChange(data.schedule.title);
    }
  }
}
