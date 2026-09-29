import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/basic_controller_invest.dart';
import 'package:vlr/controllers/invest_controller/wallet_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class WithdrawalSummaryWidget extends StatelessWidget {
  const WithdrawalSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BasicControllerInvest>(builder: (basicControllerInvest) {
      return GetBuilder<WalletControllerInvest>(
          builder: (walletControllerInvest) {
        return Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: cardDartBg,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              width: 1,
              color: cardDartBorderColor,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    "PAYOUT BREAKDOWN",
                    style: Helper(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 13.sp,
                        ),
                  ),
                  CustomText(
                    "${basicControllerInvest.appSettingInvestModel?.withdrawSetting?.admincharge ?? ""}% Admin Charge",
                    style: Helper(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 12.sp, color: primaryColorLight),
                  ),
                ],
              ),
              sizedBoxHeight(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    "Requested Amount",
                    style: Helper(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 14.sp, color: primaryColorLight),
                  ),
                  CustomText(
                    "${PriceConverter.convertToNumberFormat(double.tryParse(walletControllerInvest.amountController.text.trim()) ?? 0.0)}",
                    style: Helper(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 14.sp),
                  ),
                ],
              ),
              sizedBoxHeight(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    "Admin Fee (2%)",
                    style: Helper(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 14.sp, color: primaryColorLight),
                  ),
                  CustomText(
                    walletControllerInvest.adminFee ?? "",
                    style: Helper(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 14.sp, color: red1),
                  ),
                ],
              ),
              sizedBoxHeight(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    "Net Credited Amount",
                    style: Helper(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 14.sp),
                  ),
                  CustomText(
                    walletControllerInvest.netCreditedAmount ?? "",
                    style: Helper(context).textTheme.titleMedium?.copyWith(
                          fontSize: 24.sp,
                          color: primaryColor,
                        ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
    });
  }
}
