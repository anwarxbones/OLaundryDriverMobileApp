import 'package:dry_cleaners_driver/constants/app_colors.dart';
import 'package:dry_cleaners_driver/constants/app_text_decor.dart';
import 'package:dry_cleaners_driver/constants/hive_contants.dart';
import 'package:dry_cleaners_driver/features/orders/logic/order_provider.dart';
import 'package:dry_cleaners_driver/utils/context_less_nav.dart';
import 'package:dry_cleaners_driver/utils/global_functions.dart';
import 'package:dry_cleaners_driver/utils/routes.dart';
import 'package:dry_cleaners_driver/widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppNavbarHome extends ConsumerWidget {
  const AppNavbarHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(AppHSC.userBox).listenable(),
      builder: (context, Box userbox, child) {
        return SizedBox(
          height: 44.h,
          width: 345.w,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(22.h),
                child: Container(
                  height: 44.h,
                  width: 44.h,
                  padding: const EdgeInsets.all(4),
                  child: userbox.get(AppHSC.userPhoto) != null
                      ? Image.network(userbox.get(AppHSC.userPhoto))
                      : Image.asset('assets/images/02.tutorial.png'),
                ),
              ),
              AppSpacerW(6.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    userbox.get(AppHSC.userFullName) ?? 'Md. Mahbub Alam',
                    style: AppTextDecor.osBold14black,
                  ),
                  Text(
                    AppGFunctions.dfmt.format(DateTime.now()),
                    // 'Fri, 20 Aug 2022',
                    style: AppTextDecor.osRegular10Navy,
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => ref.refresh(totalOrderListProvider),
                      child: Container(
                        height: 40.h,
                        width: 40.h,
                        decoration: BoxDecoration(
                            color: AppColors.grayBG,
                            borderRadius: BorderRadius.circular(20.h)),
                        child: const Icon(Icons.refresh),
                      ),
                    ),
                    AppSpacerW(10.w),
                    GestureDetector(
                      onTap: () {
                        context.nav.pushNamed(Routes.notficationsScreen);
                      },
                      child: Container(
                        height: 40.h,
                        width: 40.h,
                        decoration: BoxDecoration(
                            color: AppColors.grayBG,
                            borderRadius: BorderRadius.circular(20.h)),
                        child: const Icon(Icons.notifications),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
