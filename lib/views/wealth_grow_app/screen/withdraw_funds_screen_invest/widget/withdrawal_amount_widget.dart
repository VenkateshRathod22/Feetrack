
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/auth_controller_invest.dart';

import 'package:vlr/controllers/invest_controller/basic_controller_invest.dart';
import 'package:vlr/controllers/invest_controller/wallet_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';
import 'package:vlr/views/widget/text_box/app_text_box.dart';

class WithdrawalAmountWidget extends StatelessWidget {
  const WithdrawalAmountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthControllerInvest>(builder: (authControllerInvest) {
      return GetBuilder<WalletControllerInvest>(
        builder: (walletControllerInvest) {
          return GetBuilder<BasicControllerInvest>(
            builder: (basicControllerInvest) {
              final withdrawSetting =
                  basicControllerInvest.appSettingInvestModel?.withdrawSetting;
              final double availableBalance = double.tryParse(
                      authControllerInvest.userModelInvest?.walletAmount ??
                          "") ??
                  0.0;

              final double minAmount =
                  double.tryParse(withdrawSetting?.minAmt ?? '') ?? 0;

              final double maxAmount =
                  double.tryParse(withdrawSetting?.maxAmt ?? '') ?? 0;

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      'Withdraw Funds',
                      style: Helper(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 13.sp,
                            color: primaryColorLight,
                          ),
                    ),
                    sizedBoxHeight(height: 6),
                    AppTextFieldWithHeading(
                      controller: walletControllerInvest.amountController,
                      hindText: '0.00',
                      isRequired: true,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      preFixWidget: const Icon(
                        Icons.currency_rupee,
                        color: primaryColor,
                      ),
                      onChanged: (value) {
                        walletControllerInvest.withdrawalAmountDebounce(() {
                          final text = walletControllerInvest
                              .amountController.text
                              .trim();

                          if (text.isEmpty) {
                            return;
                          }

                          final amount = double.tryParse(text);

                          if (amount == null) {
                            return;
                          }

                          // 1. Check withdrawal day and time
                          if (!(withdrawSetting?.isWithdrawalTime ?? false)) {
                            showToast(
                              message:
                                  'Withdrawal is currently unavailable. Available time: '
                                  '${withdrawSetting?.timeForWithdrawal ?? ''}',
                              typeCheck: false,
                            );
                            return;
                          }

                          // 2. Check available wallet balance
                          if (amount > availableBalance) {
                            showToast(
                              message:
                                  'Available balance is ${authControllerInvest.userModelInvest?.amountAvailableForWithdrawalFormat}',
                              typeCheck: false,
                            );
                            return;
                          }

                          // 3. Check minimum withdrawal amount
                          if (minAmount > 0 && amount < minAmount) {
                            showToast(
                              message:
                                  'Minimum withdrawal amount is ₹${minAmount.toStringAsFixed(0)}',
                              typeCheck: false,
                            );
                            return;
                          }

                          // 4. Check maximum withdrawal amount
                          if (maxAmount > 0 && amount > maxAmount) {
                            showToast(
                              message:
                                  'Maximum withdrawal amount is ₹${maxAmount.toStringAsFixed(0)}',
                              typeCheck: false,
                            );
                            return;
                          }

                          walletControllerInvest.adminFeeCal();

                          walletControllerInvest.update();
                        });
                      },
                      borderWidth: 1,
                      borderRadius: 14,
                      textStyle: Helper(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 28.sp,
                          ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        final text = value?.trim() ?? '';

                        if (text.isEmpty) {
                          return 'Please enter withdrawal amount';
                        }

                        final amount = double.tryParse(text);

                        if (amount == null || amount <= 0) {
                          return 'Please enter a valid amount';
                        }

                        if (minAmount > 0 && amount < minAmount) {
                          return 'Minimum withdrawal amount is ₹${minAmount.toStringAsFixed(0)}';
                        }

                        if (maxAmount > 0 && amount > maxAmount) {
                          return 'Maximum withdrawal amount is ₹${maxAmount.toStringAsFixed(0)}';
                        }

                        return null;
                      },
                    ),
                    sizedBoxHeight(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: primaryColorLight,
                          size: 15.sp,
                        ),
                        sizedBoxWidth(width: 6),
                        CustomText(
                          'Min. withdrawal ${basicControllerInvest.appSettingInvestModel?.withdrawSetting?.minAmtFormat ?? ""} • Daily limit ${basicControllerInvest.appSettingInvestModel?.withdrawSetting?.maxAmtFormat ?? ""}',
                          style: Helper(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 12.sp,
                                color: primaryColorLight,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    });
  }
}
