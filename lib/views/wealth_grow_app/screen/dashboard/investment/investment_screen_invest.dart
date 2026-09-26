import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/investment_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/investment/widget/all_daily_monthly_select_row/investment_return_plan_section/investment_return_plan_section.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/investment/widget/calculate_your_return_widget/calculate_your_return_widget.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class InvestmentScreenInvest extends StatefulWidget {
  const InvestmentScreenInvest({super.key});

  @override
  State<InvestmentScreenInvest> createState() => _InvestmentScreenInvestState();
}

class _InvestmentScreenInvestState extends State<InvestmentScreenInvest> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<InvestmentControllerInvest>().fetchAllPackageInvest();
    });
  }

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
            // sizedBoxHeight(height: 12.h),
            // const FilterSelectionSection(),
            sizedBoxHeight(height: 20.h),
            const Expanded(child: InvestmentReturnPlanSection()),
            sizedBoxHeight(height: 14.h),
            CalculateYourReturnWidget()
          ],
        ),
      ),
    );
  }
}
