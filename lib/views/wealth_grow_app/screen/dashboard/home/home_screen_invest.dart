import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/auth_controller_invest.dart';
import 'package:vlr/controllers/invest_controller/basic_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/home/widget/investment_plans_section/Investment_plans_section.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/home/widget/home_screen_invest_appbar.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/home/widget/invest_banner_section/invest_banner_section.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/home/widget/invest_button_section/invest_button_section.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/home/widget/total_protfolio_value_section.dart';

class HomeScreenInvest extends StatefulWidget {
  const HomeScreenInvest({super.key});

  @override
  State<HomeScreenInvest> createState() => _HomeScreenInvestState();
}

class _HomeScreenInvestState extends State<HomeScreenInvest> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authControllerInvest = Get.find<AuthControllerInvest>();
      final basicControllerInvest = Get.find<BasicControllerInvest>();
      authControllerInvest.fetchProfileInvest();
      basicControllerInvest.fetchHomeInvest();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const HomeScreenInvestAppbar(),
        body: SingleChildScrollView(
          padding: AppConstants.screenPadding,
          child: Column(
            children: [
              const TotalPortfolioValueSection(),
              sizedBoxHeight(height: 26.h),
              const InvestButtonSection(),
              sizedBoxHeight(height: 26.h),
              const InvestBannerSection(),
              sizedBoxHeight(height: 26.h),
              const InvestmentPlansSection()
            ],
          ),
        ),
      ),
    );
  }
}
