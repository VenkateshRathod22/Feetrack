import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/basic_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/copy_text.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class DirectBankWireSection extends StatelessWidget {
  const DirectBankWireSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BasicControllerInvest>(builder: (basicControllerInvest) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: cardDartBg,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: cardDartBorderColor,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              "Bank Account",
              style: Helper(context).textTheme.titleMedium?.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            sizedBoxHeight(height: 16),
            _BankDetailRow(
              label: "Account Name",
              value: basicControllerInvest
                      .appSettingInvestModel?.fundSetting?.accountName ??
                  "",
            ),
            sizedBoxHeight(height: 12),
            _BankDetailRow(
              label: "Account Number",
              value: basicControllerInvest
                      .appSettingInvestModel?.fundSetting?.accountNo ??
                  "",
            ),
            sizedBoxHeight(height: 12),
            _BankDetailRow(
              label: "IFSC Code",
              value: basicControllerInvest
                      .appSettingInvestModel?.fundSetting?.ifsc ??
                  "",
            ),
            sizedBoxHeight(height: 16),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: primaryColorLight2.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 20.sp,
                    color: primaryColorLight2,
                  ),
                  sizedBoxWidth(width: 8.w),
                  Expanded(
                    child: CustomText(
                      "Please verify the bank details before making the transfer.",
                      overflow: TextOverflow.clip,
                      style: Helper(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 12.sp,
                            color: textSecondary,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _BankDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _BankDetailRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: cardDartBg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: cardDartBorderColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  label,
                  style: Helper(context).textTheme.bodySmall?.copyWith(
                        fontSize: 11.sp,
                        color: textSecondary,
                      ),
                ),
                sizedBoxHeight(height: 4),
                CustomText(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Helper(context).textTheme.titleMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          sizedBoxWidth(width: 8.w),
          InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: () {
              copyText(text: value);

              showToast(
                message: "$label copied",
                toastType: ToastType.success,
              );
            },
            child: Padding(
              padding: EdgeInsets.all(6.w),
              child: Icon(
                Icons.copy_rounded,
                size: 18.sp,
                color: primaryColorLight2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
