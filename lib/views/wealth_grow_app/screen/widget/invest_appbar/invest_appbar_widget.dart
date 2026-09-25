import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class InvestAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  const InvestAppBarWidget({
    super.key,
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: CustomText(
        title,
        style: Helper(context).textTheme.titleSmall?.copyWith(
              fontSize: 18.sp,
              color: white,
            ),
      ),
    );
  }
}
