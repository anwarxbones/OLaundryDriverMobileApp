import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_customer/constants/app_colors.dart';

class IncDecButton extends StatelessWidget {
  const IncDecButton({
    super.key,
    required this.ontap,
    required this.icon,
  });
  final Function() ontap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 36.w,
        height: 36.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            12,
          ),
          color: AppColors.lightpurple,
        ),
        child: Center(
          child: Icon(
            icon,
            color: AppColors.purple,
          ),
        ),
      ),
    );
  }
}
