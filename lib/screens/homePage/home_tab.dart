import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laundry_customer/constants/app_colors.dart';
import 'package:laundry_customer/constants/app_text_decor.dart';
import 'package:laundry_customer/constants/hive_contants.dart';
import 'package:laundry_customer/generated/l10n.dart';
import 'package:laundry_customer/models/category_model/category.dart';
import 'package:laundry_customer/providers/category_provider.dart';
import 'package:laundry_customer/screens/homePage/widgets/banner_widget.dart';
import 'package:laundry_customer/utils/context_less_nav.dart';
import 'package:laundry_customer/utils/routes.dart';
import 'package:laundry_customer/widgets/busy_loader.dart';
import 'package:laundry_customer/widgets/buttons/rounder_button.dart';
import 'package:laundry_customer/widgets/misc_widgets.dart';

class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab> {
  List postCodelist = [];
  bool isShowText = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbarWidget(context),
      backgroundColor: AppColors.lightgray,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppSpacerH(20.h),
            const BannerWidget(),
            AppSpacerH(20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: AppRountedTextButton(
                title: 'Quick Order',
                onTap: () {
                  context.nav.pushNamed(Routes.quickOrder);
                },
              ),
            ),
            AppSpacerH(20.h),
            _buildServiceWidgets(),
          ],
        ),
      ),
    );
  }

  PreferredSize _buildAppbarWidget(
    BuildContext context,
  ) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: ValueListenableBuilder(
        valueListenable: Hive.box(AppHSC.authBox).listenable(),
        builder: (context, Box authBox, Widget? child) {
          return ValueListenableBuilder(
            valueListenable: Hive.box(AppHSC.userBox).listenable(),
            builder: (context, Box box, Widget? child) {
              return ClipRRect(
                child: Container(
                  color: AppColors.white,
                  width: 375.w,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSpacerH(44.h),
                      SizedBox(
                        height: 48.h,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/icon_wave.png',
                              height: 48.h,
                              width: 48.w,
                            ),
                            AppSpacerW(15.w),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).hello,
                                  style: AppTextDecor.osRegular14black,
                                  textAlign: TextAlign.start,
                                ),
                                Expanded(
                                  child: Text(
                                    authBox.get('token') != null
                                        ? '${box.get('name')}'
                                        : S.of(context).plslgin,
                                    style: AppTextDecor.osBold20Black,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            const Expanded(child: SizedBox()),
                            if (authBox.get('token') != null)
                              Container(
                                width: 39.h,
                                height: 39.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18.r),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18.r),
                                  child: CachedNetworkImage(
                                    imageUrl: box
                                        .get('profile_photo_path')
                                        .toString(),
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              )
                            else
                              GestureDetector(
                                onTap: () {
                                  context.nav.pushNamed(
                                    Routes.loginScreen,
                                  );
                                },
                                child: SvgPicture.asset(
                                  "assets/svgs/icon_home_login.svg",
                                  width: 39.h,
                                  height: 39.h,
                                ),
                              ),
                          ],
                        ),
                      ),
                      AppSpacerH(20.h),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildServiceWidgets() {
    return ref.watch(categoryProvider).map(
          initial: (value) => Container(),
          loaded: (categories) => Container(
            width: double.infinity,
            color: AppColors.white,
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 12.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Services',
                  style: AppTextDecor.osRegular14white
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                AppSpacerH(10.h),
                if (categories.data.isNotEmpty) ...[
                  GridView.builder(
                    padding: EdgeInsets.only(bottom: 120.h),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 160.h,
                    ),
                    itemCount: categories.data.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildServiceCard(
                        category: categories.data[index],
                        callback: () {
                          context.nav.pushNamed(
                            Routes.chooseItemScreen,
                            arguments: categories.data[index],
                          );
                        },
                      );
                    },
                  ),
                ] else ...[
                  Text(
                    'No Service available',
                    style: AppTextDecor.osRegular14white,
                  ),
                ],
              ],
            ),
          ),
          loading: (_) => const BusyLoader(),
          error: (value) => Text(value.error),
        );
  }

  Widget _buildServiceCard({
    required CategoryModel category,
    required VoidCallback callback,
  }) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.lightgray, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 45,
              // backgroundImage: CachedNetworkImageProvider(
              //   '',
              // ),
            ),
            AppSpacerH(10.h),
            Text(
              category.name,
              style: AppTextDecor.osBold14black.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
