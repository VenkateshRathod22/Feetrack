import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class InvestmentCardStateWidget extends StatelessWidget {
  const InvestmentCardStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999.r),
          color: green.withValues(alpha: 0.10),
          border: Border.all(
            width: 1,
            color: green.withValues(alpha: 0.20),
          )),
      child: CustomText(
        "Active",
        style: Helper(context).textTheme.bodyLarge?.copyWith(
              fontSize: 12.sp,
              color: green,
            ),
      ),
    );
  }
}
