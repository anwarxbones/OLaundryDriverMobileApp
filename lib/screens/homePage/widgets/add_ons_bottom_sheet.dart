import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:laundry_customer/constants/app_colors.dart';
import 'package:laundry_customer/constants/app_text_decor.dart';
import 'package:laundry_customer/constants/input_field_decorations.dart';
import 'package:laundry_customer/misc/global_functions.dart';
import 'package:laundry_customer/models/cart/cart_model.dart';
import 'package:laundry_customer/models/product/product_mode.dart';
import 'package:laundry_customer/utils/context_less_nav.dart';
import 'package:laundry_customer/widgets/buttons/full_width_button.dart';
import 'package:laundry_customer/widgets/misc_widgets.dart';

class AddOnsBottomSheet extends StatefulWidget {
  final ProductModel product;
  const AddOnsBottomSheet({
    super.key,
    required this.product,
  });

  @override
  State<AddOnsBottomSheet> createState() => _AddOnsBottomSheetState();
}

class _AddOnsBottomSheetState extends State<AddOnsBottomSheet> {
  final GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();

  final List<FocusNode> fNodes = [
    FocusNode(),
    FocusNode(),
  ];

  final Set<int> _addOns = {};

  @override
  @override
  void dispose() {
    _addOns.clear();
    _unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formkey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w)
            .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.productName,
                  style: AppTextDecor.osRegular14black
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: () => context.nav.pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(
              height: 0.5,
              color: AppColors.gray,
            ),
            AppSpacerH(24.h),
            FormBuilderTextField(
              focusNode: fNodes[0],
              name: 'quantity',
              decoration: AppInputDecor.loginPageInputDecor.copyWith(
                hintText: 'Quantity',
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ],
              ),
            ),
            AppSpacerH(24.h),
            const Text('Add-ons'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.product.subProducts.length,
              itemBuilder: (context, index) => _buildAddOnsWidget(
                subProduct: widget.product.subProducts[index],
              ),
            ),
            AppSpacerH(12.h),
            FormBuilderTextField(
              focusNode: fNodes[1],
              name: 'note',
              maxLines: 3,
              decoration: AppInputDecor.loginPageInputDecor.copyWith(
                hintText: 'Note',
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
            AppSpacerH(24.h),
            const Divider(
              height: 0.5,
              color: AppColors.gray,
            ),
            AppSpacerH(24.h),
            Row(
              children: [
                Flexible(
                  child: AppTextButton(
                    title: 'Close',
                    buttonColor: AppColors.grayBG,
                    titleColor: AppColors.black,
                    onTap: () => context.nav.pop(),
                  ),
                ),
                AppSpacerW(10.w),
                Flexible(
                  child: AppTextButton(
                    title: 'Add to Cart',
                    onTap: () {
                      _unfocus();
                      if (_formkey.currentState!.saveAndValidate()) {
                        final CartModel cartModel = CartModel(
                          productId: widget.product.productId,
                          quantity: int.parse(
                            _formkey.currentState!.fields['quantity']!.value
                                .toString(),
                          ),
                          note: _formkey.currentState?.fields['note']?.value
                              as String,
                          addOns: _addOns.toList(),
                        );
                        debugPrint(cartModel.toMap().toString());
                      }
                    },
                  ),
                ),
              ],
            ),
            AppSpacerH(24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAddOnsWidget({required SubProduct subProduct}) {
    return Row(
      children: [
        Checkbox(
          visualDensity: VisualDensity.compact,
          value: _addOns.contains(subProduct.id),
          onChanged: (v) {
            setState(() {
              if (v!) {
                _addOns.add(subProduct.id);
              } else {
                _addOns.remove(subProduct.id);
              }
            });
          },
          checkColor: AppColors.white,
          activeColor: AppColors.primary,
        ),
        Text(
          '${subProduct.name}: ${AppGFunctions.getCurrency()}${subProduct.price}',
        ),
      ],
    );
  }

  void _unfocus() {
    for (final element in fNodes) {
      if (element.hasFocus) {
        element.unfocus();
      }
    }
  }
}
