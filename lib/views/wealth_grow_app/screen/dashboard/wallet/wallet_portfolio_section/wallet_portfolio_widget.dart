import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class WalletPortfolioWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onTap;
  const WalletPortfolioWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: neutralBorder),
              color: cardBackground,
            ),
            child: Center(
              child: Icon(
                icon,
                color: primaryColor,
                size: 22.sp,
              ),
            ),
          ),
          sizedBoxHeight(height: 6),
          CustomText(
            title,
            style: Helper(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 12.sp, color: textGray),
          ),
        ],
      ),
    );
  }
}
