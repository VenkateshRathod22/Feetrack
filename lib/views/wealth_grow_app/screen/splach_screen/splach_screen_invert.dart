import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:vlr/controllers/auth_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/wealth_grow_app/investment_app.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class SplashScreenInvert extends StatefulWidget {
  const SplashScreenInvert({super.key});

  @override
  State<SplashScreenInvert> createState() =>
      _SplashScreenInvertState();
}

class _SplashScreenInvertState extends State<SplashScreenInvert> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(
      const Duration(seconds: 3),
      checkAuth,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> checkAuth() async {
  // final authController = Get.find<AuthController>();

  // final String token = authController.getUserToken();

  // if (token.isEmpty) {
  //   if (!mounted) return;

    Navigator.of(context).pushReplacementNamed(
      InvestmentApp.login,
    );

  //   return;
  // }

  // try {
  //   final response = await authController.fetchProfile();

  //   if (!mounted) return;

  //   if (response.isSuccess) {
  //     Navigator.of(context).pushReplacementNamed(
  //       InvestmentApp.dashboard,
  //     );
  //   } else {
  //     Navigator.of(context).pushReplacementNamed(
  //       InvestmentApp.login,
  //     );
  //   }
  // } catch (e) {
  //   if (!mounted) return;

  //   Navigator.of(context).pushReplacementNamed(
  //     InvestmentApp.login,
  //   );
  // }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
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
            sizedBoxHeight(
              height:
                  MediaQuery.of(context).size.height / 4,
            ),

            CustomImage(
              path: Assets.imagesInvestmentLogo,
              height: 112.h,
              width: 112.w,
              fit: BoxFit.contain,
            ),

            sizedBoxHeight(height: 20),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                CustomImage(
                  path: Assets.imagesWeathText,
                  height:
                      MediaQuery.of(context).size.width /
                          7,
                  fit: BoxFit.cover,
                ),

                sizedBoxWidth(width: 6),

                CustomImage(
                  path: Assets.imagesGrowText,
                  height:
                      MediaQuery.of(context).size.width /
                          7,
                  fit: BoxFit.cover,
                ),
              ],
            ),

            CustomText(
              "Invest Today",
              style: Helper(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(
                    fontSize: 15.sp,
                    color: borderLight,
                  ),
            ),

            CustomText(
              "For A Brighter Tomorrow",
              style: Helper(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(
                    fontSize: 14.sp,
                    color: borderLight,
                  ),
            ),

            const CustomImage(
              path: Assets.imagesBlueWave,
              fit: BoxFit.cover,
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                CustomText(
                  "Secure",
                  style: Helper(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                        fontSize: 16.sp,
                        color: borderLight,
                      ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                    left: 8.w,
                    right: 8.w,
                    top: 2.h,
                  ),
                  child: CircleAvatar(
                    radius: 3.r,
                    backgroundColor:
                        primaryColor.withValues(
                      alpha: 0.80,
                    ),
                  ),
                ),

                CustomText(
                  "Simple",
                  style: Helper(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                        fontSize: 16.sp,
                        color: borderLight,
                      ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                    left: 8.w,
                    right: 8.w,
                    top: 2.h,
                  ),
                  child: CircleAvatar(
                    radius: 3.r,
                    backgroundColor:
                        primaryColor.withValues(
                      alpha: 0.80,
                    ),
                  ),
                ),

                CustomText(
                  "Smarter",
                  style: Helper(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                        fontSize: 16.sp,
                        color: borderLight,
                      ),
                ),
              ],
            ),

            sizedBoxHeight(height: 8),

            SizedBox(
              width: 22.w,
              height: 22.w,
              child: CircularProgressIndicator(
                strokeWidth: 2.w,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}