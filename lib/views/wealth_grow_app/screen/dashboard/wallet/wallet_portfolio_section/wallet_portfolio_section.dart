import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/auth_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/base/shimmer.dart';
import 'package:vlr/views/wealth_grow_app/investment_app.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/wallet/wallet_portfolio_section/wallet_portfolio_widget.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class WalletPortfolioSection extends StatelessWidget {
  const WalletPortfolioSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(width: 1, color: neutralBorder),
        color: neutralColor.withValues(alpha: 0.90),
      ),
      child: Column(
        children: [
          GetBuilder<AuthControllerInvest>(builder: (authControllerInvest) {
            return Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        "Available Balance",
                        style: Helper(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 13.sp,
                              color: textSecondary,
                            ),
                      ),
                      sizedBoxHeight(height: 2),
                      CustomShimmer(
                        isLoading: authControllerInvest.isLoading,
                        child: CustomText(
                          authControllerInvest
                                  .userModelInvest?.walletBalanceFormat ??
                              "0.0",
                          style: Helper(context).textTheme.titleLarge?.copyWith(
                                fontSize: 30.sp,
                                color: white,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  onTap: () {},
                  gradient: goldGradient,
                  radius: 12.r,
                  borderColor: primaryColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: CustomText(
                      "Add Money",
                      style: Helper(context).textTheme.titleMedium?.copyWith(
                            fontSize: 14.sp,
                            color: textDarkPrimary,
                          ),
                    ),
                  ),
                ),
              ],
            );
          }),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Divider(
              color: whiteDivider.withValues(alpha: 0.2),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WalletPortfolioWidget(
                  icon: Icons.trending_up,
                  title: "Invest",
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      InvestmentApp.myInvestmentsScreenInvest,
                    );
                  }),
              WalletPortfolioWidget(
                  icon: Icons.file_upload_outlined,
                  title: "Withdraw",
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      InvestmentApp.withdrawFundsScreenInvest,
                    );
                  }),
              WalletPortfolioWidget(
                  icon: Icons.description, title: "Transaction", onTap: () {}),
              WalletPortfolioWidget(
                  icon: Icons.account_balance,
                  title: "Bank",
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      InvestmentApp.bankListScreenInvest,
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
