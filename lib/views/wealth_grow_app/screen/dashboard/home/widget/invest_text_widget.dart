import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class InvestedTextWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color titleColor;
  const InvestedTextWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          title,
          style: Helper(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontSize: 14.sp, color: titleColor),
        ),
        sizedBoxHeight(height: 2),
        CustomText(
          subTitle,
          style: Helper(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontSize: 12.sp, color: textSecondary),
        ),
      ],
    );
  }
}
