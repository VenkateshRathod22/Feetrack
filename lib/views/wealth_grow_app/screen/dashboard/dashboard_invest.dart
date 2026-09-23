import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:vlr/controllers/dashboard_controller.dart';
import 'package:vlr/generated/assets.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/home/home_screen_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/investment/investment_screen_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/profile/profile_screen_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/referral/referral_screen_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/wallet/wallet_invest.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class DashboardScreenInvert extends StatefulWidget {
  const DashboardScreenInvert({super.key});

  @override
  State<DashboardScreenInvert> createState() => _DashboardScreenInvertState();
}

class _DashboardScreenInvertState extends State<DashboardScreenInvert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DashBoardController>(
        builder: (DashBoardController controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: [
              HomeScreenInvest(),
              InvestmentScreenInvest(),
              WalletInvest(),
              ReferralScreenInvest(),
              ProfileScreenInvest()
            ][controller.dashPageInvest],
          );
        },
      ),
      bottomNavigationBar: GetBuilder<DashBoardController>(
        builder: (DashBoardController controller) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: backgroundDark,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BottomNavigationItemWidget(
                    onTap: () {
                      controller.dashPageInvest = 0;
                    },
                    title: 'Home',
                    icon: Assets.svgsHome2,
                    isActive: controller.dashPageInvest == 0,
                  ),
                  BottomNavigationItemWidget(
                    onTap: () {
                      controller.dashPageInvest = 1;
                    },
                    title: 'Invest',
                    icon: Assets.svgsInvestment,
                    isActive: controller.dashPageInvest == 1,
                  ),
                  BottomNavigationItemWidget(
                    onTap: () {
                      controller.dashPageInvest = 2;
                    },
                    title: 'Wallet',
                    icon: Assets.svgsWallet,
                    isActive: controller.dashPageInvest == 2,
                  ),
                  BottomNavigationItemWidget(
                    onTap: () {
                      controller.dashPageInvest = 3;
                    },
                    title: 'Referral',
                    icon: Assets.svgsReferral,
                    isActive: controller.dashPageInvest == 3,
                  ),
                  BottomNavigationItemWidget(
                    onTap: () {
                      controller.dashPageInvest = 4;
                    },
                    title: 'Profile',
                    icon: Assets.svgsProfile,
                    isActive: controller.dashPageInvest == 4,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

///
class BottomNavigationItemWidget extends StatelessWidget {
  const BottomNavigationItemWidget({
    super.key,
    required this.title,
    required this.icon,
    this.isActive = false,
    this.onTap,
  });

  final String title;
  final String icon;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              icon,
              width: icon.contains('logout') ? 20 : 24,
              height: icon.contains('logout') ? 20 : 24,
              colorFilter: ColorFilter.mode(
                  isActive ? primaryColor : textDarkMuted, BlendMode.srcIn),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: isActive ? primaryColor : textDarkMuted,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
