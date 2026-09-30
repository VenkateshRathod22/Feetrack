import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/wallet_controller_invest.dart';
import 'package:vlr/data/models/invest_model/fund_history_model_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/shimmer.dart';
import 'package:vlr/views/wealth_grow_app/investment_app.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/wallet/wallet_portfolio_section/recent_transaction_section/fund_transaction_widget.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class FundTransactionListScreen extends StatelessWidget {
  const FundTransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          "Fund Transaction History",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 24.sp,
              ),
        ),
      ),
      body: GetBuilder<WalletControllerInvest>(
        builder: (walletControllerInvest) {
          final List<FundHistoryModelInvest> recentList =
              walletControllerInvest.fundHistoryModelInvestList.toList();

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: AppConstants.screenPadding,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: cardDartBorderColor,
                ),
                borderRadius: BorderRadius.circular(16.r),
                color: cardDartBg,
              ),
              child: ListView.separated(
                padding: EdgeInsets.zero,

                /// ListView itself does NOT scroll
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                itemCount:
                    walletControllerInvest.isLoading ? 4 : recentList.length,

                itemBuilder: (context, index) {
                  final FundHistoryModelInvest item =
                      walletControllerInvest.isLoading
                          ? const FundHistoryModelInvest()
                          : recentList[index];

                  return GestureDetector(
                    onTap: () {
                      if (walletControllerInvest.isLoading) {
                        return;
                      }
                      walletControllerInvest.updateFundHistoryModelInvest(
                        fundHistoryModelInvest: item,
                      );

                      Navigator.of(context).pushNamed(
                        InvestmentApp.fundTransactionDetailScreen,
                      );
                    },
                    child: CustomShimmer(
                      isLoading: walletControllerInvest.isLoading,
                      child: FundingHistoryWidget(
                        fundHistoryModelInvest: item,
                      ),
                    ),
                  );
                },

                separatorBuilder: (_, __) {
                  return sizedBoxHeight(height: 4.h);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
