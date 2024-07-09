import 'package:dry_cleaners_driver/constants/app_colors.dart';
import 'package:dry_cleaners_driver/constants/app_durations.dart';
import 'package:dry_cleaners_driver/constants/app_text_decor.dart';
import 'package:dry_cleaners_driver/constants/hive_contants.dart';
import 'package:dry_cleaners_driver/features/auth/logic/auth_provider.dart';
import 'package:dry_cleaners_driver/features/profile/logic/profile_provider.dart';
import 'package:dry_cleaners_driver/utils/context_less_nav.dart';
import 'package:dry_cleaners_driver/utils/routes.dart';
import 'package:dry_cleaners_driver/widgets/buttons/full_width_button.dart';
import 'package:dry_cleaners_driver/widgets/misc_widgets.dart';
import 'package:dry_cleaners_driver/widgets/nav_bar_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userDetailsProvider).maybeWhen(
          orElse: () {},
          loaded: (data) {
            Box userbox = Hive.box(AppHSC.userBox);

            userbox.putAll(data.data!.user!.toMap());
          },
        );
    return ValueListenableBuilder(
        valueListenable: Hive.box(AppHSC.userBox).listenable(),
        builder: (context, Box userbox, child) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                ),
                color: AppColors.goldenButton,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpacerH(68.h),
                    AppNavbarProfile(),
                    AppSpacerH(10.h),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      color: AppColors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const ProfileTabTile(
                          //   title: "Passport/Driving Licence:",
                          //   content: "8569 8785 589",
                          // ),
                          ProfileTabTile(
                            title: "Email:",
                            content: userbox.get(AppHSC.userEmail) ?? '',
                          ),

                          ProfileTabTile(
                            title: "Join date:",
                            content: userbox.get(AppHSC.joinDate) ?? '',
                          ),
                          AppSpacerH(14.h),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.nav
                                      .pushNamed(Routes.editPassswordScreen);
                                },
                                child: Text(
                                  'Change Password',
                                  style: AppTextDecor.osBold14gold,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              ref.watch(logoutProvider).map(
                                  initial: (_) => GestureDetector(
                                        onTap: () {
                                          ref
                                              .watch(logoutProvider.notifier)
                                              .logout();
                                        },
                                        child: Text(
                                          'Log Out',
                                          style: AppTextDecor.osBold14gold,
                                        ),
                                      ),
                                  error: (_) {
                                    Future.delayed(AppDurConst.buildDuration)
                                        .then((value) {
                                      ref.refresh(logoutProvider);
                                    });
                                    return ErrorTextWidget(error: _.error);
                                  },
                                  loaded: (_) {
                                    Future.delayed(AppDurConst.buildDuration)
                                        .then((value) {
                                      Hive.box(AppHSC.authBox).clear();
                                      Hive.box(AppHSC.userBox).clear();
                                      Hive.box(AppHSC.appSettingsBox).clear();
                                      Hive.box(AppHSC.cartBox).clear();
                                      ref.refresh(logoutProvider);
                                      context.nav.pushNamedAndRemoveUntil(
                                          Routes.loginScreen, (route) => false);
                                    });
                                    return const LoadingWidget();
                                  },
                                  loading: (_) => const LoadingWidget())
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Consumer(
                                    builder: (context, ref, child) {
                                      return Center(
                                        child: Container(
                                          width: 335.w,
                                          margin: EdgeInsets.all(20.h),
                                          decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12.h),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: AppColors.black
                                                        .withOpacity(0.1),
                                                    offset: Offset(0, 4.h),
                                                    blurRadius: 12.h,
                                                    spreadRadius: 0)
                                              ]),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 40.h, horizontal: 24.w),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "You are about to deactivate your Account",
                                                textAlign: TextAlign.center,
                                                style: AppTextDecor.osBold18Red,
                                              ),
                                              AppSpacerH(24.h),
                                              Text(
                                                "Are you sure? This action cannot be undone",
                                                style: AppTextDecor
                                                    .osRegular14Navy,
                                                textAlign: TextAlign.center,
                                              ),
                                              AppSpacerH(24.h),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: AppTextButton(
                                                    title: "Cancel",
                                                    onTap: () {
                                                      context.nav.pop();
                                                    },
                                                  )),
                                                  AppSpacerW(10.w),

                                                  Expanded(
                                                      child: ref
                                                          .watch(logoutProvider)
                                                          .map(
                                                              initial: (_) =>
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      ref
                                                                          .watch(
                                                                              logoutProvider.notifier)
                                                                          .logout();
                                                                    },
                                                                    child:
                                                                        AppTextButton(
                                                                      title:
                                                                          "Deactivate",
                                                                      buttonColor:
                                                                          AppColors
                                                                              .red,
                                                                      onTap:
                                                                          () {
                                                                        ref
                                                                            .watch(logoutProvider.notifier)
                                                                            .logout();
                                                                      },
                                                                    ),
                                                                  ),
                                                              error: (_) {
                                                                Future.delayed(
                                                                        AppDurConst
                                                                            .buildDuration)
                                                                    .then(
                                                                        (value) {
                                                                  ref.refresh(
                                                                      logoutProvider);
                                                                });
                                                                return ErrorTextWidget(
                                                                    error: _
                                                                        .error);
                                                              },
                                                              loaded: (_) {
                                                                Future.delayed(
                                                                        AppDurConst
                                                                            .buildDuration)
                                                                    .then(
                                                                        (value) {
                                                                  Hive.box(AppHSC
                                                                          .authBox)
                                                                      .clear();
                                                                  Hive.box(AppHSC
                                                                          .userBox)
                                                                      .clear();
                                                                  Hive.box(AppHSC
                                                                          .appSettingsBox)
                                                                      .clear();
                                                                  Hive.box(AppHSC
                                                                          .cartBox)
                                                                      .clear();
                                                                  ref.refresh(
                                                                      logoutProvider);
                                                                  context.nav.pushNamedAndRemoveUntil(
                                                                      Routes
                                                                          .loginScreen,
                                                                      (route) =>
                                                                          false);
                                                                });
                                                                return const LoadingWidget();
                                                              },
                                                              loading: (_) =>
                                                                  const LoadingWidget())),
                                                  // Expanded(
                                                  //   child: ref
                                                  //       .watch(
                                                  //           userDecativeProvider)
                                                  //       .map(
                                                  //           initial: (_) =>
                                                  // AppTextButton(
                                                  //   title:
                                                  //       "Deactivate",
                                                  //   buttonColor:
                                                  //       AppColors
                                                  //           .red,
                                                  //   onTap: () {
                                                  //     ref
                                                  //         .watch(userDecativeProvider
                                                  //             .notifier)
                                                  //         .deactivate();
                                                  //   },
                                                  // ),
                                                  //           loading: (_) =>
                                                  //               const LoadingWidget(),
                                                  //           loaded: (_) {
                                                  //             Future.delayed(
                                                  //                     AppDurConst
                                                  //                         .twoSec)
                                                  //                 .then(
                                                  //               (value) {
                                                  //                 Hive.box(AppHSC
                                                  //                         .authBox)
                                                  //                     .clear();
                                                  //                 Hive.box(AppHSC
                                                  //                         .userBox)
                                                  //                     .clear();
                                                  //                 Hive.box(AppHSC
                                                  //                         .appSettingsBox)
                                                  //                     .clear();
                                                  //                 Hive.box(AppHSC
                                                  //                         .cartBox)
                                                  //                     .clear();
                                                  //                 ref.refresh(
                                                  //                     userDecativeProvider);
                                                  //                 context.nav.pushNamedAndRemoveUntil(
                                                  //                     Routes
                                                  //                         .loginScreen,
                                                  //                     (route) =>
                                                  //                         false);
                                                  //               },
                                                  //             );
                                                  //             return MessageTextWidget(
                                                  //                 msg: _.data);
                                                  //           },
                                                  //           error: (_) {
                                                  //             Future.delayed(
                                                  //                     AppDurConst
                                                  //                         .buildDuration)
                                                  //                 .then((val) {
                                                  //               ref.refresh(
                                                  //                   userDecativeProvider);
                                                  //             });
                                                  //             return ErrorTextWidget(
                                                  //                 error:
                                                  //                     _.error);
                                                  //           }),
                                                  // )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                              child: const AppTextButton(
                                  title: "Deactivate Account",
                                  buttonColor: AppColors.red),
                            ),
                          ),
                          AppSpacerH(20.h),
                        ],
                      )))
            ],
          );
        });
  }
}

class ProfileTabTile extends StatelessWidget {
  const ProfileTabTile({
    Key? key,
    required this.title,
    required this.content,
    this.lastItem = false,
  }) : super(key: key);
  final String title;
  final String content;
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: lastItem ? Colors.transparent : AppColors.grayBG,
                  width: 2.h))),
      child: Row(
        children: [
          Text(
            title,
            style: AppTextDecor.osRegular14Navy,
          ),
          const Expanded(child: SizedBox()),
          Text(
            content,
            style: AppTextDecor.osRegular14black,
          ),
        ],
      ),
    );
  }
}
