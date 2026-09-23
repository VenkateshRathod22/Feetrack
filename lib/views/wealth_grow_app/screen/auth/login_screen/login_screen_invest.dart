import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/auth_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/dashboard_invest.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';
import 'package:vlr/views/widget/text_box/app_text_box.dart';

class LoginScreenInvest extends StatefulWidget {
  const LoginScreenInvest({super.key});

  @override
  State<LoginScreenInvest> createState() => _LoginScreenInvestState();
}

class _LoginScreenInvestState extends State<LoginScreenInvest> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      final authController = Get.find<AuthController>();
      authController.mobileNoController.clear();
      authController.update();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: InvestmentTheme.dark,
      child: Scaffold(
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
            child: GetBuilder<AuthController>(builder: (authController) {
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
                    controller: authController.mobileNoController,
                    preFixWidget: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomImage(
                            path: Assets.imagesIndiaFlag,
                            width: 28.w,
                            height: 18.h,
                            fit: BoxFit.cover,
                          ),
                          sizedBoxWidth(width: 10.w),
                          CustomText(
                            "+91",
                            style:
                                Helper(context).textTheme.bodyMedium?.copyWith(
                                      fontSize: 14.sp,
                                      color: white,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    hintStyle: Helper(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 14.sp, color: textSecondary),
                    hindText: "Mobile Number",
                  ),
                  sizedBoxHeight(height: 16.h),
                  CustomButton(
                    onTap: () {
                      navigate(context: context, page: DashboardScreenInvert());
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
      ),
    );
  }
}
