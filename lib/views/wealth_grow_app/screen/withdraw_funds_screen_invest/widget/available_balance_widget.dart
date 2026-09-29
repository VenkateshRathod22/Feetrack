import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/auth_controller_invest.dart';
import 'package:vlr/controllers/invest_controller/basic_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class AvailableBalanceWidget extends StatelessWidget {
  const AvailableBalanceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthControllerInvest>(builder: (authControllerInvest) {
      return Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: cardDartBg,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(width: 1, color: cardDartBorderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              "AVAILABLE BALANCE",
              style: Helper(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 13.sp,
                    color: primaryColorLight,
                  ),
            ),
            sizedBoxHeight(height: 6),
            CustomText(
              authControllerInvest
                      .userModelInvest?.amountAvailableForWithdrawalFormat ??
                  "0.0",
              style: Helper(context).textTheme.titleMedium?.copyWith(
                    fontSize: 32.sp,
                  ),
            ),
            sizedBoxHeight(height: 24),
            GetBuilder<BasicControllerInvest>(builder: (basicControllerInvest) {
              return Row(
                children: [
                  const Icon(
                    Icons.watch_later_outlined,
                    color: green,
                  ),
                  sizedBoxWidth(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              "Timing: ",
                              style: Helper(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: 12.sp,
                                    color: primaryColorLight,
                                    letterSpacing: 0.2,
                                  ),
                            ),
                            CustomText(
                              basicControllerInvest.appSettingInvestModel
                                      ?.withdrawSetting?.timeForWithdrawal ??
                                  "",
                              style: Helper(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: 12.sp,
                                    color: green,
                                  ),
                            ),
                          ],
                        ),
                        CustomText(
                          basicControllerInvest.appSettingInvestModel
                                  ?.withdrawSetting?.dayForWithdrawal ??
                              "",
                          style: Helper(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 12.sp,
                                color: primaryColorLight,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6.r)),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: (basicControllerInvest
                                      .appSettingInvestModel
                                      ?.withdrawSetting
                                      ?.isWithdrawalTime ??
                                  false)
                              ? green
                              : red1,
                          radius: 3.r,
                        ),
                        sizedBoxWidth(width: 4.w),
                        CustomText(
                          (basicControllerInvest.appSettingInvestModel
                                      ?.withdrawSetting?.isWithdrawalTime ??
                                  false)
                              ? "Window Open"
                              : "Window Close",
                          style: Helper(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 11.sp,
                                color: (basicControllerInvest
                                            .appSettingInvestModel
                                            ?.withdrawSetting
                                            ?.isWithdrawalTime ??
                                        false)
                                    ? green
                                    : red1,
                              ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            })
          ],
        ),
      );
    });
  }
}
