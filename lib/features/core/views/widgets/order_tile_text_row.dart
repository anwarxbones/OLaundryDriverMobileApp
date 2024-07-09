import 'package:dry_cleaners_driver/constants/app_text_decor.dart';
import 'package:flutter/material.dart';

class OrderTileTextRow extends StatelessWidget {
  const OrderTileTextRow({
    Key? key,
    required this.title,
    required this.content,
    this.center = false,
  }) : super(key: key);
  final String title;
  final String content;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextDecor.osRegular12Navy,
        ),
        Text(
          content,
          style: AppTextDecor.osBold12black,
        ),
      ],
    );
  }
}
