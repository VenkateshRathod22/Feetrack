import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vlr/data/models/invest_model/fund_history_model_invest.dart';
import 'package:vlr/generated/assets.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/wallet/wallet_portfolio_section/recent_transaction_section/transaction_status_widget.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class FundingHistoryWidget extends StatelessWidget {
  final FundHistoryModelInvest fundHistoryModelInvest;
  const FundingHistoryWidget({
    super.key,
    required this.fundHistoryModelInvest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 13.h),
      child: Row(
        children: [
          SvgPicture.asset(
            fundHistoryModelInvest.isApproveStatus
                ? Assets.svgsUpperArrowBg
                : Assets.svgsPendingBg,
            height: 44.h,
            width: 44.w,
          ),
          sizedBoxWidth(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      "# ${fundHistoryModelInvest.id}",
                      style: Helper(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 13.sp),
                    ),
                    sizedBoxWidth(width: 6.w),
                    TransactionStatusWidget(
                        isApproved: fundHistoryModelInvest.isApproveStatus),
                  ],
                ),
                sizedBoxHeight(height: 4.h),
                CustomText(
                  fundHistoryModelInvest.formattedCreatedAt,
                  style: Helper(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 13.sp),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(
                fundHistoryModelInvest.amountFormat,
                style: Helper(context).textTheme.titleLarge?.copyWith(
                    fontSize: 14.sp,
                    color: fundHistoryModelInvest.isApproveStatus
                        ? green
                        : primaryColorLight),
              ),
            ],
          )
        ],
      ),
    );
  }
}
