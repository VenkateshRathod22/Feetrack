import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:vlr/controllers/invest_controller/bank_controller_invest.dart';
import 'package:vlr/data/models/invest_model/bank_model_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/base/shimmer.dart';
import 'package:vlr/views/wealth_grow_app/investment_app.dart';
import 'package:vlr/views/wealth_grow_app/screen/bank_screen_invest/bank_list_screen_invest/widget/bank_account_card_invest.dart';
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
        controller.fetchGetAllBankInvest().then((value) {
          if (!value.isSuccess) {
            showToast(message: value.message, typeCheck: value.isSuccess);
          }
        });
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
              onTap: () {
                Navigator.of(context).pushNamed(
                  InvestmentApp.addBankAccountScreenInvest,
                );
              },
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
                    child: bankControllerInvest.isLoading
                        ? ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: 2,
                            separatorBuilder: (_, __) =>
                                sizedBoxHeight(height: 16),
                            itemBuilder: (context, index) {
                              return CustomShimmer(
                                isLoading: true,
                                isDarkMode: true,
                                child: BankAccountCardInvest(
                                  bank: BankModelInvest(),
                                ),
                              );
                            },
                          )
                        : bankControllerInvest.bankModelInvestList.isEmpty
                            ? ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                children: [
                                  SizedBox(
                                    height: 180.h,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.account_balance_outlined,
                                            size: 42.r,
                                            color: textMuted,
                                          ),
                                          sizedBoxHeight(height: 12),
                                          CustomText(
                                            'No bank accounts found',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: textPrimary,
                                                ),
                                          ),
                                          sizedBoxHeight(height: 6),
                                          CustomText(
                                            'Add a bank account to withdraw funds',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: textSecondary,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: bankControllerInvest
                                    .bankModelInvestList.length,
                                separatorBuilder: (_, __) =>
                                    sizedBoxHeight(height: 16),
                                itemBuilder: (context, index) {
                                  final bank = bankControllerInvest
                                      .bankModelInvestList[index];

                                  return BankAccountCardInvest(
                                    bank: bank,
                                  );
                                },
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
