import 'package:flutter/material.dart';
import 'package:vlr/views/wealth_grow_app/screen/auth/forget_password/forget_password_screen.dart';

import 'package:vlr/views/wealth_grow_app/screen/auth/login_screen/login_screen_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/dashboard_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/investment_plan_detail_screen_invest/investment_plan_detail_screen_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/splach_screen/splach_screen_invert.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';
class InvestmentApp extends StatefulWidget {
  const InvestmentApp({super.key});

  static const String splash = '/splash_invest';
  static const String login = '/login_invest';
  static const String dashboard = '/dashboard_invest';
  static const String forgetPassword = '/forget_password';

  static const String investmentPlanDetailScreenInvest =
      '/investment_plan_detail_screen_invest';

  @override
  State<InvestmentApp> createState() => _InvestmentAppState();
}

class _InvestmentAppState extends State<InvestmentApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: InvestmentTheme.dark,
      child: NavigatorPopHandler(
        onPopWithResult: (result) {
          navigatorKey.currentState?.pop(result);
        },
        child: Navigator(
          key: navigatorKey,
          initialRoute: InvestmentApp.splash,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case InvestmentApp.splash:
                return MaterialPageRoute(
                  builder: (_) => const SplashScreenInvert(),
                  settings: settings,
                );

              case InvestmentApp.login:
                return MaterialPageRoute(
                  builder: (_) => const LoginScreenInvest(),
                  settings: settings,
                );

              case InvestmentApp.forgetPassword:
                return MaterialPageRoute(
                  builder: (_) => const ForgetPasswordScreen(),
                  settings: settings,
                );

              case InvestmentApp.investmentPlanDetailScreenInvest:
                return MaterialPageRoute(
                  builder: (_) =>
                      const InvestmentPlanDetailScreenInvest(),
                  settings: settings,
                );

              case InvestmentApp.dashboard:
                return MaterialPageRoute(
                  builder: (_) => const DashboardScreenInvert(),
                  settings: settings,
                );

              default:
                return MaterialPageRoute(
                  builder: (_) => const SplashScreenInvert(),
                  settings: settings,
                );
            }
          },
        ),
      ),
    );
  }
}