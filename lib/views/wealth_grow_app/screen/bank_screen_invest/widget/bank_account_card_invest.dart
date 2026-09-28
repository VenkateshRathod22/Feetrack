import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:vlr/data/models/invest_model/bank_model_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/wealth_grow_app/screen/bank_screen_invest/widget/investment_card_state_widget.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class BankAccountCardInvest extends StatefulWidget {
  final BankModelInvest bank;

  const BankAccountCardInvest({
    super.key,
    required this.bank,
  });

  @override
  State<BankAccountCardInvest> createState() => _BankAccountCardInvestState();
}

class _BankAccountCardInvestState extends State<BankAccountCardInvest> {
  bool _isAccountVisible = false;

  String _maskedAccountNumber(String accountNumber) {
    if (accountNumber.isEmpty) {
      return '•••• ••••';
    }

    if (accountNumber.length <= 4) {
      return '•••• $accountNumber';
    }

    final lastFour = accountNumber.substring(
      accountNumber.length - 4,
    );

    return '•••• •••• $lastFour';
  }

  @override
  Widget build(BuildContext context) {
    final bank = widget.bank;

    final bool isActive = bank.status.toString() == '1';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: cardDartBg,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: cardDartBorderColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 24.r,
            offset: Offset(0, 12.h),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -32.w,
            bottom: -32.h,
            child: Container(
              width: 144.w,
              height: 144.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withValues(alpha: 0.10),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(21.w),
            child: Column(
              children: [
                _buildTopSection(
                  context,
                  bank,
                  isActive,
                ),
                SizedBox(height: 16.h),
                Divider(
                  height: 1.h,
                  thickness: 1.h,
                  color: whiteDivider,
                ),
                SizedBox(height: 16.h),
                _buildAccountNumberSection(
                  context,
                  bank,
                ),
                SizedBox(height: 16.h),
                Divider(
                  height: 1.h,
                  thickness: 1.h,
                  color: whiteDivider,
                ),
                SizedBox(height: 12.h),
                _buildHolderAndIfscSection(
                  context,
                  bank,
                ),
                SizedBox(height: 13.h),
                Divider(
                  height: 1.h,
                  thickness: 1.h,
                  color: whiteDivider,
                ),
                SizedBox(height: 13.h),
                _buildBottomSection(
                  context,
                  bank,
                  isActive,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSection(
    BuildContext context,
    BankModelInvest bank,
    bool isActive,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImage(
          path: Assets.imagesBankBg,
          height: 54.h,
          width: 54.w,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                bank.bankName ?? "",
                maxLines: 2,
                style: Helper(context).textTheme.titleMedium?.copyWith(
                      fontSize: 16.sp,
                      letterSpacing: -0.4,
                    ),
              ),
              SizedBox(height: 2.h),
              CustomText(
                "${bank.accountType ?? ""} Account",
                style: Helper(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12.sp,
                      color: textSecondary,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        InvestmentCardStateWidget(),
      ],
    );
  }

  Widget _buildAccountNumberSection(
    BuildContext context,
    BankModelInvest bank,
  ) {
    String? accountText = _isAccountVisible
        ? bank.accountNo
        : _maskedAccountNumber(bank.accountNo ?? "");

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                'ACCOUNT NUMBER',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 11.sp,
                      letterSpacing: 0.55,
                      color: textDarkMuted,
                    ),
              ),
              SizedBox(height: 4.h),
              CustomText(
                accountText ?? "",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isAccountVisible = !_isAccountVisible;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 13.w,
              vertical: 7.h,
            ),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: primaryColor,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _isAccountVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 14.r,
                  color: primaryColor,
                ),
                SizedBox(width: 6.w),
                CustomText(
                  _isAccountVisible ? 'Hide' : 'Reveal',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHolderAndIfscSection(
    BuildContext context,
    BankModelInvest bank,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoItem(
            context,
            title: 'ACCOUNT HOLDER',
            value: bank.accountHolderName ?? "",
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildInfoItem(
            context,
            title: 'IFSC CODE',
            value: bank.ifsc ?? "",
            mono: true,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required String title,
    required String value,
    bool mono = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          maxLines: 1,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.55,
                color: textDarkMuted,
              ),
        ),
        SizedBox(height: 3.h),
        CustomText(
          value.isEmpty ? '-' : value,
          maxLines: 1,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: mono ? 0.35 : 0,
              ),
        ),
      ],
    );
  }

  Widget _buildBottomSection(
    BuildContext context,
    BankModelInvest bank,
    bool isActive,
  ) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            // _showDeleteMessage(context);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.delete_forever,
                color: red1,
              ),
              SizedBox(width: 6.w),
              CustomText(
                'Delete Bank Account',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: red1,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
