import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/investment_app.dart';

class ProfileOptionWidgetInvest extends StatelessWidget {
  final ProfileOptionModel profileOptionModel;
  const ProfileOptionWidgetInvest(
      {super.key, required this.profileOptionModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: profileOptionModel.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Row(
          children: [
            Icon(
              profileOptionModel.icon,
              size: 20,
            ),
            sizedBoxWidth(width: 14.w),
            Expanded(
              child: CustomText(
                profileOptionModel.title,
                style: Helper(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 14.sp),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.sp,
            )
          ],
        ),
      ),
    );
  }
}

class ProfileOptionModel {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  ProfileOptionModel(
      {required this.title, required this.icon, required this.onTap});
}

List<ProfileOptionModel> profileOptionModelList(
        {required BuildContext context}) =>
    [
      ProfileOptionModel(
          title: "Bank Accounts",
          icon: Icons.account_balance_outlined,
          onTap: () {
            Navigator.of(context).pushNamed(
              InvestmentApp.bankListScreenInvest,
            );
          }),
      ProfileOptionModel(
          title: "Help & Support",
          icon: Icons.help_outline_rounded,
          onTap: () {}),
      ProfileOptionModel(
          title: "Privacy Policy",
          icon: Icons.privacy_tip_outlined,
          onTap: () {}),
      ProfileOptionModel(
          title: "Terms & Conditions",
          icon: Icons.policy_outlined,
          onTap: () {}),
    ];
