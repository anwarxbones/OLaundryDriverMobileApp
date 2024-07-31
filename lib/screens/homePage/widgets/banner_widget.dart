import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_customer/constants/app_colors.dart';
import 'package:laundry_customer/widgets/misc_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            viewportFraction: 1.1,
            height: 160,
            onPageChanged: (index, reason) =>
                setState(() => _currentIndex = index),
          ),
          items: images
              .map(
                (item) => Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(item),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        AppSpacerH(10.h),
        AnimatedSmoothIndicator(
          activeIndex: _currentIndex,
          count: images.length,
          effect: WormEffect(
            dotHeight: 8.h,
            dotWidth: 8.w,
            activeDotColor: AppColors.primary,
            dotColor: AppColors.primary.withOpacity(0.2),
          ),
          onDotClicked: (index) {
            _controller.animateToPage(index);
          },
        ),
      ],
    );
  }

  List<String> images = [
    'assets/images/dim_00.png',
    'assets/images/dim_01.png',
    'assets/images/dim_02.png',
  ];
}
