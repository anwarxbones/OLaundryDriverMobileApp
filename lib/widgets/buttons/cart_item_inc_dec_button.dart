import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_customer/constants/app_colors.dart';
import 'package:laundry_customer/constants/app_text_decor.dart';

class IncDecButtonWithValueV2 extends ConsumerWidget {
  const IncDecButtonWithValueV2({
    super.key,
    this.width,
    this.height,
    required this.value,
    required this.onInc,
    required this.onDec,
    required this.isPiece,
  });
  final double value;
  final Function() onInc;
  final Function() onDec;
  final double? width;
  final double? height;
  final bool isPiece;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grayBG,
        borderRadius: BorderRadius.circular(10.w),
      ),
      height: height ?? 36.h,
      width: width ?? 120.w,
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onDec,
            child: const Icon(Icons.remove),
          ),
          Text(
            value.toStringAsFixed(isPiece ? 0 : 2),
            style: AppTextDecor.osSemiBold18black,
          ),
          GestureDetector(
            onTap: onInc,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
