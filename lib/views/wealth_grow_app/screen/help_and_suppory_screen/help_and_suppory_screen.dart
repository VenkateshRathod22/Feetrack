import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:vlr/controllers/invest_controller/basic_controller_invest.dart';

import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/services/lanch_helper.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class HelpSupportScreenInvest extends StatelessWidget {
  const HelpSupportScreenInvest({super.key});

 

  Widget _buildContactCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: surfaceNavy,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: borderDark,
            width: 1.w,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52.w,
              height: 52.h,
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Icon(
                icon,
                color: primaryColor,
                size: 25.w,
              ),
            ),

            sizedBoxWidth(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title,
                    style: Helper(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: textPrimary,
                        ),
                  ),

                  sizedBoxHeight(height: 5),

                  CustomText(
                    value,
                    style: Helper(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                  ),

                  sizedBoxHeight(height: 3),

                  CustomText(
                    subtitle,
                    style: Helper(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                          fontSize: 12.sp,
                          color: textSecondary,
                        ),
                  ),
                ],
              ),
            ),

            sizedBoxWidth(width: 8),

            Container(
              width: 38.w,
              height: 38.h,
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: primaryColor,
                size: 16.w,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
       
        title: CustomText(
          'Help & Support',
          style: Helper(context)
              .textTheme
              .titleLarge
              ?.copyWith(
                fontSize: 19.sp,
                fontWeight: FontWeight.w700,
                color: textPrimary,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: GetBuilder<BasicControllerInvest>(
          builder: (basicControllerInvest) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBoxHeight(height: 8),
            
                CustomText(
                  'How can we help you?',
                  style: Helper(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                        color: textPrimary,
                      ),
                ),
            
                sizedBoxHeight(height: 8),
            
                CustomText(
                  'Contact our support team for any help regarding your account, payments or investments.',
                  style: Helper(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                        fontSize: 13.sp,
                        color: textSecondary,
                        height: 1.5,
                      ),
                ),
            
                sizedBoxHeight(height: 28),
            
                CustomText(
                  'Contact Support',
                  style: Helper(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                      ),
                ),
            
                sizedBoxHeight(height: 14),
            
                // -------------------------------------------------
                // CALL SUPPORT
                // -------------------------------------------------
            
                _buildContactCard(
                  context: context,
                  icon: Icons.phone_outlined,
                  title: 'Call Us',
                  subtitle: 'Tap to call our support team',
                  value: basicControllerInvest.appSettingInvestModel?.setting?.mobile ?? "",
                  onTap: () {
                    LaunchHelper.callUs(
                      number: basicControllerInvest.appSettingInvestModel?.setting?.mobile ?? "",
                    );
                  },
                ),
            
                sizedBoxHeight(height: 14),
            
                // -------------------------------------------------
                // EMAIL SUPPORT
                // -------------------------------------------------
            
                _buildContactCard(
                  context: context,
                  icon: Icons.email_outlined,
                  title: 'Email Us',
                  value: basicControllerInvest.appSettingInvestModel?.setting?.email ?? "",
                  subtitle: 'Tap to send us an email',
                  onTap: () {
                    LaunchHelper.emailUs(
                      email: basicControllerInvest.appSettingInvestModel?.setting?.email ?? "",
                    );
                  },
                ),
            
                sizedBoxHeight(height: 24),
            
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: primaryColor.withValues(alpha: 0.20),
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.support_agent_rounded,
                        color: primaryColor,
                        size: 24.w,
                      ),
                      sizedBoxWidth(width: 12),
                      Expanded(
                        child: CustomText(
                          'Our support team is here to assist you with your queries.',
                          style: Helper(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                fontSize: 13.sp,
                                color: textSecondary,
                                height: 1.5,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}