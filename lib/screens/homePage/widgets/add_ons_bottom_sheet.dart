import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:laundry_customer/constants/app_colors.dart';
import 'package:laundry_customer/constants/app_text_decor.dart';
import 'package:laundry_customer/constants/input_field_decorations.dart';
import 'package:laundry_customer/generated/l10n.dart';
import 'package:laundry_customer/misc/global_functions.dart';
import 'package:laundry_customer/models/cart/add_ons_model.dart';
import 'package:laundry_customer/models/cart/cart_model.dart';
import 'package:laundry_customer/models/product/product_mode.dart';
import 'package:laundry_customer/services/local_service.dart';
import 'package:laundry_customer/utils/context_less_nav.dart';
import 'package:laundry_customer/widgets/buttons/full_width_button.dart';
import 'package:laundry_customer/widgets/misc_widgets.dart';

class AddOnsBottomSheet extends StatefulWidget {
  final bool isUpdate;
  final ProductModel product;
  final CartModel? cartModel;
  const AddOnsBottomSheet({
    super.key,
    required this.product,
    required this.cartModel,
    this.isUpdate = false,
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

  final Set<AddOns> _addOns = {};

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.cartModel != null) {
        setState(() {
          _addOns.addAll(widget.cartModel!.addOns);
        });
      }
    });
  }

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
        child: SingleChildScrollView(
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
                initialValue: widget.cartModel?.quantity.toStringAsFixed(
                  AppGFunctions.isPerPiece(widget.cartModel?.soldBy ?? '')
                      ? 0
                      : 2,
                ),
                decoration: AppInputDecor.loginPageInputDecor.copyWith(
                  hintText: S.of(context).quantity,
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                    if (AppGFunctions.isPerPiece(widget.product.soldBy))
                      FormBuilderValidators.integer(),
                  ],
                ),
              ),
              AppSpacerH(24.h),
              Text(S.of(context).addOns),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.product.subProducts.length,
                itemBuilder: (context, index) => _buildAddOnsWidget(
                  subProduct: widget.product.subProducts[index],
                ),
              ),
              AppSpacerH(12.h),
              FormBuilderTextField(
                initialValue: widget.cartModel?.note,
                focusNode: fNodes[1],
                name: 'note',
                maxLines: 3,
                decoration: AppInputDecor.loginPageInputDecor.copyWith(
                  hintText: S.of(context).note,
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
                    child: widget.isUpdate
                        ? AppTextButton(
                            title: S.of(context).delete,
                            buttonColor: AppColors.red,
                            titleColor: AppColors.white,
                            onTap: () {
                              LocalService().deleteProduct(
                                productId: widget.cartModel!.productId,
                              );
                              context.nav.pop();
                            },
                          )
                        : AppTextButton(
                            title: S.of(context).close,
                            buttonColor: AppColors.grayBG,
                            titleColor: AppColors.black,
                            onTap: () => context.nav.pop(),
                          ),
                  ),
                  AppSpacerW(10.w),
                  Flexible(
                    child: AppTextButton(
                      title: widget.isUpdate
                          ? S.of(context).update
                          : S.of(context).addToCart,
                      onTap: () {
                        _unfocus();
                        if (_formkey.currentState!.saveAndValidate()) {
                          final CartModel cartModel = CartModel(
                            productId: widget.product.productId,
                            name: widget.product.productName,
                            image: widget.product.image,
                            categoryName: widget.product.categoryName,
                            discountPercentage:
                                widget.product.discountPercentage,
                            quantity: double.parse(
                              _formkey.currentState!.fields['quantity']!.value
                                  as String,
                            ),
                            price: widget.product.price,
                            note: _formkey.currentState?.fields['note']?.value
                                as String?,
                            addOns: _addOns.toList(),
                            soldBy: widget.product.soldBy,
                          );
                          LocalService().addToCart(cartModel: cartModel);
                          context.nav.pop();
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
      ),
    );
  }

  Widget _buildAddOnsWidget({required SubProduct subProduct}) {
    return Row(
      children: [
        Checkbox(
          visualDensity: VisualDensity.compact,
          value: _addOns.any((element) => element.id == subProduct.id),
          onChanged: (v) {
            setState(() {
              if (v!) {
                final AddOns addOns = AddOns(
                  id: subProduct.id,
                  price: subProduct.price,
                  name: subProduct.name,
                );
                _addOns.add(addOns);
              } else {
                _addOns.removeWhere((element) => element.id == subProduct.id);
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
