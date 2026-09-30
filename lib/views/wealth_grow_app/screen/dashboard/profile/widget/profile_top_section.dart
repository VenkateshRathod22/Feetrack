import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/auth_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class ProfileTopSectionInvest extends StatelessWidget {
  const ProfileTopSectionInvest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthControllerInvest>(builder: (authControllerInvest) {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: 20.h,
          horizontal: 24.w,
        ),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: primaryColor)),
              child: CustomImage(
                path: authControllerInvest.userModelInvest?.image ?? "",
                height: 52.h,
                width: 52.w,
                fit: BoxFit.cover,
                isProfile: true,
              ),
            ),
            sizedBoxWidth(width: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  authControllerInvest.userModelInvest?.name ?? '',
                  style: Helper(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 17.sp),
                ),
                sizedBoxHeight(height: 2.h),
                CustomText(
                  authControllerInvest.userModelInvest?.email ?? '',
                  style: Helper(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 12.sp, color: textSecondary),
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
