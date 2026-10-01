import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';
import 'package:vlr/controllers/invest_controller/auth_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/wealth_grow_app/screen/auth/user_profile_invest/user_profile_screen_invest/widget/user_profile_account_identity_section/user_profile_account_identity_widget.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class UserProfileAccountIdentitySection extends StatelessWidget {
  const UserProfileAccountIdentitySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthControllerInvest>(builder: (authControllerInvest) {
      return Container(
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: cardDartBg,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.badge_outlined,
                  size: 18.sp,
                ),
                sizedBoxWidth(width: 4.w),
                Expanded(
                  child: CustomText(
                    "ACCOUNT IDENTITY",
                    style: Helper(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 13.sp,
                        ),
                  ),
                ),
                CustomButton(
                  onTap: () {},
                  type: ButtonType.tertiary,
                  child: CustomText(
                    "Edit Details",
                    style: Helper(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 13.sp, color: textPrimary1),
                  ),
                ),
              ],
            ),
            sizedBoxHeight(height: 24.h),
            UserProfileAccountIdentityWidget(
                icon: Icons.person_outline,
                title: "Full Name",
                subTitle: authControllerInvest.userModelInvest?.name ?? ""),
            sizedBoxHeight(height: 24.h),
            UserProfileAccountIdentityWidget(
                icon: Icons.phone_outlined,
                title: "Registered Phone",
                subTitle: authControllerInvest.userModelInvest?.mobile ?? ""),
            sizedBoxHeight(height: 24.h),
            UserProfileAccountIdentityWidget(
                icon: Icons.email_outlined,
                title: "Email",
                subTitle: authControllerInvest.userModelInvest?.email ?? ""),
            sizedBoxHeight(height: 24.h),
            UserProfileAccountIdentityWidget(
                icon: Icons.location_on_outlined,
                title: "Address",
                subTitle: authControllerInvest.userModelInvest?.address ?? ""),
            sizedBoxHeight(height: 16.h),
          ],
        ),
      );
    });
  }
}
