import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/auth_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/wealth_grow_app/investment_app.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';
import 'package:vlr/views/widget/text_box/app_text_box.dart';

class LoginScreenInvest extends StatefulWidget {
  const LoginScreenInvest({super.key});

  @override
  State<LoginScreenInvest> createState() => _LoginScreenInvestState();
}

class _LoginScreenInvestState extends State<LoginScreenInvest> {

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.imagesLoginScreenBg,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: AppConstants.screenPadding,
          child:
              GetBuilder<AuthControllerInvest>(builder: (authControllerInvest) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  "Welcome Back",
                  style: Helper(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 32.sp, color: white),
                ),
                sizedBoxHeight(height: 8.h),
                CustomText(
                  "Login to your account",
                  style: Helper(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 16.sp, color: textGray),
                ),
                sizedBoxHeight(height: 36.h),
                AppTextFieldWithHeading(
                  controller: authControllerInvest.userIdController,
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
                sizedBoxHeight(height: 16.h),
                AppTextFieldWithHeading(
                  controller: authControllerInvest.passwordController,
                  preFixWidget: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                    ),
                    child: Icon(
                      Icons.lock_outline,
                      color: textGray,
                      size: 20.sp,
                    ),
                  ),
                  hintStyle: Helper(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 14.sp, color: textSecondary),
                  hindText: "Enter Password",
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                ),
                sizedBoxHeight(height: 16.h),
                CustomButton(
                  onTap: () {
                    authControllerInvest.loginInvest().then((value) {
                      if (value.isSuccess) {
                        Navigator.of(context).pushReplacementNamed(
                          InvestmentApp.dashboard,
                        );
                        showToast(
                            message: value.message, typeCheck: value.isSuccess);
                      } else {
                        showToast(
                            message: value.message, typeCheck: value.isSuccess);
                      }
                    });
                  },
                  gradient: goldGradient,
                  gradientBegin: Alignment.topCenter,
                  gradientEnd: Alignment.bottomCenter,
                  borderColor: null,
                  height: 60.h,
                  radius: 12.r,
                  child: CustomText(
                    "Login",
                    style: Helper(context).textTheme.titleMedium?.copyWith(
                          fontSize: 16.sp,
                          color: black,
                        ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
