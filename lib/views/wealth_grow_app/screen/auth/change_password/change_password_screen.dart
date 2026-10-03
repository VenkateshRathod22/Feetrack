import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/auth_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/wealth_grow_app/screen/widget/invest_appbar/invest_appbar_widget.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';
import 'package:vlr/views/widget/text_box/app_text_box.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authController = Get.find<AuthControllerInvest>();
      authController.oldPassword.clear();
      authController.passwordController.clear();
      authController.confirmPassword.clear();
      authController.update();
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: const InvestAppBarWidget(
        title: "Change Password",
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
                        "Change your password",
                        style: Helper(context).textTheme.titleLarge?.copyWith(
                              fontSize: 21.sp,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),

                    sizedBoxHeight(height: 8.h),

                    Center(
                      child: CustomText(
                        "Enter the old password the enter new password",
                        textAlign: TextAlign.center,
                        style: Helper(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 12.sp,
                              color: textGray,
                            ),
                      ),
                    ),

                    sizedBoxHeight(height: 32.h),

                    // ------------------------------------------------
                    // Old password
                    // ------------------------------------------------
                    AppTextFieldWithHeading(
                      controller: authControllerInvest.oldPassword,
                      hindText: "Enter old password",
                      headingWidget: CustomText(
                        "Old Password",
                        style: Helper(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 13.sp, color: textPrimary1),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter old password";
                        }

                        return null;
                      },
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
                    ),

                    sizedBoxHeight(height: 28.h),
                    // ------------------------------------------------
                    // Confirm Password
                    // ------------------------------------------------
                    AppTextFieldWithHeading(
                      controller: authControllerInvest.confirmPassword,
                      headingWidget: CustomText(
                        "Confirm Password",
                        style: Helper(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 13.sp, color: textPrimary1),
                      ),
                      hindText: "Enter confirm password",
                    
                      textInputAction: TextInputAction.done,
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter confirm password";
                        }

                        if (value !=
                            authControllerInvest.passwordController.text) {
                          return "Confirm password is not match with password";
                        }

                        return null;
                      },
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
                                    .changePasswordInvest()
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
