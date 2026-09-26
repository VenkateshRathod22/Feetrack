import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/controllers/invest_controller/investment_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class PackageInfoRow extends StatelessWidget {
  final PackageInfoRowModel packageInfoRowModel;

  const PackageInfoRow({
    super.key,
    required this.packageInfoRowModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomText(
              packageInfoRowModel.title,
              style: Helper(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 13.sp, color: textDarkSecondary),
            ),
          ),
          CustomText(
            packageInfoRowModel.subTitle,
            style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 14.sp, color: packageInfoRowModel.subTitleColor),
          ),
        ],
      ),
    );
  }
}

class PackageInfoRowModel {
  final String title;
  final String subTitle;
  final Color subTitleColor;

  PackageInfoRowModel({
    required this.title,
    required this.subTitle,
    required this.subTitleColor,
  });
}

List<PackageInfoRowModel> packageInfoRowModelList({
  required InvestmentControllerInvest investmentControllerInvest,
}) {
  final package = investmentControllerInvest.selectInvestmentPackageModel;

  return [
    PackageInfoRowModel(
      title: "Minimum Investment",
      subTitle: package?.minFormat ?? "",
      subTitleColor: textDarkPrimary,
    ),
    PackageInfoRowModel(
      title: "Maximum Investment",
      subTitle: package?.maxFormat ?? "",
      subTitleColor: textDarkPrimary,
    ),
    PackageInfoRowModel(
      title: "Daily Return",
      subTitle: "${package?.dailyPercent ?? ""}%",
      subTitleColor: primaryColor,
    ),
    PackageInfoRowModel(
      title: "Monthly Return",
      subTitle: "${package?.monthlyPercent ?? ""}%",
      subTitleColor: primaryColor,
    ),
    PackageInfoRowModel(
      title: "Yearly Return",
      subTitle: "${package?.yearlyPercent ?? ""}%",
      subTitleColor: primaryColor,
    ),
  ];
}
