import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class WelthGrowDepositFundsTopSection extends StatelessWidget {
  const WelthGrowDepositFundsTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: cardDartBg,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.security,
                color: green,
                size: 18.sp,
              ),
              sizedBoxWidth(width: 4.w),
              Expanded(
                child: CustomText(
                  "VERIFIED CORPORATE DEPOSITORY",
                  overflow: TextOverflow.clip,
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        color: green,
                      ),
                ),
              ),
            ],
          ),
          sizedBoxHeight(height: 8.h),
          CustomText(
            "Transfer funds securely via IMPS, NEFT, RTGS or any standard UPI application. Zero convenience surcharge.",
            overflow: TextOverflow.clip,
            style: Helper(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  color: textPrimary1,
                ),
          ),
        ],
      ),
    );
  }
}
