import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:vlr/controllers/invest_controller/auth_controller_invest.dart';
import 'package:vlr/controllers/invest_controller/basic_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/copy_text.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/referral/widget/column_refer_widget.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class ReferralCodeSection extends StatelessWidget {
  const ReferralCodeSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthControllerInvest>(builder: (authControllerInvest) {
      return Container(
        padding: EdgeInsets.fromLTRB(16.w, 28.h, 16.w, 16.h),
        decoration: BoxDecoration(
            color: cardDartBg,
            border: Border.all(color: cardDartBg, width: 1),
            borderRadius: BorderRadius.circular(16.r)),
        child:
            GetBuilder<BasicControllerInvest>(builder: (basicControllerInvest) {
          double totalReferral = (double.tryParse(
                      basicControllerInvest.homeInvestModel?.directActive ??
                          "0.0") ??
                  0.0) +
              (double.tryParse(
                      basicControllerInvest.homeInvestModel?.directInactive ??
                          "0.0") ??
                  0.0);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                "Your Referral Code",
                style: Helper(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 12.sp, color: textSecondary),
              ),
              sizedBoxHeight(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    authControllerInvest.userIdFormat ?? "",
                    style: Helper(context).textTheme.titleLarge?.copyWith(
                          fontSize: 24.sp,
                        ),
                  ),
                  GestureDetector(
                    onTap: () {
                      copyText(
                        text: authControllerInvest.userIdFormat ?? "",
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: primaryColorLight2),
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Icon(
                        Icons.copy,
                        size: 15.sp,
                        color: primaryColor,
                      ),
                    ),
                  )
                ],
              ),
              sizedBoxHeight(height: 24),
              CustomButton(
                  onTap: () {},
                  radius: 16.r,
                  height: 56.h,
                  borderColor: primaryColor,
                  gradient: goldGradient,
                  child: CustomText(
                    "Share Now",
                    style: Helper(context).textTheme.titleMedium?.copyWith(
                          fontSize: 14.sp,
                          color: black,
                        ),
                  )),
              sizedBoxHeight(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ColumReferWidget(
                        title: totalReferral.toString(),
                        subTitle: "Total Referral"),
                  ),
                  Container(
                    width: 1,
                    height: 32.h,
                    decoration: const BoxDecoration(color: white),
                  ),
                  Expanded(
                    child: ColumReferWidget(
                        title: basicControllerInvest
                                .homeInvestModel?.directActive ??
                            "",
                        subTitle: "Active Referral"),
                  ),
                  Container(
                    width: 1,
                    height: 32.h,
                    decoration: const BoxDecoration(color: white),
                  ),
                  Expanded(
                    child: ColumReferWidget(
                        title: basicControllerInvest
                                .homeInvestModel?.directInactive ??
                            "",
                        subTitle: "Inactive Referral"),
                  ),
                ],
              )
            ],
          );
        }),
      );
    });
  }
}
