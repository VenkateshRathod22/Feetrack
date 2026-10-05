import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:vlr/data/models/invest_model/home_model_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class NotificationCardInvest extends StatelessWidget {
  final Notification notification;

  const NotificationCardInvest({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(14.w),

      decoration: BoxDecoration(
        gradient: cardDarkGradient,

        borderRadius: BorderRadius.circular(18.r),

        border: Border.all(
          color: borderDark,
          width: 1.w,
        ),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===================================================
          // IMAGE
          // ===================================================

          NotificationImage(
            image: notification.imageFormat,
          ),

          sizedBoxWidth(width: 12),

          // ===================================================
          // CONTENT
          // ===================================================

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ------------------------------------------------
                // TITLE
                // ------------------------------------------------

                CustomText(
                  notification.title?.trim().isNotEmpty == true
                      ? notification.title!.trim()
                      : 'Notification',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Helper(context).textTheme.titleMedium?.copyWith(
                        color: textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                ),

                sizedBoxHeight(height: 6),

                // ------------------------------------------------
                // MESSAGE
                // ------------------------------------------------

                CustomText(
                  notification.message?.trim().isNotEmpty == true
                      ? notification.message!.trim()
                      : '--',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                        color: textSecondary,
                        height: 1.45,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// NOTIFICATION IMAGE
// =============================================================

class NotificationImage extends StatelessWidget {
  final String? image;

  const NotificationImage({
    super.key,
    required this.image,
  });

  String? get imageUrl {
    final String value = image?.trim() ?? '';

    if (value.isEmpty) {
      return null;
    }

    // Full URL
    if (value.startsWith('http://') ||
        value.startsWith('https://')) {
      return value;
    }

    // API gives something like:
    // ../userimages/example.jpg
    //
    // Your base URL:
    // https://investor.feetrack.in/api
    //
    // So this becomes:
    // https://investor.feetrack.in/userimages/example.jpg

    String path = value;

    if (path.startsWith('../')) {
      path = path.substring(3);
    }

    if (path.startsWith('/')) {
      path = path.substring(1);
    }

    return 'https://investor.feetrack.in/$path';
  }

  @override
  Widget build(BuildContext context) {
    final String? url = imageUrl;

    // =========================================================
    // NO IMAGE
    // =========================================================

    if (url == null) {
      return Container(
        width: 64.w,
        height: 64.w,

        decoration: BoxDecoration(
          color: surfaceNavy,
          borderRadius: BorderRadius.circular(14.r),

          border: Border.all(
            color: borderDark,
          ),
        ),

        child: Icon(
          Icons.notifications_none_rounded,
          color: primaryColor,
          size: 28.w,
        ),
      );
    }

    // =========================================================
    // NETWORK IMAGE
    // =========================================================

    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        width: 64.w,
        height: 64.w,
        color: surfaceNavy,

        child: Image.network(
          url,

          fit: BoxFit.cover,

          errorBuilder: (
            context,
            error,
            stackTrace,
          ) {
            return Container(
              color: surfaceNavy,
              child: Icon(
                Icons.image_not_supported_outlined,
                color: textMuted,
                size: 26.w,
              ),
            );
          },

          loadingBuilder: (
            context,
            child,
            loadingProgress,
          ) {
            if (loadingProgress == null) {
              return child;
            }

            return Center(
              child: SizedBox(
                width: 20.w,
                height: 20.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: primaryColor,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}