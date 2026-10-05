import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/basic_controller_invest.dart';
import 'package:vlr/data/models/invest_model/home_model_invest.dart';

import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/shimmer.dart';
import 'package:vlr/views/wealth_grow_app/screen/notification_screen_invest/widget/notification_card_invest.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class NotificationScreenInvest extends StatelessWidget {

  const NotificationScreenInvest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      appBar: AppBar(
        backgroundColor: backgroundDark,
        elevation: 0,
       
        title: CustomText(
          'Notifications',
          style: Helper(context).textTheme.titleLarge?.copyWith(
                color: textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
      body: SafeArea(
        child:
            GetBuilder<BasicControllerInvest>(builder: (basicControllerInvest) {
          final notifications =
              basicControllerInvest.homeInvestModel?.notification ?? [];
          if (notifications.isEmpty) {
            return _EmptyNotificationView();
          }
          return ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              16.w,
              10.h,
              16.w,
              24.h,
            ),
            itemCount: basicControllerInvest.isLoading ? 4 :  notifications.length,
            separatorBuilder: (context, index) {
              return sizedBoxHeight(height: 12);
            },
            itemBuilder: (context, index) {
              final Notification notification = basicControllerInvest.isLoading ? Notification()  : notifications[index];

              return CustomShimmer(
                isLoading: basicControllerInvest.isLoading,
                child: NotificationCardInvest(
                  notification: notification,
                ),
              );
            },
          );

// =============================================================
// EMPTY NOTIFICATION VIEW
// =============================================================
        }),
      ),
    );
  }
}

class _EmptyNotificationView extends StatelessWidget {
  const _EmptyNotificationView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: 120.h,
        ),
        Center(
          child: Container(
            width: 90.w,
            height: 90.w,
            decoration: BoxDecoration(
              color: surfaceNavy,
              shape: BoxShape.circle,
              border: Border.all(
                color: borderDark,
                width: 1.w,
              ),
            ),
            child: Icon(
              Icons.notifications_none_rounded,
              color: textMuted,
              size: 42.w,
            ),
          ),
        ),
        sizedBoxHeight(height: 20),
        Center(
          child: CustomText(
            'No Notifications',
            style: Helper(context).textTheme.titleMedium?.copyWith(
                  color: textPrimary,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        sizedBoxHeight(height: 8),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: CustomText(
              'You do not have any notifications yet.',
              textAlign: TextAlign.center,
              style: Helper(context).textTheme.bodyMedium?.copyWith(
                    color: textSecondary,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
