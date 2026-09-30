import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class TransactionStatusWidget extends StatelessWidget {
  final bool isApproved;
  const TransactionStatusWidget({super.key, required this.isApproved});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999.r),
          color: isApproved
              ? green.withValues(alpha: 0.10)
              : red1.withValues(alpha: 0.10),
          border: Border.all(
            width: 1,
            color: isApproved
                ? green.withValues(alpha: 0.20)
                : red1.withValues(alpha: 0.20),
          )),
      child: Row(
        children: [
          CircleAvatar(
            radius: 3.r,
            backgroundColor: isApproved ? green : primaryColor,
          ),
          sizedBoxWidth(width: 6.w),
          CustomText(
            isApproved ? "Approved" : "Pending",
            style: Helper(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 12.sp,
                  color: isApproved ? green : primaryColor,
                ),
          ),
        ],
      ),
    );
  }
}
