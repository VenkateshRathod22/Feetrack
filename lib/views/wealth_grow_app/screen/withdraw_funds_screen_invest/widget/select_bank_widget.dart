import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:vlr/controllers/invest_controller/bank_controller_invest.dart';
import 'package:vlr/controllers/invest_controller/wallet_controller_invest.dart';
import 'package:vlr/data/models/invest_model/bank_model_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/custom_dropdown.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class SelectBankWidget extends StatelessWidget {
  const SelectBankWidget({
    super.key,
  });

  String _maskedAccountNumber(String accountNumber) {
    if (accountNumber.isEmpty) {
      return '•••• ••••';
    }

    if (accountNumber.length <= 4) {
      return '•••• $accountNumber';
    }

    return '•••• •••• ${accountNumber.substring(
      accountNumber.length - 4,
    )}';
  }

  Widget _buildSelectedBankItem(
    BuildContext context,
    BankModelInvest bank,
  ) {
    return Row(
      children: [
        Icon(
          Icons.account_balance_rounded,
          size: 20.r,
          color: primaryColor,
        ),
        sizedBoxWidth(width: 8),
        Expanded(
          child: CustomText(
            '${bank.bankName ?? ''} • '
            '${_maskedAccountNumber(bank.accountNo ?? '')}',
            maxLines: 1,
            style: Helper(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: textPrimary,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildBankItem(
    BuildContext context,
    BankModelInvest bank,
  ) {
    return Row(
      children: [
        Container(
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            Icons.account_balance_rounded,
            size: 22.r,
            color: primaryColor,
          ),
        ),
        sizedBoxWidth(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                bank.bankName ?? '',
                maxLines: 1,
                style: Helper(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                    ),
              ),
              sizedBoxHeight(height: 3),
              CustomText(
                _maskedAccountNumber(
                  bank.accountNo ?? '',
                ),
                maxLines: 1,
                style: Helper(context).textTheme.bodySmall?.copyWith(
                      fontSize: 11.sp,
                      color: textSecondary,
                      letterSpacing: 0.4,
                    ),
              ),
              sizedBoxHeight(height: 2),
              CustomText(
                bank.accountHolderName ?? '',
                maxLines: 1,
                style: Helper(context).textTheme.bodySmall?.copyWith(
                      fontSize: 10.sp,
                      color: textMuted,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BankControllerInvest>(
      builder: (bankControllerInvest) {
        return GetBuilder<WalletControllerInvest>(
          builder: (walletControllerInvest) {
            final activeBanks = bankControllerInvest.bankModelInvestList
                .where(
                  (bank) => bank.status.toString() == '1',
                )
                .toList();

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
                    'Select Bank Account',
                    style: Helper(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 13.sp,
                          color: primaryColorLight,
                        ),
                  ),
                  sizedBoxHeight(height: 8),
                  CustomDropDownList<BankModelInvest>(
                    dropdownColor: cardDartBg,
                    items: activeBanks,
                    value: activeBanks.contains(
                      walletControllerInvest.selectBank,
                    )
                        ? walletControllerInvest.selectBank
                        : null,
                    hintText: 'Select a Bank',
                    borderRadius: 999,
                    bgColor: surfaceNavy,
                    borderColor: cardDartBorderColor,
                    hintStyle: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 13.sp,
                          color: textMuted,
                        ),

                    // Full widget shown in dropdown popup
                    itemWidget: activeBanks.map(
                      (bank) {
                        return _buildBankItem(
                          context,
                          bank,
                        );
                      },
                    ).toList(),

                    // Compact widget shown when dropdown is closed
                    selectedItemBuilder: (
                      context,
                      bank,
                    ) {
                      return _buildSelectedBankItem(
                        context,
                        bank,
                      );
                    },

                    onChanged: (BankModelInvest? value) {
                      walletControllerInvest.selectBank = value;
                      walletControllerInvest.update();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
