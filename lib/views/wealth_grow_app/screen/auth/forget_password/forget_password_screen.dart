import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:vlr/controllers/invest_controller/auth_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/wealth_grow_app/screen/widget/invest_appbar/invest_appbar_widget.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';
import 'package:vlr/views/widget/text_box/app_text_box.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InvestAppBarWidget(
        title: "Forget Password",
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child:
            GetBuilder<AuthControllerInvest>(builder: (authControllerInvest) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImage(
                  path: Assets.imagesLockoBg,
                  height: 160.h,
                  width: 160.w,
                  fit: BoxFit.cover,
                ),
                CustomText(
                  "Forgot Password?",
                  style: Helper(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 24.sp,
                      ),
                ),
                sizedBoxHeight(height: 8.h),
                CustomText(
                  "Enter your registered User ID. We will dispatch a 6–digit verification code to your registered email to recover access.",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        color: primaryColorLight,
                      ),
                ),
                sizedBoxHeight(height: 32.h),
                AppTextFieldWithHeading(
                  controller: authControllerInvest.userIdController,
                  headingWidget: CustomText(
                    "User ID",
                    style: Helper(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 13.sp, color: primaryColorLight),
                  ),
                  preFixWidget: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: SvgPicture.asset(
                      Assets.svgsPerson,
                      height: 20.h,
                      width: 20.w,
                      colorFilter:
                          const ColorFilter.mode(textGray, BlendMode.srcIn),
                    ),
                  ),
                  hintStyle: Helper(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 14.sp, color: textSecondary),
                  hindText: "User ID",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter use id";
                    }
                    return null;
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
