import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';
import 'package:vlr/controllers/basic_controller.dart';
import 'package:vlr/controllers/invest_controller/auth_controller_invest.dart';
import 'package:vlr/controllers/invest_controller/basic_controller_invest.dart';
import 'package:vlr/controllers/invest_controller/investment_controller_invest.dart';

import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/wealth_grow_app/investment_app.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class SelectPaymentMethodScreenInvest extends StatefulWidget {
  const SelectPaymentMethodScreenInvest({
    super.key,
  });

  @override
  State<SelectPaymentMethodScreenInvest> createState() =>
      _SelectPaymentMethodScreenInvestState();
}

class _SelectPaymentMethodScreenInvestState
    extends State<SelectPaymentMethodScreenInvest> {
  String selectedPaymentMethod = 'wallet';

  void _selectPaymentMethod(String method) {
    setState(() {
      selectedPaymentMethod = method;
    });
  }

  Widget _buildPaymentOption({
    required String value,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final bool isSelected = selectedPaymentMethod == value;

    return GestureDetector(
      onTap: () => _selectPaymentMethod(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color:
              isSelected ? primaryColor.withValues(alpha: 0.08) : surfaceNavy,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? primaryColor : borderDark,
            width: isSelected ? 1.4.w : 1.w,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? primaryColor.withValues(alpha: 0.15)
                    : surfaceLow,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(
                icon,
                color: isSelected ? primaryColor : textSecondary,
                size: 24.w,
              ),
            ),
            sizedBoxWidth(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title,
                    style: Helper(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: textPrimary,
                        ),
                  ),
                  sizedBoxHeight(height: 4),
                  CustomText(
                    subtitle,
                    style: Helper(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            sizedBoxWidth(width: 10),
            Container(
              width: 22.w,
              height: 22.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? primaryColor : textMuted,
                  width: 1.5.w,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10.w,
                        height: 10.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      appBar: AppBar(
        backgroundColor: backgroundDark,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: textPrimary,
            size: 20.w,
          ),
        ),
        title: CustomText(
          'Select Payment Method',
          style: Helper(context).textTheme.titleLarge?.copyWith(
                fontSize: 19.sp,
                fontWeight: FontWeight.w700,
                color: textPrimary,
              ),
        ),
      ),
      body: Padding(
        padding: AppConstants.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedBoxHeight(height: 10),

            CustomText(
              'Choose how you want to pay',
              style: Helper(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    color: textPrimary,
                  ),
            ),

            sizedBoxHeight(height: 6),

            CustomText(
              'Select one payment method to continue with your investment.',
              style: Helper(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 13.sp,
                    color: textSecondary,
                    height: 1.5,
                  ),
            ),

            sizedBoxHeight(height: 28),

            // Wallet
            _buildPaymentOption(
              value: 'wallet',
              title: 'Wallet',
              subtitle: 'Pay using your available wallet balance',
              icon: Icons.account_balance_wallet_outlined,
            ),

            sizedBoxHeight(height: 14),

            // Pay Online
            _buildPaymentOption(
              value: 'online',
              title: 'Pay Online',
              subtitle: 'Pay securely using UPI, Card or Net Banking',
              icon: Icons.payment_outlined,
            ),

            const Spacer(),

            GetBuilder<InvestmentControllerInvest>(
                builder: (investmentControllerInvest) {
              return GetBuilder<AuthControllerInvest>(
                  builder: (authControllerInvest) {
                return GetBuilder<BasicControllerInvest>(
                    builder: (basicControllerInvest) {
                  return CustomButton(
                    onTap: () {
                      String userSponsorCode =
                          "${basicControllerInvest.appSettingInvestModel?.setting?.pre ?? ""}${authControllerInvest.userModelInvest?.sponsorCode ?? ""}";
                      if (selectedPaymentMethod == 'wallet') {
                        investmentControllerInvest
                            .investmentInvest(
                                isActivationRequest: authControllerInvest
                                        .userModelInvest?.isUserActive ??
                                    false,
                                userSponsorCode: userSponsorCode)
                            .then((value) {
                          if (value.isSuccess) {
                            Navigator.of(context).pushNamed(
                              InvestmentApp.investmentSuccessfulScreenInvest,
                            );
                            showToast(
                                message: value.message,
                                typeCheck: value.isSuccess);
                          } else {
                            showToast(
                                message: value.message,
                                typeCheck: value.isSuccess);
                          }
                        });
                        debugPrint('Selected Payment Method: Wallet');
                      } else {
                        debugPrint('Selected Payment Method: Pay Online');
                      }
                    },
                    height: 56.h,
                    radius: 18.r,
                    gradient: goldGradient,
                    borderColor: primaryColor,
                    child: CustomText(
                      'Continue',
                      style: Helper(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 15.sp,
                            color: neutralColor,
                          ),
                    ),
                  );
                });
              });
            }),

            sizedBoxHeight(height: 12),

            Center(
              child: CustomText(
                selectedPaymentMethod == 'wallet'
                    ? 'Wallet payment selected'
                    : 'Online payment selected',
                style: Helper(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12.sp,
                      color: textMuted,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
