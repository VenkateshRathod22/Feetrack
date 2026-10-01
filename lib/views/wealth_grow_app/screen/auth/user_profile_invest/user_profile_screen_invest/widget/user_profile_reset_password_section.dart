import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';
import 'package:vlr/controllers/invest_controller/auth_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/investment_app.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class UserProfileAccountResetPasswordSection extends StatefulWidget {
  const UserProfileAccountResetPasswordSection({
    super.key,
  });

  @override
  State<UserProfileAccountResetPasswordSection> createState() =>
      _UserProfileAccountResetPasswordSectionState();
}

class _UserProfileAccountResetPasswordSectionState
    extends State<UserProfileAccountResetPasswordSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: cardDartBg,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.security,
                size: 20.sp,
                color: primaryColor,
              ),
              sizedBoxWidth(width: 4.w),
              CustomText(
                "SECURITY SETTINGS",
                style: Helper(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 13.sp,
                    ),
              ),
            ],
          ),
          sizedBoxHeight(height: 24.h),
          GetBuilder<AuthControllerInvest>(builder: (authControllerInvest) {
            return GestureDetector(
              onTap: authControllerInvest.isLoading
                  ? null
                  : () {
                      authControllerInvest.sendOtpInvest().then((value) {
                        if (value.isSuccess) {
                          showToast(
                              message: value.message,
                              typeCheck: value.isSuccess);
                          Navigator.of(context).pushNamed(
                            InvestmentApp.resetPasswordScreenInvest,
                          );
                        } else {
                          showToast(
                              message: value.message,
                              typeCheck: value.isSuccess);
                        }
                      });
                    },
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
                    child: const Icon(
                      Icons.lock_reset_sharp,
                      color: primaryColor,
                    ),
                  ),
                  sizedBoxWidth(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          "Reset Password",
                          style: Helper(context).textTheme.bodyLarge?.copyWith(
                                fontSize: 14.sp,
                              ),
                        ),
                        sizedBoxHeight(height: 4),
                        CustomText(
                          "Update your account security password",
                          overflow: TextOverflow.ellipsis,
                          style: Helper(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontSize: 12.sp, color: textPrimary1),
                        ),
                      ],
                    ),
                  ),
                  authControllerInvest.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: primaryColorLight2,
                          ),
                        )
                      : Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: primaryColorLight2,
                          size: 20.sp,
                        )
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
