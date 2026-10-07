import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:vlr/data/models/invest_model/ticket_model_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class TicketCardInvest extends StatelessWidget {
  final TicketModelInvest ticket;

  const TicketCardInvest({
    super.key,
    required this.ticket,
  });

  // =========================================================
  // STATUS COLOR
  // =========================================================

  Color _getStatusColor() {
    final String status =
        ticket.status?.toLowerCase().trim() ?? '';

    if (status.contains('open')) {
      return green;
    }

    if (status.contains('pending')) {
      return yellow;
    }

    if (status.contains('closed') ||
        status.contains('resolved')) {
      return red;
    }

    return textSecondary;
  }

  // =========================================================
  // STATUS LABEL
  // =========================================================

  String _getStatusLabel() {
    final String status =
        ticket.status?.trim() ?? '';

    if (status.isEmpty) {
      return 'Unknown';
    }

    return _capitalize(status);
  }

  // =========================================================
  // CAPITALIZE
  // =========================================================

  String _capitalize(String value) {
    if (value.isEmpty) {
      return value;
    }

    return value[0].toUpperCase() +
        value.substring(1).toLowerCase();
  }

  // =========================================================
  // DATE
  // =========================================================

  String _getCreatedDate() {
    final DateTime? date = ticket.createdAt;

    if (date == null) {
      return '--';
    }

    return DateFormat(
      'dd MMM yyyy, hh:mm a',
    ).format(date);
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final Color statusColor = _getStatusColor();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: borderDark,
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================================================
          // HEADER
          // =====================================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomText(
                  ticket.subject?.isNotEmpty == true
                      ? ticket.subject!
                      : 'No Subject',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Helper(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        color: textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),

              sizedBoxWidth(width: 10),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: statusColor.withOpacity(0.25),
                    width: 1.w,
                  ),
                ),
                child: CustomText(
                  _getStatusLabel(),
                  style: Helper(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),

          sizedBoxHeight(height: 14),

          // =====================================================
          // USER MESSAGE
          // =====================================================

          CustomText(
            ticket.userMsg?.isNotEmpty == true
                ? ticket.userMsg!
                : 'No message available',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Helper(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                  color: textSecondary,
                  height: 1.5,
                ),
          ),

          sizedBoxHeight(height: 16),

          // =====================================================
          // COMPANY REPLY
          // =====================================================

          if (ticket.adminMsg?.isNotEmpty == true) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.06),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: primaryColor.withOpacity(0.20),
                  width: 1.w,
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.support_agent_rounded,
                          color: primaryColor,
                          size: 18.sp,
                        ),
                      ),

                      sizedBoxWidth(width: 10),

                      Expanded(
                        child: CustomText(
                          'Company Support',
                          style: Helper(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                color: primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),

                      Icon(
                        Icons.verified_rounded,
                        color: primaryColor,
                        size: 17.sp,
                      ),
                    ],
                  ),

                  sizedBoxHeight(height: 10),

                  CustomText(
                    ticket.adminMsg!,
                    style: Helper(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                          color: textPrimary,
                          height: 1.5,
                        ),
                  ),
                ],
              ),
            ),

            sizedBoxHeight(height: 14),
          ],

          // =====================================================
          // WAITING FOR COMPANY REPLY
          // =====================================================

          if (ticket.adminMsg?.isEmpty ?? true) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color: surfaceNavy,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: borderDark,
                  width: 1.w,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.hourglass_empty_rounded,
                    color: textMuted,
                    size: 18.sp,
                  ),

                  sizedBoxWidth(width: 8),

                  Expanded(
                    child: CustomText(
                      'Waiting for company response',
                      style: Helper(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                            color: textMuted,
                          ),
                    ),
                  ),
                ],
              ),
            ),

            sizedBoxHeight(height: 14),
          ],

          // =====================================================
          // FOOTER
          // =====================================================

          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 16.sp,
                color: textMuted,
              ),

              sizedBoxWidth(width: 6),

              Expanded(
                child: CustomText(
                  _getCreatedDate(),
                  style: Helper(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                        color: textMuted,
                      ),
                ),
              ),

              if (ticket.id != null &&
                  ticket.id!.isNotEmpty)
                CustomText(
                  '#${ticket.id}',
                  style: Helper(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(
                        color: textMuted,
                        fontWeight: FontWeight.w600,
                      ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}