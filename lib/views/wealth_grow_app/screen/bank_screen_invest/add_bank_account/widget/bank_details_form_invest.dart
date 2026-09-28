import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';
import 'package:vlr/views/widget/text_box/app_text_box.dart';

class BankDetailsFormInvest extends StatelessWidget {
  final TextEditingController bankNameController;
  final TextEditingController accountHolderController;
  final TextEditingController accountNumberController;
  final TextEditingController confirmAccountNumberController;
  final TextEditingController ifscController;

  final String accountType;
  final ValueChanged<String> onAccountTypeChanged;

  const BankDetailsFormInvest({
    super.key,
    required this.bankNameController,
    required this.accountHolderController,
    required this.accountNumberController,
    required this.confirmAccountNumberController,
    required this.ifscController,
    required this.accountType,
    required this.onAccountTypeChanged,
  });

  TextStyle _headingStyle(BuildContext context) {
    return Helper(context).textTheme.bodyLarge!.copyWith(
          fontSize: 13.sp,
          letterSpacing: 0.7,
        );
  }

  TextStyle _hintStyle(BuildContext context) {
    return Helper(context).textTheme.bodyMedium!.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: textMuted,
        );
  }

  TextStyle _textStyle(BuildContext context) {
    return Helper(context).textTheme.bodyMedium!.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: textPrimary,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          'BANK DETAILS',
          style: Helper(context).textTheme.bodyLarge?.copyWith(
                fontSize: 12.sp,
                letterSpacing: 0.7,
              ),
        ),

        sizedBoxHeight(height: 14),

        // =========================================================
        // BANK NAME
        // =========================================================

        AppTextFieldWithHeading(
          controller: bankNameController,
          headingWidget: CustomText(
            'Bank Name',
            style: _headingStyle(context),
          ),
          hindText: 'Enter bank name',
          isRequired: true,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          borderWidth: 1,
          borderRadius: 14,
          textStyle: _textStyle(context),
          hintStyle: _hintStyle(context),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter bank name';
            }

            return null;
          },
        ),

        sizedBoxHeight(height: 16),

        // =========================================================
        // ACCOUNT HOLDER NAME
        // =========================================================

        AppTextFieldWithHeading(
          controller: accountHolderController,
          headingWidget: CustomText(
            'Account Holder Name',
            style: _headingStyle(context),
          ),
          hindText: 'Enter account holder name',
          isRequired: true,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          borderWidth: 1,
          borderRadius: 14,
          textStyle: _textStyle(context),
          hintStyle: _hintStyle(context),
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'[a-zA-Z .]'),
            ),
          ],
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter account holder name';
            }

            return null;
          },
        ),

        sizedBoxHeight(height: 16),

        // =========================================================
        // ACCOUNT NUMBER
        // =========================================================

        AppTextFieldWithHeading(
          controller: accountNumberController,
          headingWidget: CustomText(
            'Account Number',
            style: _headingStyle(context),
          ),
          hindText: 'Enter account number',
          isRequired: true,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          borderWidth: 1,
          borderRadius: 14,
          textStyle: _textStyle(context).copyWith(
            letterSpacing: 0.5,
          ),
          hintStyle: _hintStyle(context),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(18),
          ],
          validator: (value) {
            final text = value?.trim() ?? '';

            if (text.isEmpty) {
              return 'Please enter account number';
            }

            if (text.length < 9) {
              return 'Enter a valid account number';
            }

            return null;
          },
        ),

        sizedBoxHeight(height: 16),

        // =========================================================
        // CONFIRM ACCOUNT NUMBER
        // =========================================================

        AppTextFieldWithHeading(
          controller: confirmAccountNumberController,
          headingWidget: CustomText(
            'Confirm Account Number',
            style: _headingStyle(context),
          ),
          hindText: 'Re-enter account number',
          isRequired: true,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          borderWidth: 1,
          borderRadius: 14,
          textStyle: _textStyle(context).copyWith(
            letterSpacing: 0.5,
          ),
          hintStyle: _hintStyle(context),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(18),
          ],
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please confirm account number';
            }

            return null;
          },
        ),

        sizedBoxHeight(height: 16),

        // =========================================================
        // IFSC CODE
        // =========================================================

        AppTextFieldWithHeading(
          controller: ifscController,
          headingWidget: CustomText(
            'IFSC Code',
            style: _headingStyle(context),
          ),
          hindText: 'Enter IFSC code',
          isRequired: true,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          borderWidth: 1,
          borderRadius: 14,
          textStyle: _textStyle(context).copyWith(
            letterSpacing: 0.8,
          ),
          hintStyle: _hintStyle(context),
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'[a-zA-Z0-9]'),
            ),
            LengthLimitingTextInputFormatter(11),
            UpperCaseTextFormatterInvest(),
          ],
          validator: (value) {
            final text = value?.trim() ?? '';

            if (text.isEmpty) {
              return 'Please enter IFSC code';
            }

            if (text.length != 11) {
              return 'IFSC code must contain 11 characters';
            }

            return null;
          },
        ),

        sizedBoxHeight(height: 20),

        // =========================================================
        // ACCOUNT TYPE
        // =========================================================

        CustomText(
          'Account Type',
          style: Helper(context).textTheme.bodyLarge?.copyWith(
                fontSize: 13.sp,
                letterSpacing: 0.7,
              ),
        ),

        sizedBoxHeight(height: 8),

        Row(
          children: [
            Expanded(
              child: AccountTypeOptionInvest(
                title: 'Savings',
                icon: Icons.savings_outlined,
                isSelected: accountType == 'Savings',
                onTap: () {
                  onAccountTypeChanged('Savings');
                },
              ),
            ),
            sizedBoxWidth(width: 12),
            Expanded(
              child: AccountTypeOptionInvest(
                title: 'Current',
                icon: Icons.account_balance_wallet_outlined,
                isSelected: accountType == 'Current',
                onTap: () {
                  onAccountTypeChanged('Current');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AccountTypeOptionInvest extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const AccountTypeOptionInvest({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 15.h,
        ),
        decoration: BoxDecoration(
          color:
              isSelected ? primaryColor.withValues(alpha: 0.10) : surfaceNavy,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? primaryColor : borderDark,
            width: isSelected ? 1.3.w : 1.w,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20.r,
              color: isSelected ? primaryColor : textSecondary,
            ),
            sizedBoxWidth(width: 8),
            CustomText(
              title,
              style: Helper(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: isSelected ? primaryColor : textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpperCaseTextFormatterInvest extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
