import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlr/generated/assets.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class InvestButtonWidget extends StatelessWidget {
  final InvestButtonModel investButtonModel;
  const InvestButtonWidget({
    super.key,
    required this.investButtonModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: investButtonModel.onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            height: 66.h,
            width: 66.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withValues(alpha: 0.60),
                    primaryColor.withValues(alpha: 0.80),
                    primaryColor,
                  ],
                  begin: AlignmentGeometry.bottomCenter,
                  end: AlignmentGeometry.topCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                    spreadRadius: -2,
                    color: black.withValues(alpha: 0.10),
                  ),
                  BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 6,
                    spreadRadius: -1,
                    color: black.withValues(alpha: 0.10),
                  ),
                ]),
            child: SvgPicture.asset(
              investButtonModel.icon,
              fit: BoxFit.contain,
            ),
          ),
          sizedBoxHeight(height: 6),
          CustomText(
            investButtonModel.title,
            style:
                Helper(context).textTheme.bodyMedium?.copyWith(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}

class InvestButtonModel {
  final String icon;
  final String title;
  final Function()? onTap;

  InvestButtonModel(
      {required this.icon, required this.title, required this.onTap});
}

List<InvestButtonModel> investButtonModelList = [
  InvestButtonModel(icon: Assets.svgsInvest, title: "Invest", onTap: () {}),
  InvestButtonModel(
      icon: Assets.svgsAddMoney, title: "Add Money", onTap: () {}),
  InvestButtonModel(icon: Assets.svgsWithdraw, title: "Withdraw", onTap: () {}),
  InvestButtonModel(
      icon: Assets.svgsStatement, title: "Statement", onTap: () {}),
];
