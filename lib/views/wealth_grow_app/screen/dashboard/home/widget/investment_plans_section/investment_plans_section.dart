import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/generated/assets.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/home/widget/investment_plans_section/investment_plan_widget.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class InvestmentPlansSection extends StatelessWidget {
  const InvestmentPlansSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              "Investment Plans",
              style: Helper(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 16.sp, color: white),
            ),
            CustomText(
              "View All",
              style: Helper(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontSize: 14.sp, color: primaryColor),
            ),
          ],
        ),
        sizedBoxHeight(height: 12.h),
        Row(
          children: [
            const Expanded(
              child: InvestmentPlanWidget(
                icon: Assets.imagesDailyReturn,
                title: "Daily",
                subTitle: "Returns",
              ),
            ),
            sizedBoxWidth(width: 16.w),
            const Expanded(
              child: InvestmentPlanWidget(
                icon: Assets.imagesMonthlyReturns,
                title: "Monthly",
                subTitle: "Returns",
              ),
            ),
            sizedBoxWidth(width: 16.w),
            const Expanded(
              child: InvestmentPlanWidget(
                icon: Assets.imagesYearlyReturns,
                title: "Yearly",
                subTitle: "Returns",
              ),
            ),
          ],
        )
      ],
    );
  }
}
