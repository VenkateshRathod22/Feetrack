import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';
import 'package:vlr/controllers/invest_controller/auth_controller_invest.dart';
import 'package:vlr/controllers/invest_controller/basic_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class UserProfileTopSectionInvest extends StatelessWidget {
  const UserProfileTopSectionInvest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthControllerInvest>(
      builder: (authControllerInvest) {
        return GetBuilder<BasicControllerInvest>(
            builder: (basicControllerInvest) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100.w,
                width: 100.w,
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: primaryColor,
                    width: 2.w,
                  ),
                ),
                child: ClipOval(
                  child: CustomImage(
                    path: authControllerInvest.userModelInvest?.profileImage ??
                        "",
                    height: 92.w,
                    width: 92.w,
                    fit: BoxFit.cover,
                    isProfile: true,
                  ),
                ),
              ),
              sizedBoxHeight(height: 16.h),
              CustomText(
                authControllerInvest.userModelInvest?.name ?? "",
                style: Helper(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 24.sp,
                    ),
              ),
              sizedBoxHeight(height: 4.h),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.h,
                    horizontal: 12.w,
                  ),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: surfaceLow),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        "User ID: ",
                        style: Helper(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 12.sp, color: textPrimary1),
                      ),
                      CustomText(
                        "${basicControllerInvest.appSettingInvestModel?.setting?.pre ?? ""} ${authControllerInvest.userModelInvest?.sponsorCode ?? ""}",
                        style: Helper(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 12.sp,
                            ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        });
      },
    );
  }
}
