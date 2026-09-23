import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/home/widget/investment_plans_section/Investment_plans_section.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/home/widget/home_screen_invest_appbar.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/home/widget/invest_banner_section/invest_banner_section.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/home/widget/invest_button_section/invest_button_section.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/home/widget/total_protfolio_value_section.dart';

class HomeScreenInvest extends StatelessWidget {
  const HomeScreenInvest({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HomeScreenInvestAppbar(),
        body: SingleChildScrollView(
          padding: AppConstants.screenPadding,
          child: Column(
            children: [
              TotalPortfolioValueSection(),
              sizedBoxHeight(height: 26.h),
              InvestButtonSection(),
              sizedBoxHeight(height: 26.h),
              InvestBannerSection(),
              sizedBoxHeight(height: 26.h),
              InvestmentPlansSection()
            ],
          ),
        ),
      ),
    );
  }
}
