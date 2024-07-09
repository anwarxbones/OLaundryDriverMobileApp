import 'package:dry_cleaners_driver/constants/app_colors.dart';
import 'package:dry_cleaners_driver/constants/app_text_decor.dart';
import 'package:dry_cleaners_driver/constants/hive_contants.dart';
import 'package:dry_cleaners_driver/features/auth/models/login_model/user.dart';
import 'package:dry_cleaners_driver/features/profile/logic/profile_provider.dart';
import 'package:dry_cleaners_driver/utils/context_less_nav.dart';
import 'package:dry_cleaners_driver/utils/routes.dart';
import 'package:dry_cleaners_driver/widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppNavbarProfile extends ConsumerWidget {
  AppNavbarProfile({
    Key? key,
  }) : super(key: key);
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(35.h),
                  child: Container(
                    height: 70.h,
                    width: 70.h,
                    padding: const EdgeInsets.all(4),
                    child: userbox.get(AppHSC.userPhoto) != null
                        ? Image.network(userbox.get(AppHSC.userPhoto))
                        : Image.asset('assets/images/02.tutorial.png'),
                  ),
                ),
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
