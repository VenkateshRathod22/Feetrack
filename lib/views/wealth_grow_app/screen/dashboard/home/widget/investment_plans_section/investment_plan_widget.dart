import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class InvestmentPlanWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String subTitle;
  const InvestmentPlanWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                spreadRadius: -4,
                color: black.withValues(alpha: 0.10)),
            BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 15,
                spreadRadius: -3,
                color: black.withValues(alpha: 0.10)),
          ]),
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            height: 46.h,
            width: 46.w,
          ),
          sizedBoxHeight(height: 7),
          CustomText(
            title,
            style: Helper(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontSize: 12.sp, color: black),
          ),
          CustomText(
            subTitle,
            style: Helper(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 10.sp, color: textDarkSecondary),
          ),
        ],
      ),
    );
  }
}
