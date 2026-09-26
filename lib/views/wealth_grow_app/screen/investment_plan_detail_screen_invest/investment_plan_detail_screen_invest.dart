import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/views/wealth_grow_app/screen/investment_plan_detail_screen_invest/widget/heading_widget.dart';
import 'package:vlr/views/wealth_grow_app/screen/widget/invest_appbar/invest_appbar_widget.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class InvestmentPlanDetailScreenInvest extends StatelessWidget {
  const InvestmentPlanDetailScreenInvest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InvestAppBarWidget(title: "Package Details"),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.r), color: cardWhite),
          child: Column(
            children: [
              HeadingWidget()
            ],
          ),
        ),
      ),
    );
  }
}
