import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/referral/widget/referral_code_section.dart';

class ReferralScreenInvest extends StatelessWidget {
  const ReferralScreenInvest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          "Refer & Earn",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 24.sp,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              "Invite friends and earn rewards together",
              style: Helper(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                  ),
            ),
            sizedBoxHeight(height: 16),
            ReferralCodeSection()
          ],
        ),
      ),
    );
  }
}
