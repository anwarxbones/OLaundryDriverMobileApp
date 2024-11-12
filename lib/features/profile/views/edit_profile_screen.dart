import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:o_driver/constants/app_box_decoration.dart';
import 'package:o_driver/constants/app_colors.dart';
import 'package:o_driver/constants/app_durations.dart';
import 'package:o_driver/constants/app_text_decor.dart';
import 'package:o_driver/constants/input_field_decorations.dart';
import 'package:o_driver/features/auth/models/login_model/user.dart';
import 'package:o_driver/features/profile/logic/profile_provider.dart';
import 'package:o_driver/utils/context_less_nav.dart';
import 'package:o_driver/utils/image_compress_helper.dart';
import 'package:o_driver/widgets/buttons/full_width_button.dart';
import 'package:o_driver/widgets/misc_widgets.dart';
import 'package:o_driver/widgets/nav_bar.dart';
import 'package:o_driver/widgets/screen_wrapper.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({
    super.key,
    required this.user,
  });
  final User user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  File? _upimage;

  @override
  void initState() {
    super.initState();
  }

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
                      "Edit Profile",
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
            initialValue: widget.user.toMap(),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      if (_upimage == null) {
                        final ImagePicker picker = ImagePicker();
                        // Pick an image
                        final XFile? image = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (image != null) {
                          setState(() {
                            _upimage = File(image.path);
                          });
                        }
                      } else {
                        setState(() {
                          _upimage = null;
                        });
                      }
                    },
                    child: SizedBox(
                      height: 100.h,
                      width: 100.w,
                      child: Stack(
                        children: [
                          Center(
                            child: (_upimage != null)
                                ? CircleAvatar(
                                    backgroundColor: AppColors.white,
                                    radius: 50,
                                    backgroundImage: FileImage(_upimage!),
                                  )
                                : CircleAvatar(
                                    backgroundColor: AppColors.white,
                                    radius: 50,
                                    backgroundImage: Image.network(
                                      widget.user.profilePhotoPath ?? '',
                                    ).image,
                                  ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 26.h,
                              width: 26.w,
                              decoration: BoxDecoration(
                                color: AppColors.goldenButton,
                                borderRadius: BorderRadius.circular(12.w),
                              ),
                              child: Icon(
                                _upimage != null
                                    ? Icons.close
                                    : Icons.photo_camera,
                                color: AppColors.white,
                                size: 18.h,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                AppSpacerH(10.h),
                SizedBox(
                  width: 335.w,
                  child: Row(
                    children: [
                      const Expanded(
                        child: EditProfileTextField(
                          fieldName: 'first_name',
                          title: 'First Name',
                          hintText: 'First Name',
                        ),
                      ),
                      AppSpacerW(10.w),
                      const Expanded(
                        child: EditProfileTextField(
                          fieldName: 'last_name',
                          title: 'Last Name',
                          hintText: 'Last Name',
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacerH(10.h),
                const EditProfileTextField(
                  fieldName: 'email',
                  title: 'Email',
                  hintText: 'Email',
                ),
                AppSpacerH(20.h),
                ref.watch(userProfileUpdateProvider).map(
                    initial: (_) => AppTextButton(
                          title: 'Update Profile',
                          onTap: () async {
                            if (_formKey.currentState!.saveAndValidate()) {
                              final File? compressedImage =
                                  await ImageCompressHelper()
                                      .compressedImage(_upimage);
                              ref
                                  .watch(
                                userProfileUpdateProvider.notifier,
                              )
                                  .updateProfile(
                                data: {
                                  ..._formKey.currentState!.value,
                                },
                                file: compressedImage,
                              );
                            }
                          },
                        ),
                    loading: (_) => const LoadingWidget(),
                    loaded: (_) {
                      Future.delayed(AppDurConst.buildDuration).then((e) {
                        ref.refresh(userProfileUpdateProvider);
                        ref.refresh(userDetailsProvider);
                        context.nav.pop();
                      });
                      return MessageTextWidget(msg: _.data);
                    },
                    error: (_) {
                      Future.delayed(AppDurConst.buildDuration).then((e) {
                        ref.refresh(userProfileUpdateProvider);
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

class EditProfileTextField extends StatelessWidget {
  const EditProfileTextField({
    super.key,
    required this.title,
    required this.fieldName,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    required this.hintText,
  });
  final String title;
  final String fieldName;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextDecor.osBold14black,
        ),
        AppSpacerH(10.h),
        FormBuilderTextField(
          name: fieldName,
          decoration:
              AppInputDecor.editProfileInputDecor.copyWith(hintText: hintText),
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
        ),
      ],
    );
  }
}
