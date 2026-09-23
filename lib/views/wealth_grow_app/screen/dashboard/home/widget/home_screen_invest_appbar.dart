import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class HomeScreenInvestAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const HomeScreenInvestAppbar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.only(left: AppConstants.horizontalPadding),
        child: Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: primaryColor),
              shape: BoxShape.circle),
          child: CustomImage(
            path: Assets.imagesNoProfile,
            height: 44.h,
            width: 44.w,
            radius: 99,
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomText(
                "Hello, Sharat",
                style: Helper(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 16.sp),
              ),
            ],
          ),
          sizedBoxHeight(height: 2),
          CustomText(
            "Let’s grow your wealth",
            style: Helper(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontSize: 14.sp, color: textSecondary),
          ),
        ],
      ),
      actions: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.w),
          decoration: BoxDecoration(
            color: white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: const Color(0xFF33415580),
            ),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: -2,
                  color: black.withValues(alpha: 0.10)),
              BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 6,
                  spreadRadius: -1,
                  color: black.withValues(alpha: 0.10))
            ],
          ),
          child: SvgPicture.asset(
            Assets.svgsNotification,
            width: 18.w,
            height: 18.h,
          ),
        ),
        sizedBoxWidth(width: 20)
      ],
    );
  }
}
