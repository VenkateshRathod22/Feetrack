import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:vlr/controllers/invest_controller/investment_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/base/shimmer.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvestmentControllerInvest>(
        builder: (investmentControllerInvest) {
      return CustomShimmer(
        isLoading: investmentControllerInvest.isLoading,
        child: Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              width: 1,
              color: primaryColor.withValues(alpha: 0.50),
            ),
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFFFBEB),
                Color(0xFFFEF3C7),
                Color(0xFFFDE68A),
              ],
            ),
          ),
          child: Row(
            children: [
              CustomImage(
                path: Assets.imagesRupeeBg,
                height: 48.h,
                width: 48.w,
                fit: BoxFit.cover,
              ),
              sizedBoxWidth(width: 14.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    investmentControllerInvest
                            .selectInvestmentPackageModel?.title ??
                        "",
                    style: Helper(context).textTheme.titleLarge?.copyWith(
                          fontSize: 18.sp,
                          color: textDarkPrimary,
                        ),
                  ),
                
                  CustomText(
                    "Choose your preferred payout frequency below",
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 11.sp,
                          color: primaryColorLight2,
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
