import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o_driver/constants/app_colors.dart';
import 'package:o_driver/utils/context_less_nav.dart';

class AppNavbar extends ConsumerWidget {
  const AppNavbar({
    Key? key,
    required this.title,
    this.onBack,
    this.showBack = false,
  }) : super(key: key);

  final Function()? onBack;
  final bool showBack;
  final Widget title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 44.h,
      width: 345.w,
      child: Stack(
        children: [
          if (showBack)
            GestureDetector(
              onTap: () {
                onBack?.call();
                context.nav.pop();
              },
              child: Container(
                height: 44.h,
                width: 44.w,
                color: AppColors.white,
                child: const Center(child: Icon(Icons.arrow_back)),
              ),
            ),
          title
        ],
      ),
    );
  }
}
