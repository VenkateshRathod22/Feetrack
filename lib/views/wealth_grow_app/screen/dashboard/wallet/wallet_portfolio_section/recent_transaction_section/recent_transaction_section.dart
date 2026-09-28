import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class RecentTransactionsSection extends StatelessWidget {
  const RecentTransactionsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              "Recent Transactions",
              style: Helper(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 15.sp, color: textGray),
            ),
            CustomText(
              "View All",
              style: Helper(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 12.sp, color: blue),
            ),
          ],
        )
      ],
    );
  }
}
