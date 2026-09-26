import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class ReturnWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color subTitleColor;
  const ReturnWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.subTitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          title,
          style: Helper(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontSize: 12.sp, color: textSecondary),
        ),
        CustomText(
          subTitle,
          style: Helper(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontSize: 14.sp, color: subTitleColor),
        ),
      ],
    );
  }
}
