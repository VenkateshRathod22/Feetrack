import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlr/data/models/invest_model/investment_package_model.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/investment/widget/all_daily_monthly_select_row/investment_return_plan_section/return_widget.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class InvestmentReturnPlanWidget extends StatelessWidget {
  final InvestmentPackageModel investmentPackageModel;
  const InvestmentReturnPlanWidget({
    super.key,
    required this.investmentPackageModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: cardWhite,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  gradient: goldGradient,
                ),
                child: SvgPicture.asset(
                  Assets.svgsRupess,
                  height: 30.h,
                  width: 30.w,
                ),
              ),
              sizedBoxWidth(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      investmentPackageModel.title ?? "",
                      style: Helper(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 15.sp, color: black),
                    ),
                    sizedBoxHeight(height: 2),
                    CustomText(
                      "${investmentPackageModel.minFormat} - ${investmentPackageModel.manFormat} ",
                      style: Helper(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 12.sp, color: textSecondary),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  size: 18.sp,
                  Icons.arrow_forward_ios_rounded,
                  color: textDarkSecondary,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: const Divider(
              color: whiteDivider,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReturnWidget(
                title: "DAILY",
                subTitle: "${investmentPackageModel.dailyPercent ?? ""}%",
                subTitleColor: black,
              ),
              ReturnWidget(
                title: "MONTHLY",
                subTitle: "${investmentPackageModel.monthlyPercent ?? ""}%",
                subTitleColor: primaryColorLight2,
              ),
              ReturnWidget(
                title: "YEARLY",
                subTitle: "${investmentPackageModel.yearlyPercent ?? ""}%",
                subTitleColor: black,
              ),
            ],
          )
        ],
      ),
    );
  }
}
