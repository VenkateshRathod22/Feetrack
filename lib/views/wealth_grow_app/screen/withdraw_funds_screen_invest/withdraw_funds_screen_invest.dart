import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:vlr/controllers/invest_controller/auth_controller_invest.dart';
import 'package:vlr/controllers/invest_controller/bank_controller_invest.dart';
import 'package:vlr/controllers/invest_controller/basic_controller_invest.dart';
import 'package:vlr/controllers/invest_controller/wallet_controller_invest.dart';

import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/wealth_grow_app/screen/withdraw_funds_screen_invest/widget/available_balance_widget.dart';
import 'package:vlr/views/wealth_grow_app/screen/withdraw_funds_screen_invest/widget/select_bank_widget.dart';
import 'package:vlr/views/wealth_grow_app/screen/withdraw_funds_screen_invest/widget/withdrawal_amount_widget.dart';
import 'package:vlr/views/wealth_grow_app/screen/withdraw_funds_screen_invest/widget/withdrawal_summary_widget.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class WithdrawFundsScreenInvest extends StatefulWidget {
  const WithdrawFundsScreenInvest({
    super.key,
  });

  @override
  State<WithdrawFundsScreenInvest> createState() =>
      _WithdrawFundsScreenInvestState();
}

class _WithdrawFundsScreenInvestState extends State<WithdrawFundsScreenInvest> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final basicControllerInvest = Get.find<BasicControllerInvest>();
      Get.find<BankControllerInvest>().fetchGetAllBankInvest();
    });
  }

  Future<void> _submitWithdrawal(
    BuildContext context,
  ) async {
    final authControllerInvest = Get.find<AuthControllerInvest>();

    final walletControllerInvest = Get.find<WalletControllerInvest>();

    final basicControllerInvest = Get.find<BasicControllerInvest>();

    final withdrawSetting =
        basicControllerInvest.appSettingInvestModel?.withdrawSetting;

    // ----------------------------------------------------------
    // 1. Check withdrawal settings
    // ----------------------------------------------------------

    if (withdrawSetting == null) {
      showToast(
        message: 'Withdrawal settings are unavailable',
        typeCheck: false,
      );
      return;
    }

    // ----------------------------------------------------------
    // 2. Check withdrawal day and time
    // ----------------------------------------------------------

    if (!withdrawSetting.isWithdrawalTime) {
      showToast(
        message: 'Withdrawal is currently unavailable. '
            '${withdrawSetting.dayForWithdrawal} '
            '${withdrawSetting.timeForWithdrawal}',
        typeCheck: false,
      );
      return;
    }

    // ----------------------------------------------------------
    // 3. Get entered amount
    // ----------------------------------------------------------

    final amountText = walletControllerInvest.amountController.text.trim();

    if (amountText.isEmpty) {
      showToast(
        message: 'Please enter withdrawal amount',
        typeCheck: false,
      );
      return;
    }

    final double? amount = double.tryParse(amountText);

    if (amount == null || amount <= 0) {
      showToast(
        message: 'Please enter a valid withdrawal amount',
        typeCheck: false,
      );
      return;
    }

    // ----------------------------------------------------------
    // 4. Available balance
    // ----------------------------------------------------------

    final double availableBalance = double.tryParse(
          authControllerInvest.userModelInvest?.walletAmount ?? '',
        ) ??
        0.0;

    if (amount > availableBalance) {
      showToast(
        message:
            'Available balance is ${authControllerInvest.userModelInvest?.amountAvailableForWithdrawalFormat}',
        typeCheck: false,
      );
      return;
    }

    // ----------------------------------------------------------
    // 5. Minimum amount
    // ----------------------------------------------------------

    final double minAmount = double.tryParse(
          withdrawSetting.minAmt ?? '',
        ) ??
        0.0;

    if (minAmount > 0 && amount < minAmount) {
      showToast(
        message:
            'Minimum withdrawal amount is ₹${minAmount.toStringAsFixed(0)}',
        typeCheck: false,
      );
      return;
    }

    // ----------------------------------------------------------
    // 6. Maximum amount
    // ----------------------------------------------------------

    final double maxAmount = double.tryParse(
          withdrawSetting.maxAmt ?? '',
        ) ??
        0.0;

    if (maxAmount > 0 && amount > maxAmount) {
      showToast(
        message:
            'Maximum withdrawal amount is ₹${maxAmount.toStringAsFixed(0)}',
        typeCheck: false,
      );
      return;
    }

    // ----------------------------------------------------------
    // 7. Check bank account
    // ----------------------------------------------------------

    final selectedBank = walletControllerInvest.selectBank;

    if (selectedBank == null) {
      showToast(
        message: 'Please select a bank account',
        typeCheck: false,
      );
      return;
    }

    // ----------------------------------------------------------
    // 8. Check bank ID
    // ----------------------------------------------------------

    final String bankId = selectedBank.id?.toString() ?? '';

    if (bankId.isEmpty) {
      showToast(
        message: 'Invalid bank account',
        typeCheck: false,
      );
      return;
    }

    // ----------------------------------------------------------
    // 9. Call withdrawal API
    // ----------------------------------------------------------

    final response = await walletControllerInvest.withdrawFundsInvest();

    // ----------------------------------------------------------
    // 10. Response
    // ----------------------------------------------------------

    showToast(
      message: response.message,
      typeCheck: response.isSuccess,
    );

    if (response.isSuccess) {
      walletControllerInvest.amountController.clear();

      walletControllerInvest.adminFee = null;

      walletControllerInvest.update();

      if (context.mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          'Withdraw Funds',
          style: Helper(context).textTheme.bodyLarge?.copyWith(
                fontSize: 18.sp,
              ),
        ),
      ),
      bottomNavigationBar: GetBuilder<BankControllerInvest>(
        builder: (bankControllerInvest) {
          return GetBuilder<WalletControllerInvest>(
            builder: (walletControllerInvest) {
              return Padding(
                padding: AppConstants.screenPadding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButton(
                      onTap: bankControllerInvest.isLoading
                          ? null
                          : () {
                              _submitWithdrawal(
                                context,
                              );
                            },
                      height: 56,
                      gradient: goldGradient,
                      borderColor: primaryColor,
                      isLoading: bankControllerInvest.isLoading,
                      child: CustomText(
                        'Withdraw ${walletControllerInvest.netCreditedAmount ?? ""}',
                        style: Helper(context).textTheme.titleMedium?.copyWith(
                              fontSize: 14.sp,
                              color: black,
                            ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            const AvailableBalanceWidget(),
            sizedBoxHeight(
              height: 26,
            ),
            const WithdrawalAmountWidget(),
            sizedBoxHeight(
              height: 26,
            ),
            const SelectBankWidget(),
            sizedBoxHeight(
              height: 26,
            ),
            const WithdrawalSummaryWidget(),
          ],
        ),
      ),
    );
  }
}
