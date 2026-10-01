import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/screen/auth/user_profile_invest/user_profile_screen_invest/widget/user_profile_account_identity_section/user_profile_account_identity_section.dart';
import 'package:vlr/views/wealth_grow_app/screen/auth/user_profile_invest/user_profile_screen_invest/widget/user_profile_reset_password_section.dart';
import 'package:vlr/views/wealth_grow_app/screen/auth/user_profile_invest/user_profile_screen_invest/widget/user_proflie_top_section_invest.dart';

class UserProfileScreenInvest extends StatelessWidget {
  const UserProfileScreenInvest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          "Profile",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 24.sp,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const UserProfileTopSectionInvest(),
              sizedBoxHeight(height: 48.h),
              const UserProfileAccountIdentitySection(),
              sizedBoxHeight(height: 26.h),
              UserProfileAccountResetPasswordSection()

            ],
          ),
        ),
      ),
    );
  }
}
