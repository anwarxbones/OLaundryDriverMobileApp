import 'package:dry_cleaners_driver/constants/app_text_decor.dart';
import 'package:dry_cleaners_driver/widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreenOverviewCard extends StatelessWidget {
  const HomeScreenOverviewCard({
    Key? key,
    required this.imagePath,
    required this.subtitle,
    required this.count,
    required this.cardColor,
  }) : super(key: key);
  final String imagePath;
  final String subtitle;
  final String count;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 106.w,
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.h),
        color: cardColor.withOpacity(0.10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            height: 30.h,
            width: 30.w,
          ),
          AppSpacerH(8.h),
          Text(
            subtitle,
            style: AppTextDecor.osRegular10Navy,
          ),
          Text(
            count,
            style: AppTextDecor.osBold18black,
          )
        ],
      ),
    );
  }
}
