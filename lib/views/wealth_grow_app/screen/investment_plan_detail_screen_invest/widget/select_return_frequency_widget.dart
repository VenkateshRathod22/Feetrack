import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/basic_controller_invest.dart';
import 'package:vlr/controllers/invest_controller/investment_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class SelectReturnFrequencyWidget extends StatelessWidget {
  const SelectReturnFrequencyWidget({
    super.key,
  });

  String _getReturnPercent({
    required String? incomeType,
    required InvestmentControllerInvest investmentControllerInvest,
  }) {
    final package =
        investmentControllerInvest.selectInvestmentPackageModel;

    switch (incomeType?.toLowerCase()) {
      case 'daily':
        return package?.dailyPercent ?? '';

      case 'monthly':
        return package?.monthlyPercent ?? '';

      case 'yearly':
        return package?.yearlyPercent ?? '';

      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BasicControllerInvest>(
      builder: (basicControllerInvest) {
        final incomeFrequency =
            basicControllerInvest
                    .appSettingInvestModel
                    ?.incomeFrequency ??
                [];

        return GetBuilder<InvestmentControllerInvest>(
          builder: (investmentControllerInvest) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  "Select Return Frequency",
                  style: Helper(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontSize: 13.sp,
                        color: borderDark,
                      ),
                ),

                sizedBoxHeight(height: 8.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: grayLight,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: incomeFrequency.map((frequency) {
                      final bool isSelected =
                          basicControllerInvest
                                  .selectedIncomeFrequencyId ==
                              frequency.id;

                      final String returnPercent =
                          _getReturnPercent(
                        incomeType: frequency.incomeType,
                        investmentControllerInvest:
                            investmentControllerInvest,
                      );

                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Update selected frequency
                            basicControllerInvest
                                .selectIncomeFrequency(
                              frequency.id,
                            );

                            // Calculate return
                            investmentControllerInvest
                                .updateReturnCalculation(
                              period:
                                  frequency.incomeType ?? "daily",
                            );
                          },
                          child: AnimatedContainer(
                            duration:
                                const Duration(milliseconds: 200),
                            height: 48.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? neutralColor2
                                  : Colors.transparent,
                              borderRadius:
                                  BorderRadius.circular(9.r),
                            ),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  frequency.incomeType ?? "",
                                  style: Helper(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontSize: 12.sp,
                                        fontWeight:
                                            FontWeight.w600,
                                        color: isSelected
                                            ? primaryColor
                                            : textDarkPrimary,
                                      ),
                                ),

                                sizedBoxHeight(height: 2.h),

                                CustomText(
                                  returnPercent.isNotEmpty
                                      ? "$returnPercent%"
                                      : "--",
                                  style: Helper(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontSize: 11.sp,
                                        fontWeight:
                                            FontWeight.w500,
                                        color: isSelected
                                            ? primaryColor
                                            : textDarkSecondary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}