import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/wealth_grow_app/investment_app.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class InvestmentSuccessfulScreenInvest extends StatelessWidget {
  final String message;

  const InvestmentSuccessfulScreenInvest({
    super.key,
    this.message = 'Id Upgraded Successfully',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: AppConstants.screenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // ==================================================
              // SUCCESS ICON
              // ==================================================

              Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: green.withValues(alpha: 0.12),
                  border: Border.all(
                    color: green.withValues(alpha: 0.30),
                    width: 1.5.w,
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.all(10.w),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: green,
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    color: white,
                    size: 52.w,
                  ),
                ),
              ),

              sizedBoxHeight(height: 28),

              // ==================================================
              // TITLE
              // ==================================================

              CustomText(
                'Investment Successful',
                textAlign: TextAlign.center,
                style: Helper(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                      color: textPrimary,
                    ),
              ),

              sizedBoxHeight(height: 10),

              // ==================================================
              // MESSAGE
              // ==================================================

              CustomText(
                message,
                textAlign: TextAlign.center,
                style: Helper(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: textSecondary,
                      height: 1.5,
                    ),
              ),

              sizedBoxHeight(height: 18),

              // ==================================================
              // SUB MESSAGE
              // ==================================================

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: surfaceNavy,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: borderDark,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.verified_outlined,
                      color: primaryColor,
                      size: 22.w,
                    ),
                    sizedBoxWidth(width: 10),
                    Expanded(
                      child: CustomText(
                        'Your investment request has been processed successfully.',
                        overflow: TextOverflow.clip,
                        style: Helper(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 12.sp,
                              color: textSecondaryLight,
                              height: 1.4,
                            ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // ==================================================
              // DONE BUTTON
              // ==================================================

              CustomButton(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    InvestmentApp.myInvestmentsScreenInvest,
                  );
                },
                height: 56,
                radius: 18,
                gradient: goldGradient,
                borderColor: primaryColor,
                child: CustomText(
                  'Done',
                  style: Helper(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: neutralColor,
                      ),
                ),
              ),

              sizedBoxHeight(height: 12),

              CustomText(
                'Thank you for investing with us',
                textAlign: TextAlign.center,
                style: Helper(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12.sp,
                      color: textMuted,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
