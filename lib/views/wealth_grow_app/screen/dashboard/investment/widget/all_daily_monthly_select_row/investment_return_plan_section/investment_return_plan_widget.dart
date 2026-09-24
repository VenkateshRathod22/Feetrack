import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class InvestmentReturnPlanWidget extends StatelessWidget {
  const InvestmentReturnPlanWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              CustomImage(
                path: Assets.imagesReturnPlan,
                height: 56.h,
                width: 56.w,
                fit: BoxFit.cover,
              ),
              sizedBoxWidth(width: 14.w),
              Column(
                children: [
                  CustomText(
                    "Daily Return Plan",
                    style: Helper(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 12.sp, color: black),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
