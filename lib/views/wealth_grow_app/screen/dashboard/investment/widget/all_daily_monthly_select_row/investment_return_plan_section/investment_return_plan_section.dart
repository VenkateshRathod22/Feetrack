import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/investment/widget/all_daily_monthly_select_row/investment_return_plan_section/investment_return_plan_widget.dart';

class InvestmentReturnPlanSection extends StatelessWidget {
  const InvestmentReturnPlanSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InvestmentReturnPlanWidget();
      },
      separatorBuilder: (_, __) => sizedBoxHeight(height: 14.h),
      itemCount: 4,
    );
  }
}
