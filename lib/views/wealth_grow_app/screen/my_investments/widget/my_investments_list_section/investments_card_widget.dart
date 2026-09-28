import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlr/data/models/invest_model/activation_history_model_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/wealth_grow_app/screen/my_investments/widget/my_investments_list_section/investment_card_state_widget.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class InvestmentsCardWidget extends StatelessWidget {
  final ActivationHistoryModelInvest activationHistoryModelInvest;
  const InvestmentsCardWidget(
      {super.key, required this.activationHistoryModelInvest});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          color: cardDartBg,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(width: 1, color: cardDartBorderColor)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImage(
                path: Assets.imagesInvestBg,
                height: 54.h,
                width: 54.w,
              ),
              sizedBoxWidth(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      activationHistoryModelInvest.incomeType ?? "",
                      style: Helper(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 13.5.sp,
                          ),
                    ),
                    sizedBoxHeight(height: 2),
                    CustomText(
                      activationHistoryModelInvest.packageFormat,
                      style: Helper(context).textTheme.titleMedium?.copyWith(
                            fontSize: 22.sp,
                          ),
                    ),
                    sizedBoxHeight(height: 2),
                    CustomText(
                      "ID: ${activationHistoryModelInvest.uniqueId ?? ""}",
                      style: Helper(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 11.sp,
                            color: textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              activationHistoryModelInvest.withdrawStatusFormat
                  ? SizedBox()
                  : InvestmentCardStateWidget(),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 12.h,
              bottom: 10.h,
            ),
            child: Divider(
              color: white.withValues(alpha: 0.10),
            ),
          ),
          Row(
            children: [
              SvgPicture.asset(
                Assets.svgsCalender,
                colorFilter:
                    const ColorFilter.mode(textSecondary, BlendMode.srcIn),
              ),
              sizedBoxWidth(width: 6),
              CustomText(
                activationHistoryModelInvest.packageDateFormat,
                style: Helper(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 12.sp, color: textSecondary),
              ),
              CustomText(
                ", ${activationHistoryModelInvest.packageTimeFormat}",
                style: Helper(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 12.sp, color: textSecondary),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 12.h,
              bottom: 10.h,
            ),
            child: Divider(
              color: white.withValues(alpha: 0.10),
            ),
          ),
          Row(
            children: [
              CustomText(
                activationHistoryModelInvest.perFormat,
                style: Helper(context).textTheme.titleMedium?.copyWith(
                      fontSize: 13.sp,
                    ),
              ),
              sizedBoxWidth(width: 4),
              CustomText(
                activationHistoryModelInvest.incomeType ?? "",
                style: Helper(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 13.sp,
                      color: primaryColor,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
