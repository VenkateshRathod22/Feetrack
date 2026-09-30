import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/profile/widget/profile_option_widget_invest.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class ProfileOptionSectionInvest extends StatelessWidget {
  const ProfileOptionSectionInvest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final list = profileOptionModelList(
      context: context,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: cardDartBg,
        ),
        color: cardBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.r),
          topRight: Radius.circular(28.r),
        ),
      ),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(),

        // +1 for Logout
        itemCount: list.length + 1,

        itemBuilder: (context, index) {
          // Normal profile options
          if (index < list.length) {
            final profileOptionModel = list[index];

            return ProfileOptionWidgetInvest(
              profileOptionModel: profileOptionModel,
            );
          }

          // Last row = Logout
          return InkWell(
            onTap: () {
              // TODO: Logout logic
            },
            borderRadius: BorderRadius.circular(12.r),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16.h,
              ),
              child: Row(
                children: [
                  Container(
                    height: 42.w,
                    width: 42.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: red.withValues(
                        alpha: 0.10,
                      ),
                    ),
                    child: Icon(
                      Icons.logout_rounded,
                      size: 21.sp,
                      color: red,
                    ),
                  ),
                  sizedBoxWidth(width: 12.w),
                  Expanded(
                    child: CustomText(
                      "Logout",
                      style: Helper(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 14.sp,
                            color: red,
                          ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14.sp,
                    color: red,
                  ),
                ],
              ),
            ),
          );
        },

        separatorBuilder: (context, index) {
          return Divider(
            color: white.withValues(alpha: 0.4),
          );
        },
      ),
    );
  }
}
