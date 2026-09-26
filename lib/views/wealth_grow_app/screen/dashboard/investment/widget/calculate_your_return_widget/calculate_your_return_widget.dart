import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class CalculateYourReturnWidget extends StatelessWidget {
  const CalculateYourReturnWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
      decoration: BoxDecoration(
          color: cardWhite, borderRadius: BorderRadius.circular(22.r)),
      child: Row(
        children: [
          CustomImage(
            path: Assets.imagesCalculate,
            height: 52.h,
            width: 48.w,
            fit: BoxFit.cover,
          ),
          sizedBoxWidth(width: 14.r),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  "Calculate Your Returns",
                  style: Helper(context).textTheme.titleMedium?.copyWith(
                        fontSize: 15.sp,
                        color: textDarkPrimary,
                      ),
                ),
                sizedBoxHeight(height: 2),
                CustomText(
                  "Use our investment calculator",
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12.sp,
                        color: textSecondary,
                      ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 18.sp,
            color: textDarkSecondary,
          )
        ],
      ),
    );
  }
}
