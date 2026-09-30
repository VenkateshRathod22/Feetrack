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
    final bool isApproved = fundHistoryModelInvest.isApproveStatus;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: cardDartBg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          width: 1,
          color: cardDartBorderColor,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Transaction icon
          Container(
            height: 44.w,
            width: 44.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: isApproved
                  ? green.withValues(alpha: 0.10)
                  : primaryColorLight.withValues(alpha: 0.10),
            ),
            child: Center(
              child: SvgPicture.asset(
                isApproved ? Assets.svgsUpperArrowBg : Assets.svgsPendingBg,
                height: 28.w,
                width: 28.w,
              ),
            ),
          ),

          sizedBoxWidth(width: 12.w),

          // Transaction details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  "Fund Added",
                  style: Helper(context).textTheme.titleMedium?.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                sizedBoxHeight(height: 5.h),
                Row(
                  children: [
                    CustomText(
                      "#${fundHistoryModelInvest.id}",
                      style: Helper(context).textTheme.bodySmall?.copyWith(
                            fontSize: 11.sp,
                            color: textGray,
                          ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 6.w,
                      ),
                      height: 3.w,
                      width: 3.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: textGray.withValues(
                          alpha: 0.6,
                        ),
                      ),
                    ),
                    Flexible(
                      child: CustomText(
                        fundHistoryModelInvest.formattedCreatedAt,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Helper(context).textTheme.bodySmall?.copyWith(
                              fontSize: 11.sp,
                              color: textGray,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          sizedBoxWidth(width: 10.w),

          // Amount + status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText(
                fundHistoryModelInvest.amountFormat,
                style: Helper(context).textTheme.titleMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: isApproved ? green : primaryColorLight,
                    ),
              ),
              sizedBoxHeight(height: 5.h),
              TransactionStatusWidget(
                isApproved: isApproved,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
