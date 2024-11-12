import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:o_driver/constants/app_colors.dart';
import 'package:o_driver/constants/app_text_decor.dart';
import 'package:o_driver/constants/hive_contants.dart';
import 'package:o_driver/features/auth/models/login_model/user.dart';
import 'package:o_driver/features/profile/logic/profile_provider.dart';
import 'package:o_driver/utils/context_less_nav.dart';
import 'package:o_driver/utils/routes.dart';
import 'package:o_driver/widgets/misc_widgets.dart';

class AppNavbarProfile extends ConsumerWidget {
  AppNavbarProfile({
    super.key,
  });
  User? _user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userDetailsProvider).maybeWhen(
          orElse: () {},
          loaded: (data) {
            _user = data.data!.user;
          },
        );
    return ValueListenableBuilder(
        valueListenable: Hive.box(AppHSC.userBox).listenable(),
        builder: (context, Box userbox, child) {
          return SizedBox(
            height: 70.h,
            width: 345.w,
            child: Row(
              children: [
                CircleAvatar(
                    backgroundColor: AppColors.white,
                    radius: 35.r,
                    backgroundImage: userbox.get(AppHSC.userPhoto) != null
                        ? Image.network(userbox.get(AppHSC.userPhoto),
                                fit: BoxFit.cover)
                            .image
                        : Image.asset('assets/images/02.tutorial.png').image),
                AppSpacerW(16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      userbox.get(AppHSC.userFullName) ?? 'Md. Mahbub Alam',
                      style: AppTextDecor.osBold18White,
                    ),
                    Text(
                      userbox.get(AppHSC.userMobile) ?? '+9687039700',
                      style: AppTextDecor.osRegular14White,
                    ),
                    Text(
                      'Driver id: ${userbox.get(AppHSC.userID) ?? ''}'
                          .toUpperCase(),
                      style: AppTextDecor.osRegular12White
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      if (_user != null) {
                        context.nav.pushNamed(Routes.editProfileScreen,
                            arguments: _user);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.gold.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.h)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.edit,
                            color: AppColors.white,
                          ),
                          Text(
                            'Edit',
                            style: AppTextDecor.osRegular12White,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
