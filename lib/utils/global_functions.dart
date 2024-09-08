import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:o_driver/constants/app_colors.dart';
import 'package:o_driver/constants/app_text_decor.dart';
import 'package:o_driver/features/orders/models/pending_order_list_model/address.dart';
import 'package:o_driver/features/orders/models/pending_order_list_model/order.dart';

class AppGFunctions {
  AppGFunctions._();
  static void changeStatusBarColor({
    required Color color,
    Brightness? iconBrightness,
    Brightness? brightness,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color, //or set color with: Color(0xFF0000FF)
        statusBarIconBrightness:
            iconBrightness ?? Brightness.dark, // For Android (dark icons)
        statusBarBrightness: brightness ?? Brightness.light,
      ),
    );
  }

  static DateFormat dfmt = DateFormat("EEE, MM MMM y");

  static Logger log() {
    final logger = Logger();
    return logger;
  }

  static TableRow tableTextRow({required String title, required String data}) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 3.5.h),
          child: Text(
            title,
            style: AppTextDecor.osRegular14black,
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 3.5.h),
          child: Text(
            data,
            style: AppTextDecor.osBold14black,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  static TableRow tableDiscountTextRow(
      {required String title, required String data}) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 3.5.h),
          child: Text(
            title,
            style: AppTextDecor.osRegular14black,
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 3.5.h),
          child: Text(
            data,
            style: AppTextDecor.osRegular14red,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  static TableRow tableTitleTextRow(
      {required String title, required String data}) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 3.5.h),
          child: Text(
            title,
            style: AppTextDecor.osBold14black,
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 3.5.h),
          child: Text(
            data,
            style: AppTextDecor.osBold14black,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  static String processAdAddess(Order order) {
    String address = '';
    if (order.address?.flatNo != null) {
      address = '$address Flat#:${order.address!.flatNo}, ';
    }
    if (order.address?.houseNo != null) {
      address = '$address House#:${order.address!.houseNo}, ';
    }
    if (order.address?.roadNo != null) {
      address = '$address Road#:${order.address!.roadNo}, ';
    }
    if (order.address?.block != null) {
      address = '$address Block#:${order.address!.block}, ';
    }
    if (order.address?.addressLine != null) {
      address = '$address${order.address!.addressLine}, ';
    }
    if (order.address?.addressLine2 != null) {
      address = '$address${order.address!.addressLine2}, ';
    }
    if (order.address?.zipCode != null) {
      address = '$address${order.address!.zipCode}';
    }

    return address;
  }

  static OrderType getOrderType(String? orderStatus) {
    OrderType result = OrderType.none;
    if (orderStatus?.toLowerCase() == "pick-up") {
      result = OrderType.pickUp;
    } else if (orderStatus?.toLowerCase() == 'delivery') {
      result = OrderType.delivery;
    }
    return result;
  }

  static OrderType getUserOrderType(String? orderStatus) {
    OrderType result = OrderType.none;
    if (orderStatus?.toLowerCase() == 'pending' ||
        orderStatus?.toLowerCase() == 'order confirmed') {
      result = OrderType.pickUp;
    } else if (orderStatus?.toLowerCase() == 'processing') {
      result = OrderType.delivery;
    }
    return result;
  }

  static String capitalizeEveryWord(String input) {
    List<String> words = input.split(" ");
    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      if (word.isNotEmpty) {
        words[i] = word[0].toUpperCase() + word.substring(1);
      }
    }
    return words.join(" ");
  }

  static String processAdAddess2(Address? address) {
    List<String> addressLines = [];
    if (address == null) return '';
    for (var element in [
      address.addressLine,
      address.addressLine2,
      address.city,
      address.state,
      address.zipCode
    ]) {
      if (element != null) {
        addressLines.add(element);
      }
    }
    return addressLines.join(', ');
  }

  static String pickUpOrDeliveryHour({required String? hour}) {
    print(hour);
    if (hour == null) {
      return '';
    }
    DateTime time = DateFormat('HH:mm').parse(hour);
    return DateFormat('hh:mm a').format(time);
  }

  static Widget statusCard(String status) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(8.r),
        border: status == 'Accepted'
            ? Border.all(color: AppColors.cardDeepGreen, width: 2)
            : null,
      ),
      child: Text(
        status == 'Accepted' ? 'Confirmed' : status,
        style: AppTextDecor.osBold14black,
      ),
    );
  }
}

enum OrderType { none, pickUp, delivery }
