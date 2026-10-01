import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/auth_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';
import 'package:vlr/views/widget/text_box/app_text_box.dart';

class ResetPasswordScreenInvest extends StatefulWidget {
  const ResetPasswordScreenInvest({
    super.key,
  });

  @override
  State<ResetPasswordScreenInvest> createState() =>
      _ResetPasswordScreenInvestState();
}

class _ResetPasswordScreenInvestState extends State<ResetPasswordScreenInvest> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthControllerInvest get authController => Get.find<AuthControllerInvest>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          "Reset Password",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 24.sp,
              ),
        ),
      ),
      body: GetBuilder<AuthControllerInvest>(
        builder: (authControllerInvest) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: AppConstants.screenPadding,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBoxHeight(height: 30.h),

                    // ------------------------------------------------
                    // Header Icon
                    // ------------------------------------------------
                    Center(
                      child: Container(
                        height: 64.w,
                        width: 64.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: blue.withValues(
                            alpha: 0.10,
                          ),
                        ),
                        child: Icon(
                          Icons.lock_reset_rounded,
                          size: 32.sp,
                          color: blue,
                        ),
                      ),
                    ),

                    sizedBoxHeight(height: 20.h),

                    Center(
                      child: CustomText(
                        "Reset your password",
                        style: Helper(context).textTheme.titleLarge?.copyWith(
                              fontSize: 21.sp,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),

                    sizedBoxHeight(height: 8.h),

                    Center(
                      child: CustomText(
                        "Enter the OTP sent to your account "
                        "and create a new password.",
                        textAlign: TextAlign.center,
                        style: Helper(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 12.sp,
                              color: textGray,
                            ),
                      ),
                    ),

                    sizedBoxHeight(height: 32.h),

                    // ------------------------------------------------
                    // OTP
                    // ------------------------------------------------
                    AppTextFieldWithHeading(
                      controller: authControllerInvest.otpController,
                      heading: "OTP",
                      hindText: "Enter OTP",
                      headingWidget: CustomText(
                        "OTP",
                        style: Helper(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 13.sp, color: textPrimary1),
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      inputFormatters: const [],
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter OTP";
                        }

                        if (value.trim().length < 4) {
                          return "Please enter a valid OTP";
                        }

                        return null;
                      },
                      preFixWidget: Icon(
                        Icons.password_rounded,
                        size: 20.sp,
                      ),
                    ),

                    sizedBoxHeight(height: 18.h),

                    // ------------------------------------------------
                    // New Password
                    // ------------------------------------------------
                    AppTextFieldWithHeading(
                      controller: authControllerInvest.passwordController,
                      headingWidget: CustomText(
                        "New Password",
                        style: Helper(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 13.sp, color: textPrimary1),
                      ),
                      hindText: "Enter new password",
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter password";
                        }

                        if (value.trim().length < 6) {
                          return "Password must be at least 6 characters";
                        }

                        return null;
                      },
                      preFixWidget: Icon(
                        Icons.lock_outline_rounded,
                        size: 20.sp,
                      ),
                    ),

                    sizedBoxHeight(height: 28.h),

                    // ------------------------------------------------
                    // Change Password
                    // ------------------------------------------------
                    CustomButton(
                      onTap: authControllerInvest.isLoading
                          ? null
                          : () {
                              if (formKey.currentState?.validate() ?? false) {
                                authControllerInvest
                                    .resetPasswordInvest()
                                    .then((value) {
                                  if (value.isSuccess) {
                                    Navigator.pop(context);
                                    showToast(
                                        message: value.message,
                                        typeCheck: value.isSuccess);
                                  } else {
                                    showToast(
                                        message: value.message,
                                        typeCheck: value.isSuccess);
                                  }
                                });
                              }
                            },
                      isLoading: authControllerInvest.isLoading,
                      radius: 16.r,
                      height: 60.h,
                      borderColor: primaryColor,
                      child: CustomText(
                        "Change Password",
                        style: Helper(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: black,
                            ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
