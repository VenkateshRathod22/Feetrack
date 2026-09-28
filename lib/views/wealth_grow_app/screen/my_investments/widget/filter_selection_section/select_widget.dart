import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class SelectWidget extends StatelessWidget {
  final SelectWidgetModel selectWidgetModel;

  const SelectWidget({
    super.key,
    required this.selectWidgetModel,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Wrap with GestureDetector to handle the tap
    return GestureDetector(
      onTap: selectWidgetModel.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.h),
        margin: EdgeInsets.only(left: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999.r),
          border: selectWidgetModel.isSelect
              ? null
              : Border.all(
                  width: 1,
                  color: white.withValues(
                    alpha: 0.5,
                  ),
                ),
          color: selectWidgetModel.isSelect
              ? primaryColor
              : neutralColor.withValues(
                  alpha: 0.70,
                ),
        ),
        child: Center(
          child: CustomText(
            selectWidgetModel.title,
            style: Helper(context).textTheme.titleMedium?.copyWith(
                  fontSize: 13.sp,
                  color:
                      selectWidgetModel.isSelect ? black : textSecondaryLight,
                ),
          ),
        ),
      ),
    );
  }
}

class SelectWidgetModel {
  final String title;
  final bool isSelect;
  final VoidCallback onTap;

  SelectWidgetModel({
    required this.title,
    required this.isSelect,
    required this.onTap,
  });
}
