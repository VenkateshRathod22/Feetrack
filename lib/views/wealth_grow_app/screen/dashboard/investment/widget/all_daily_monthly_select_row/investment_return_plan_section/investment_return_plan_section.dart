import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/investment_controller_invest.dart';
import 'package:vlr/data/models/invest_model/investment_package_model.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/views/base/shimmer.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/investment/widget/all_daily_monthly_select_row/investment_return_plan_section/investment_return_plan_widget.dart';

class InvestmentReturnPlanSection extends StatelessWidget {
  const InvestmentReturnPlanSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvestmentControllerInvest>(
        builder: (investmentControllerInvest) {
      return ListView.separated(
        itemBuilder: (context, index) {
          final investmentPackageModel = investmentControllerInvest.isLoading
              ? InvestmentPackageModel()
              : investmentControllerInvest.investmentPackageModelList[index];
          return CustomShimmer(
              isLoading: investmentControllerInvest.isLoading,
              child: InvestmentReturnPlanWidget(
                investmentPackageModel: investmentPackageModel,
              ));
        },
        separatorBuilder: (_, __) => sizedBoxHeight(height: 14.h),
        itemCount: investmentControllerInvest.isLoading
            ? 4
            : investmentControllerInvest.investmentPackageModelList.length,
      );
    });
  }
}
