import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/home/widget/invest_button_section/invest_button_widget.dart';

class InvestButtonSection extends StatelessWidget {
  const InvestButtonSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // This handles the dynamic spacing
        crossAxisAlignment: CrossAxisAlignment.start,
        children: investButtonModelList.map((investButtonModel) {
          return InvestButtonWidget(investButtonModel: investButtonModel);
        }).toList(),
      ),
    );
  }
}