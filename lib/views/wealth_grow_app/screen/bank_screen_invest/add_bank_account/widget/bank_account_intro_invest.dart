import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';

import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class BankAccountIntroInvest extends StatelessWidget {
  const BankAccountIntroInvest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        gradient: cardDarkGradient,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: neutralBorder,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46.w,
            height: 46.w,
            decoration: BoxDecoration(
              color: primaryColor.withValues(
                alpha: 0.12,
              ),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              Icons.account_balance_rounded,
              color: primaryColor,
              size: 24.r,
            ),
          ),

          sizedBoxWidth(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'Link Your Bank Account',
                  style: Helper(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                      ),
                ),

                sizedBoxHeight(height: 6),

                CustomText(
                  'Add a verified bank account to receive '
                  'your investment settlements securely.',
                  style: Helper(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
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