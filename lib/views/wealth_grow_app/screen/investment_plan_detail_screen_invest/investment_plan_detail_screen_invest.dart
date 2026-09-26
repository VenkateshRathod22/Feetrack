import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';
import 'package:vlr/controllers/invest_controller/investment_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/wealth_grow_app/screen/investment_plan_detail_screen_invest/widget/heading_widget.dart';
import 'package:vlr/views/wealth_grow_app/screen/investment_plan_detail_screen_invest/widget/investment_amount_widget.dart';
import 'package:vlr/views/wealth_grow_app/screen/investment_plan_detail_screen_invest/widget/investment_summer_widget.dart';
import 'package:vlr/views/wealth_grow_app/screen/investment_plan_detail_screen_invest/widget/package_section/package_section.dart';
import 'package:vlr/views/wealth_grow_app/screen/investment_plan_detail_screen_invest/widget/select_return_frequency_widget.dart';
import 'package:vlr/views/wealth_grow_app/screen/widget/invest_appbar/invest_appbar_widget.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class InvestmentPlanDetailScreenInvest extends StatelessWidget {
  const InvestmentPlanDetailScreenInvest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InvestAppBarWidget(title: "Package Details"),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.r), color: cardWhite),
          child: Column(
            children: [
              const HeadingWidget(),
              sizedBoxHeight(height: 14.h),
              const PackageInfoSection(),
              sizedBoxHeight(height: 20.h),
              const InvestmentAmountWidget(),
              sizedBoxHeight(height: 20.h),
              const SelectReturnFrequencyWidget(),
              sizedBoxHeight(height: 20.h),
              const InvestmentSummerWidget(),
              sizedBoxHeight(height: 20.h),
              GetBuilder<InvestmentControllerInvest>(
                  builder: (investmentControllerInvest) {
                return CustomButton(
                  isLoading: investmentControllerInvest.isLoading,
                  onTap: () {},
                  borderColor: primaryColor,
                  height: 52.h,
                  radius: 16.r,
                  gradient: goldGradient,
                  child: CustomText(
                    "Invest Now",
                    style: Helper(context).textTheme.titleLarge?.copyWith(
                          fontSize: 15.sp,
                          color: borderDark,
                        ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
