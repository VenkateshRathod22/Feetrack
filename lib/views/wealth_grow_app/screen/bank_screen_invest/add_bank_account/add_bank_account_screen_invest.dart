import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:vlr/controllers/invest_controller/bank_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/wealth_grow_app/screen/bank_screen_invest/add_bank_account/widget/bank_account_intro_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/bank_screen_invest/add_bank_account/widget/bank_details_form_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/bank_screen_invest/add_bank_account/widget/bank_verification_info_invest.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class AddBankAccountScreenInvest extends StatefulWidget {
  const AddBankAccountScreenInvest({
    super.key,
  });

  @override
  State<AddBankAccountScreenInvest> createState() =>
      _AddBankAccountScreenInvestState();
}

class _AddBankAccountScreenInvestState
    extends State<AddBankAccountScreenInvest> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BankControllerInvest>(
      builder: (bankControllerInvest) {
        return Scaffold(
          // =====================================================
          // APP BAR
          // =====================================================
          appBar: AppBar(
            titleSpacing: 20.w,
            title: CustomText(
              'Add Bank Account',
              style: Helper(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                  ),
            ),
          ),

          // =====================================================
          // ADD BANK BUTTON
          // =====================================================
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: AppConstants.screenPadding,
              child: CustomButton(
                onTap: () async {
                  FocusScope.of(context).unfocus();

                  // Validate fields
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  // Confirm account number
                  if (bankControllerInvest.accountNumberController.text
                          .trim() !=
                      bankControllerInvest.confirmAccountNumberController.text
                          .trim()) {
                    showToast(
                      message:
                          'Account number and confirm account number do not match',
                      typeCheck: false,
                    );
                    return;
                  }

                  // Add bank API
                  final response =
                      await bankControllerInvest.addBankAccountInvest();

                  if (!mounted) {
                    return;
                  }

                  // Show API response
                  showToast(
                    message: response.message,
                    typeCheck: response.isBlank,
                  );

                  // Navigate back only on success
                  if (response.isSuccess) {
                    Navigator.pop(
                      context,
                      true,
                    );
                  }
                },
                isLoading: bankControllerInvest.isLoading,
                color: primaryColor,
                borderColor: primaryColor,
                borderWidth: 1,
                height: 56,
                radius: 18,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_balance_outlined,
                      size: 20.r,
                      color: black,
                    ),
                    sizedBoxWidth(width: 8),
                    CustomText(
                      'Add Bank Account',
                      style: Helper(context).textTheme.titleMedium?.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: black,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // =====================================================
          // BODY
          // =====================================================
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: AppConstants.screenPadding,
                physics: const BouncingScrollPhysics(),
                children: [
                  const BankAccountIntroInvest(),
                  sizedBoxHeight(height: 24),
                  BankDetailsFormInvest(
                    bankNameController: bankControllerInvest.bankNameController,
                    accountHolderController:
                        bankControllerInvest.accountHolderController,
                    accountNumberController:
                        bankControllerInvest.accountNumberController,
                    confirmAccountNumberController:
                        bankControllerInvest.confirmAccountNumberController,
                    ifscController: bankControllerInvest.ifscController,
                    accountType: bankControllerInvest.accountType,
                    onAccountTypeChanged: (value) {
                      bankControllerInvest.setAccountType(value);
                    },
                  ),
                  sizedBoxHeight(height: 24),
                  const BankVerificationInfoInvest(),
                  sizedBoxHeight(height: 100),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
