import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/wallet/wallet_portfolio_section/recent_transaction_section/recent_transaction_section.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/wallet/wallet_portfolio_section/wallet_portfolio_section.dart';

class WalletInvest extends StatelessWidget {
  const WalletInvest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomText(
          "Wallet",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 24.sp,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            WalletPortfolioSection(),
            sizedBoxHeight(height: 12),
            CustomImage(
              path: Assets.imagesBanner1,
              height: 100.h,
              width: double.infinity,
              radius: 16.r,
              fit: BoxFit.cover,
            ),
            sizedBoxHeight(height: 14),
            RecentTransactionsSection()
          ],
        ),
      ),
    );
  }
}
