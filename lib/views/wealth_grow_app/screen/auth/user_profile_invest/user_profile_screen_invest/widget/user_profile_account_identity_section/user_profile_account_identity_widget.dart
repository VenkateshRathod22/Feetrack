import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class UserProfileAccountIdentityWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;

  const UserProfileAccountIdentityWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            height: 46.h,
            width: 46.w,
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColorLight.withValues(
                alpha: 0.1,
              ),
            ),
            child: Icon(
              icon,
              color: primaryColor,
            ),
          ),
          sizedBoxWidth(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title,
                style: Helper(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 13.sp, color: textPrimary1),
              ),
              sizedBoxHeight(height: 4.h),
              CustomText(
                subTitle,
                overflow: TextOverflow.ellipsis,
                style: Helper(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 14.sp,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
