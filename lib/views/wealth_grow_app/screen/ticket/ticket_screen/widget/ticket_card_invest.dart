
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:vlr/data/models/invest_model/ticket_model_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/screen/ticket/ticket_screen/widget/ticket_status_badge.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class TicketCardInvest extends StatelessWidget {
  final TicketModelInvest ticket;

  const TicketCardInvest({
    super.key,
    required this.ticket,
  });

  Color get statusColor {
    switch (ticket.status?.toLowerCase()) {
      case 'resolved':
      case 'closed':
        return green;

      case 'rejected':
      case 'cancelled':
        return red;

      case 'in progress':
      case 'processing':
        return blue;

      case 'pending':
        return yellow;

      default:
        return yellow;
    }
  }

  String get formattedDate {
    if (ticket.createdAt == null) {
      return '--';
    }

    return DateFormat(
      'dd MMM yyyy, hh:mm a',
    ).format(ticket.createdAt!);
  }

  bool get hasAdminReply {
    return ticket.adminMsg?.trim().isNotEmpty == true;
  }

  @override
  Widget build(BuildContext context) {
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
          // ==================================================
          // TICKET ID + STATUS
          // ==================================================

          Row(
            children: [
              Expanded(
                child: CustomText(
                  'Ticket #${ticket.id ?? '--'}',
                  style: Helper(context).textTheme.bodySmall?.copyWith(
                    
                        color: textMuted,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),

              TicketStatusBadge(
                status: ticket.status ?? 'Pending',
                color: statusColor,
              ),
            ],
          ),

          sizedBoxHeight(height: 14),

          // ==================================================
          // SUBJECT
          // ==================================================

          CustomText(
            ticket.subject ?? 'No Subject',
            style: Helper(context).textTheme.titleMedium?.copyWith(
                  color: textPrimary,
                  fontWeight: FontWeight.w700,
                ),
          ),

          sizedBoxHeight(height: 10),

          // ==================================================
          // USER MESSAGE TITLE
          // ==================================================

          CustomText(
            'Your Message',
            style: Helper(context).textTheme.bodySmall?.copyWith(
                  color: textSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),

          sizedBoxHeight(height: 5),

          // ==================================================
          // USER MESSAGE
          // ==================================================

          CustomText(
            ticket.userMsg ?? '',
            style: Helper(context).textTheme.bodyMedium?.copyWith(
                  color: textPrimary,
                  height: 1.5,
                ),
          ),

          sizedBoxHeight(height: 14),

          // ==================================================
          // ADMIN REPLY
          // ==================================================

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: surfaceNavy,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: borderDark,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.support_agent_rounded,
                      color: primaryColor,
                      size: 18.w,
                    ),

                    sizedBoxWidth(width: 7),

                    CustomText(
                      'Admin Reply',
                      style: Helper(context).textTheme.bodySmall?.copyWith(
                            color: primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),

                sizedBoxHeight(height: 8),

                CustomText(
                  hasAdminReply
                      ? ticket.adminMsg!
                      : 'Waiting for support team response...',
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                        color: hasAdminReply
                            ? textPrimary
                            : textMuted,
                        height: 1.5,
                      ),
                ),
              ],
            ),
          ),

          sizedBoxHeight(height: 14),

          // ==================================================
          // DIVIDER
          // ==================================================

          Divider(
            color: borderDark,
            height: 1,
          ),

          sizedBoxHeight(height: 12),

          // ==================================================
          // CREATED DATE
          // ==================================================

          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                color: textMuted,
                size: 14.w,
              ),

              sizedBoxWidth(width: 7),

              Expanded(
                child: CustomText(
                  'Created: $formattedDate',
                  style: Helper(context).textTheme.bodySmall?.copyWith(
                        color: textSecondary,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
