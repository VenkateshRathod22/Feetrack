import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/auth_controller_invest.dart';
import 'package:vlr/generated/assets.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/home/widget/invest_text_widget.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class TotalPortfolioValueSection extends StatelessWidget {
  const TotalPortfolioValueSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: const Color(0xFF0C4A6E66),
          ),
          borderRadius: BorderRadius.circular(24.r),
          gradient: totalPortfolioValueSectionDarkGradient,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 1,
              spreadRadius: 1,
              color: white.withValues(alpha: 0.08),
            ),
            BoxShadow(
              offset: const Offset(0, 10),
              blurRadius: 30,
              spreadRadius: -10,
              color: black.withValues(alpha: 0.7),
            ),
          ]),
      child: GetBuilder<AuthControllerInvest>(
        builder: (authControllerInvest) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                "Total Portfolio Value",
                style: Helper(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 12.sp, color: textSecondary),
              ),
              sizedBoxHeight(height: 4),
              CustomText(
                "₹1,25,450",
                style: Helper(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 24.sp, color: white),
              ),
              sizedBoxHeight(height: 7.5),
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.svgsTopTriangle,
                  ),
                  sizedBoxWidth(width: 3),
                  CustomText(
                    "+12.5%",
                    style: Helper(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 11.sp, color: green),
                  ),
                  sizedBoxWidth(width: 7),
                  CustomText(
                    "this month",
                    style: Helper(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 11.sp, color: textSecondary),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                child: Divider(
                  color: textSecondary.withValues(alpha: 0.30),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InvestedTextWidget(
                    title: "₹1,00,000",
                    subTitle: "Total Invested",
                    titleColor: white,
                  ),
                  InvestedTextWidget(
                    title: "₹25,450",
                    subTitle: "Total Returns",
                    titleColor: primaryColor,
                  ),
                  InvestedTextWidget(
                    title: "₹5,450",
                    subTitle: "Available Balance",
                    titleColor: white,
                  ),
                ],
              )
            ],
          );
        }
      ),
    );
  }
}
