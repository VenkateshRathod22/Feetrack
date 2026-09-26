import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';
import 'package:vlr/controllers/invest_controller/investment_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class InvestmentSummerWidget extends StatelessWidget {
  const InvestmentSummerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          width: 1,
          color: primaryColor.withValues(alpha: 0.80),
        ),
        color: primaryColorLight.withValues(alpha: 0.30),
      ),
      child: GetBuilder<InvestmentControllerInvest>(
          builder: (investmentControllerInvest) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  "Selected Frequency:",
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 11.5.sp,
                        color: textDarkSecondary,
                      ),
                ),
                CustomText(
                  "${capitalize(investmentControllerInvest.selectedReturnPeriod)} (${investmentControllerInvest.selectedReturnPeriodPer}%)",
                  style: Helper(context).textTheme.titleMedium?.copyWith(
                        fontSize: 11.5.sp,
                        color: textDarkPrimary,
                      ),
                ),
              ],
            ),
            sizedBoxHeight(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  "Investment amount",
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 11.5.sp,
                        color: textDarkSecondary,
                      ),
                ),
                CustomText(
                  PriceConverter.convertToNumberFormat(double.tryParse(
                          investmentControllerInvest.amountController.text) ??
                      0.0),
                  style: Helper(context).textTheme.titleMedium?.copyWith(
                        fontSize: 11.5.sp,
                        color: textDarkPrimary,
                      ),
                ),
              ],
            )
          ],
        );
      }),
    );
  }
}
