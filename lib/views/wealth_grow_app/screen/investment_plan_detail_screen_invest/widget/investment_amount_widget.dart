import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/investment_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';
import 'package:vlr/views/widget/text_box/app_text_box.dart';

class InvestmentAmountWidget extends StatefulWidget {
  const InvestmentAmountWidget({
    super.key,
  });

  @override
  State<InvestmentAmountWidget> createState() => _InvestmentAmountWidgetState();
}

class _InvestmentAmountWidgetState extends State<InvestmentAmountWidget> {
  @override
  void initState() {
    super.initState();

    final investmentControllerInvest = Get.find<InvestmentControllerInvest>();

    final package = investmentControllerInvest.selectInvestmentPackageModel;

    // Set minimum amount as default value
    // only when the field is empty.
    if (investmentControllerInvest.amountController.text.trim().isEmpty) {
      investmentControllerInvest.amountController.text = package?.min ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvestmentControllerInvest>(
      builder: (investmentControllerInvest) {
        final package = investmentControllerInvest.selectInvestmentPackageModel;

        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomText(
                    "Investment Amount",
                    style: Helper(context).textTheme.titleMedium?.copyWith(
                          fontSize: 13.sp,
                          color: borderDark,
                        ),
                  ),
                ),
                CustomText(
                  "${package?.minFormat ?? ""} - ${package?.maxFormat ?? ""}",
                  style: Helper(context).textTheme.titleMedium?.copyWith(
                        fontSize: 13.sp,
                        color: borderDark,
                      ),
                ),
              ],
            ),
            sizedBoxHeight(height: 4.h),
            AppTextFieldWithHeading(
              controller: investmentControllerInvest.amountController,
              hindText: "Enter amount",
              preFixWidget: const Icon(
                Icons.currency_rupee,
                color: black,
              ),
              textStyle: const TextStyle(
                color: Colors.black,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter amount";
                }

                final enteredAmount = double.tryParse(value.trim());

                if (enteredAmount == null) {
                  return "Please enter a valid amount";
                }

                final minimumAmount = double.tryParse(package?.min ?? '');

                final maximumAmount = double.tryParse(package?.max ?? '');

                if (minimumAmount == null || maximumAmount == null) {
                  return "Investment range is unavailable";
                }

                if (enteredAmount < minimumAmount) {
                  return "Minimum investment is "
                      "${package?.minFormat ?? package?.min}";
                }

                if (enteredAmount > maximumAmount) {
                  return "Maximum investment is "
                      "${package?.maxFormat ?? package?.max}";
                }

                return null;
              },
            ),
          ],
        );
      },
    );
  }
}
