import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/common_controller.dart';

import '../../../../../../base/custom_image.dart';
import '../../../../../../base/shimmer.dart';

// ignore: must_be_immutable
class InvestBannerSection extends StatefulWidget {
  const InvestBannerSection({
    super.key,
  });

  @override
  State<InvestBannerSection> createState() => _InvestBannerSectionState();
}

class _InvestBannerSectionState extends State<InvestBannerSection> {
  int currentIndex = 0;

  List<String> bannerList = [
    Assets.imagesSmallInvestmentsBanner,
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommonController>(
      builder: (commonController) {
        return Column(
          children: [
            CarouselSlider(
              items: List.generate(
                bannerList.length,
                (index) {
                  return CustomShimmer(
                    isLoading: commonController.isLoading,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: double.infinity,
                          height: 135.h,
                          child: CustomImage(
                            radius: 12.r,
                            path: commonController.isLoading
                                ? ""
                                : bannerList[index] ?? "",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              options: CarouselOptions(
                height: 150.h,
                viewportFraction: 1.0,
                autoPlay: true,
                initialPage: 0,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: false,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
            // const SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: List.generate(
            //     commonController.isLoading
            //         ? 4
            //         : bannerList.length,
            //     (index) {
            //       return CustomShimmer(
            //         isLoading: commonController.isLoading,
            //         child: BannerIndicatorWidget(
            //           isActive: currentIndex == index,
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
