import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';

import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class BankVerificationInfoInvest extends StatelessWidget {
  const BankVerificationInfoInvest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF172554).withValues(
          alpha: 0.25,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF1E3A8A).withValues(
            alpha: 0.40,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: blue.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.security_outlined,
              size: 17.r,
              color: blue,
            ),
          ),

          sizedBoxWidth(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'Bank Verification',
                  style: Helper(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                      ),
                ),

                sizedBoxHeight(height: 5),

                CustomText(
                  'Make sure your bank account details match '
                  'the name registered with your WealthGrow account. '
                  'Third-party bank accounts are not allowed.',
                  style: Helper(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.55,
                        color: textSecondary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}