import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/investment_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/views/wealth_grow_app/screen/investment_plan_detail_screen_invest/widget/package_section/package_info_row.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class PackageInfoSection extends StatelessWidget {
  const PackageInfoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvestmentControllerInvest>(
      builder: (investmentControllerInvest) {
        final packageInfoList = packageInfoRowModelList(
          investmentControllerInvest: investmentControllerInvest,
        );

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final packageInfoRowModel = packageInfoList[index];

            return PackageInfoRow(
              packageInfoRowModel: packageInfoRowModel,
            );
          },
          separatorBuilder: (_, __) => Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
            ),
            child: Divider(
              color: whiteDivider,
            ),
          ),
          itemCount: packageInfoList.length,
        );
      },
    );
  }
}