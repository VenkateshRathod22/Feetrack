import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/auth_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/screens/auth_screens/login/login_screen.dart';
import 'package:vlr/views/screens/dashboard/dashboard_screen.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class SplashScreenInvert extends StatefulWidget {
  const SplashScreenInvert({super.key});

  @override
  State<SplashScreenInvert> createState() => _SplashScreenInvertState();
}

class _SplashScreenInvertState extends State<SplashScreenInvert>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // Timer(const Duration(seconds: 3), () {
    //   checkAuth();
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> checkAuth() async {
    final authController = Get.find<AuthController>();

    String token = authController.getUserToken();

    if (token.isNotEmpty) {
      final response = await authController.fetchProfile();

      if (response.isSuccess) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const DashboardScreen()),
          );
        }
      } else {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }
      }
    } else {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: InvestmentTheme.dark,
      child: Scaffold(
        backgroundColor: white,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  Assets.imagesSplachScreenBg,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                sizedBoxHeight(height: MediaQuery.of(context).size.height / 4),
                CustomImage(
                  path: Assets.imagesInvestmentLogo,
                  height: 112.h,
                  width: 112.w,
                  fit: BoxFit.contain,
                ),
                sizedBoxHeight(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomImage(
                      path: Assets.imagesWeathText,
                      height: MediaQuery.of(context).size.width / 7,
                      fit: BoxFit.cover,
                    ),
                    sizedBoxWidth(width: 6),
                    CustomImage(
                      path: Assets.imagesGrowText,
                      height: MediaQuery.of(context).size.width / 7,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                CustomText(
                  "Invest Today",
                  style: Helper(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 15.sp, color: borderLight),
                ),
                CustomText(
                  "For A Brighter Tomorrow",
                  style: Helper(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 14.sp, color: borderLight),
                ),
                const CustomImage(
                  path: Assets.imagesBlueWave,
                  fit: BoxFit.cover,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      "Secure",
                      style: Helper(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 16.sp, color: borderLight),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 2.h),
                      child: CircleAvatar(
                        radius: 3.r,
                        backgroundColor: primaryColor.withValues(alpha: 0.80),
                      ),
                    ),
                    CustomText(
                      "Simple",
                      style: Helper(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 16.sp, color: borderLight),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 2.h),
                      child: CircleAvatar(
                        radius: 3.r,
                        backgroundColor: primaryColor.withValues(alpha: 0.80),
                      ),
                    ),
                    CustomText(
                      "Smarter",
                      style: Helper(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 16.sp, color: borderLight),
                    ),
                  ],
                ),
                sizedBoxHeight(height: 8),
                const CircularProgressIndicator()
              ],
            )),
      ),
    );
  }
}
