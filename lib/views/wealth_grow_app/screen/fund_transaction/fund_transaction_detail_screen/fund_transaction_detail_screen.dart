import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:vlr/controllers/invest_controller/wallet_controller_invest.dart';
import 'package:vlr/data/models/invest_model/fund_history_model_invest.dart';
import 'package:vlr/generated/assets.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/services/date_formatters_and_converters.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/wallet/wallet_portfolio_section/recent_transaction_section/transaction_status_widget.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class FundTransactionDetailScreen extends StatelessWidget {
  const FundTransactionDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletControllerInvest>(
      builder: (walletControllerInvest) {
        final FundHistoryModelInvest? transaction =
            walletControllerInvest.selectFundHistoryModelInvest;

        if (transaction == null) {
          return Scaffold(
            appBar: AppBar(
              title: CustomText(
                "Transaction Details",
                style: Helper(context).textTheme.titleMedium?.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            body: const Center(
              child: Text(
                "Transaction details not available",
              ),
            ),
          );
        }

        final bool isApproved = transaction.isApproveStatus;

        return Scaffold(
          appBar: AppBar(
            title: CustomText(
              "Transaction Details",
              style: Helper(context).textTheme.titleMedium?.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                AppConstants.horizontalPadding,
                8.h,
                AppConstants.horizontalPadding,
                24.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------------------------------------------------
                  // Transaction Summary
                  // ---------------------------------------------------
                  _buildTransactionSummary(
                    context,
                    transaction,
                    isApproved,
                  ),

                  sizedBoxHeight(height: 20),

                  // ---------------------------------------------------
                  // Transaction Information
                  // ---------------------------------------------------
                  _buildSectionTitle(
                    context,
                    "Transaction Information",
                  ),

                  sizedBoxHeight(height: 10),

                  _buildDetailsCard(
                    context,
                    children: [
                      _buildDetailRow(
                        context,
                        title: "Transaction ID",
                        value: transaction.transactionId.isEmpty
                            ? "--"
                            : transaction.transactionId,
                        showCopy: transaction.transactionId.isNotEmpty,
                        onCopy: () {
                          _copyToClipboard(
                            context,
                            transaction.transactionId,
                            "Transaction ID copied",
                          );
                        },
                      ),
                      _buildDivider(),
                      _buildDetailRow(
                        context,
                        title: "Reference ID",
                        value: transaction.id.isEmpty
                            ? "--"
                            : "#${transaction.id}",
                      ),
                      _buildDivider(),
                      _buildDetailRow(
                        context,
                        title: "Payment ID",
                        value: _displayValue(
                          transaction.paymentId,
                        ),
                      ),
                      _buildDivider(),
                      _buildDetailRow(
                        context,
                        title: "Payment Mode",
                        value: _formatMode(
                          transaction.mode,
                        ),
                      ),
                      _buildDivider(),
                      _buildDetailRow(
                        context,
                        title: "Transaction Type",
                        value: _formatValue(
                          transaction.type,
                        ),
                      ),
                    ],
                  ),

                  sizedBoxHeight(height: 20),

                  // ---------------------------------------------------
                  // Date & Time
                  // ---------------------------------------------------
                  _buildSectionTitle(
                    context,
                    "Date & Time",
                  ),

                  sizedBoxHeight(height: 10),

                  _buildDetailsCard(
                    context,
                    children: [
                      _buildDetailRow(
                        context,
                        title: "Created",
                        value: _formatDateTimeSafe(
                          transaction.createdAt,
                        ),
                      ),
                      _buildDivider(),
                      _buildDetailRow(
                        context,
                        title: isApproved ? "Approved" : "Last Updated",
                        value: isApproved
                            ? transaction.formattedApproveDate
                            : transaction.formattedUpdatedAt,
                      ),
                    ],
                  ),

                  sizedBoxHeight(height: 20),

                  // ---------------------------------------------------
                  // Additional Information
                  // ---------------------------------------------------
                  _buildSectionTitle(
                    context,
                    "Additional Information",
                  ),

                  sizedBoxHeight(height: 10),

                  _buildDetailsCard(
                    context,
                    children: [
                      _buildDetailRow(
                        context,
                        title: "Platform",
                        value: _displayValue(
                          transaction.platform,
                        ),
                      ),
                      _buildDivider(),
                      _buildDetailRow(
                        context,
                        title: "Remark",
                        value: _displayValue(
                          transaction.remark,
                        ),
                      ),
                      _buildDivider(),
                      _buildDetailRow(
                        context,
                        title: "Admin Remark",
                        value: _displayValue(
                          transaction.adminRemark,
                        ),
                      ),
                    ],
                  ),

                  sizedBoxHeight(height: 24),

                  // ---------------------------------------------------
                  // Transaction Reference
                  // ---------------------------------------------------
                  _buildTransactionIdCard(
                    context,
                    transaction,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ================================================================
  // Transaction Summary
  // ================================================================

  Widget _buildTransactionSummary(
    BuildContext context,
    FundHistoryModelInvest transaction,
    bool isApproved,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 24.h,
      ),
      decoration: BoxDecoration(
        color: cardDartBg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: cardDartBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 58.w,
            width: 58.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isApproved
                  ? green.withValues(alpha: 0.10)
                  : primaryColorLight.withValues(alpha: 0.10),
            ),
            child: Center(
              child: SvgPicture.asset(
                isApproved ? Assets.svgsUpperArrowBg : Assets.svgsPendingBg,
                height: 32.w,
                width: 32.w,
              ),
            ),
          ),
          sizedBoxHeight(height: 12),
          CustomText(
            "Fund Added",
            style: Helper(context).textTheme.titleMedium?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
          ),
          sizedBoxHeight(height: 8),
          CustomText(
            transaction.amountFormat,
            style: Helper(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: isApproved ? green : primaryColorLight,
                ),
          ),
          sizedBoxHeight(height: 10),
          TransactionStatusWidget(
            isApproved: isApproved,
          ),
          sizedBoxHeight(height: 10),
          CustomText(
            transaction.formattedCreatedAt,
            textAlign: TextAlign.center,
            style: Helper(context).textTheme.bodySmall?.copyWith(
                  fontSize: 11.sp,
                  color: textGray,
                ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // Section Title
  // ================================================================

  Widget _buildSectionTitle(
    BuildContext context,
    String title,
  ) {
    return CustomText(
      title,
      style: Helper(context).textTheme.titleMedium?.copyWith(
            fontSize: 14.sp,
            color: textGray,
          ),
    );
  }

  // ================================================================
  // Details Card
  // ================================================================

  Widget _buildDetailsCard(
    BuildContext context, {
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: cardDartBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: cardDartBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  // ================================================================
  // Detail Row
  // ================================================================

  Widget _buildDetailRow(
    BuildContext context, {
    required String title,
    required String value,
    bool showCopy = false,
    VoidCallback? onCopy,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 13.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: CustomText(
              title,
              style: Helper(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12.sp,
                    color: textSecondary,
                  ),
            ),
          ),
          sizedBoxWidth(width: 12.w),
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: CustomText(
                    value,
                    textAlign: TextAlign.end,
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                if (showCopy && onCopy != null) ...[
                  sizedBoxWidth(width: 6.w),
                  GestureDetector(
                    onTap: onCopy,
                    child: Icon(
                      Icons.copy_rounded,
                      size: 15.sp,
                      color: blue,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // Divider
  // ================================================================

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      color: whiteDivider,
    );
  }

  // ================================================================
  // Transaction Reference Card
  // ================================================================

  Widget _buildTransactionIdCard(
    BuildContext context,
    FundHistoryModelInvest transaction,
  ) {
    if (transaction.transactionId.isEmpty) {
      return const SizedBox();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: blue.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: blue.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.receipt_long_rounded,
            size: 20.sp,
            color: blue,
          ),
          sizedBoxWidth(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  "Transaction Reference",
                  style: Helper(context).textTheme.bodySmall?.copyWith(
                        fontSize: 10.sp,
                        color: textGray,
                      ),
                ),
                sizedBoxHeight(height: 3.h),
                CustomText(
                  transaction.transactionId,
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              _copyToClipboard(
                context,
                transaction.transactionId,
                "Transaction ID copied",
              );
            },
            child: Icon(
              Icons.copy_rounded,
              size: 18.sp,
              color: blue,
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // Display Helpers
  // ================================================================

  String _displayValue(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "--";
    }

    return value;
  }

  String _formatMode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Online";
    }

    return _formatValue(value);
  }

  String _formatValue(String value) {
    if (value.trim().isEmpty) {
      return "--";
    }

    return value.replaceAll("_", " ").split(" ").map(
      (word) {
        if (word.isEmpty) {
          return "";
        }

        return "${word[0].toUpperCase()}"
            "${word.substring(1).toLowerCase()}";
      },
    ).join(" ");
  }

  String _formatDateTimeSafe(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "--";
    }

    final DateTime? dateTime = DateTime.tryParse(value);

    if (dateTime == null) {
      return value;
    }

    return DateFormatters().dateTime.format(dateTime);
  }

  // ================================================================
  // Copy
  // ================================================================

  void _copyToClipboard(
    BuildContext context,
    String value,
    String message,
  ) {
    Clipboard.setData(
      ClipboardData(text: value),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
