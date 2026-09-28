import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:vlr/controllers/invest_controller/bank_controller_invest.dart';
import 'package:vlr/data/models/invest_model/bank_model_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/base/shimmer.dart';
import 'package:vlr/views/wealth_grow_app/screen/bank_screen_invest/widget/bank_account_card_invest.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class BankListScreenInvest extends StatefulWidget {
  const BankListScreenInvest({super.key});

  @override
  State<BankListScreenInvest> createState() => _BankListScreenInvestState();
}

class _BankListScreenInvestState extends State<BankListScreenInvest> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.find<BankControllerInvest>();

      if (controller.bankModelInvestList.isEmpty && !controller.isLoading) {
        controller.fetchGetAllBankInvest();
      }
    });
  }

  Future<void> _refreshData() async {
    await Get.find<BankControllerInvest>().fetchGetAllBankInvest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        titleSpacing: 20.w,
        title: CustomText(
          'Bank Accounts',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: AppConstants.screenPadding,
            child: CustomButton(
              onTap: () {},
              color: primaryColor,
              borderColor: primaryColor,
              height: 56.h,
              radius: 18.r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add,
                    color: black,
                  ),
                  sizedBoxWidth(width: 8.w),
                  CustomText(
                    "Add New Bank Account",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 14.sp, color: black),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: GetBuilder<BankControllerInvest>(
        builder: (bankControllerInvest) {
          return RefreshIndicator(
            color: primaryColor,
            backgroundColor: surfaceNavy,
            onRefresh: _refreshData,
            child: Padding(
              padding: AppConstants.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    'LINKED ACCOUNTS',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.6,
                          color: textSecondary,
                        ),
                  ),
                  sizedBoxHeight(height: 16.h),
                  Expanded(
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final bank = bankControllerInvest.isLoading
                            ? BankModelInvest()
                            : bankControllerInvest.bankModelInvestList[index];
                        return CustomShimmer(
                            isLoading: bankControllerInvest.isLoading,
                            child: BankAccountCardInvest(bank: bank));
                      },
                      separatorBuilder: (_, __) => sizedBoxHeight(height: 16.h),
                      itemCount: bankControllerInvest.isLoading
                          ? 2
                          : bankControllerInvest.bankModelInvestList.length,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
