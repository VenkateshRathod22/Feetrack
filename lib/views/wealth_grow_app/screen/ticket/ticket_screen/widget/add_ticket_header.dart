
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class AddTicketHeader extends StatelessWidget {
  final VoidCallback onTap;

  const AddTicketHeader({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        gradient: goldGradient,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'Need Help?',
                  style: Helper(context).textTheme.titleMedium?.copyWith(
                        color: neutralColor,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                sizedBoxHeight(height: 5),
                CustomText(
                  'Create a support ticket for your queries.',
                  style: Helper(context).textTheme.bodySmall?.copyWith(
                        color: neutralColor,
                      ),
                ),
              ],
            ),
          ),

          sizedBoxWidth(width: 10),

          SizedBox(
            height: 44.h,
            child: ElevatedButton.icon(
              onPressed: onTap,
              icon: Icon(
                Icons.add_rounded,
                size: 19.w,
                color: neutralColor,
              ),
              label: CustomText(
                'Add Ticket',
                style: Helper(context).textTheme.labelLarge?.copyWith(
                      color: neutralColor,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: neutralColor,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
