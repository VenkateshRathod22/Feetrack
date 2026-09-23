import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  State<DashboardScreenInvert> createState() =>
      _DashboardScreenInvertState();
}

class _DashboardScreenInvertState
    extends State<DashboardScreenInvert> {
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = const [
      HomeScreenInvest(),
      InvestmentScreenInvest(),
      WalletInvest(),
      ReferralScreenInvest(),
      ProfileScreenInvest(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,

      body: GetBuilder<DashBoardController>(
        id: 'investment_dashboard',
        builder: (controller) {
          return IndexedStack(
            index: controller.dashPageInvest,
            children: _pages,
          );
        },
      ),

      bottomNavigationBar: GetBuilder<DashBoardController>(
        id: 'investment_dashboard',
        builder: (controller) {
          return SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 6.w,
                vertical: 6.h,
              ),
              decoration: BoxDecoration(
                color: backgroundDark,
                border: Border(
                  top: BorderSide(
                    color: borderDark,
                    width: 1.w,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                children: [
                  BottomNavigationItemWidget(
                    title: 'Home',
                    icon: Assets.svgsHome2,
                    isActive:
                        controller.dashPageInvest == 0,
                    onTap: () {
                      controller.dashPageInvest = 0;
                    },
                  ),

                  BottomNavigationItemWidget(
                    title: 'Invest',
                    icon: Assets.svgsInvestment,
                    isActive:
                        controller.dashPageInvest == 1,
                    onTap: () {
                      controller.dashPageInvest = 1;
                    },
                  ),

                  BottomNavigationItemWidget(
                    title: 'Wallet',
                    icon: Assets.svgsWallet,
                    isActive:
                        controller.dashPageInvest == 2,
                    onTap: () {
                      controller.dashPageInvest = 2;
                    },
                  ),

                  BottomNavigationItemWidget(
                    title: 'Referral',
                    icon: Assets.svgsReferral,
                    isActive:
                        controller.dashPageInvest == 3,
                    onTap: () {
                      controller.dashPageInvest = 3;
                    },
                  ),

                  BottomNavigationItemWidget(
                    title: 'Profile',
                    icon: Assets.svgsProfile,
                    isActive:
                        controller.dashPageInvest == 4,
                    onTap: () {
                      controller.dashPageInvest = 4;
                    },
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


// ============================================================
// BOTTOM NAVIGATION ITEM
// ============================================================

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
    final bool isLogout =
        icon.contains('logout');

    final Color itemColor =
        isActive ? primaryColor : textDarkMuted;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: 4.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(
                  milliseconds: 200,
                ),
                curve: Curves.easeOut,
                padding: EdgeInsets.all(
                  isActive ? 7.r : 5.r,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? primaryColor.withValues(
                          alpha: 0.10,
                        )
                      : Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(12.r),
                ),
                child: SvgPicture.asset(
                  icon,
                  width: isLogout ? 20.r : 23.r,
                  height: isLogout ? 20.r : 23.r,
                  colorFilter: ColorFilter.mode(
                    itemColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),

              SizedBox(height: 3.h),

              AnimatedDefaultTextStyle(
                duration: const Duration(
                  milliseconds: 200,
                ),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(
                      fontSize: 10.sp,
                      fontWeight: isActive
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: itemColor,
                    ),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}