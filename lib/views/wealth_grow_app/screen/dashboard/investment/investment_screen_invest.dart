import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/investment/widget/all_daily_monthly_select_row/all_daily_monthly_select_row.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/investment/widget/all_daily_monthly_select_row/investment_return_plan_section/investment_return_plan_section.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class InvestmentScreenInvest extends StatelessWidget {
  const InvestmentScreenInvest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              "Explore Plans",
              style: Helper(context).textTheme.titleMedium?.copyWith(
                    fontSize: 26.sp,
                  ),
            ),
            sizedBoxHeight(height: 3),
            CustomText(
              "Choose a plan that fits your goal",
              style: Helper(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 13.sp, color: textSecondary),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            sizedBoxHeight(height: 12.h),
            const FilterSelectionSection(),
            sizedBoxHeight(height: 20.h),
            InvestmentReturnPlanSection()
          ],
        ),
      ),
    );
  }
}
