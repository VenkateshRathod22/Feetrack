import 'package:flutter/material.dart';

import 'package:vlr/views/wealth_grow_app/screen/auth/login_screen/login_screen_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/dashboard_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/splach_screen/splach_screen_invert.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class InvestmentApp extends StatelessWidget {
  const InvestmentApp({super.key});

  static const String splash = '/splash_invest';
  static const String login = '/login_invest';
  static const String dashboard = '/dashboard_invest';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: InvestmentTheme.dark,
      child: Navigator(
        initialRoute: splash,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case splash:
              return MaterialPageRoute(
                builder: (_) => const SplashScreenInvert(),
                settings: settings,
              );

            case login:
              return MaterialPageRoute(
                builder: (_) => const LoginScreenInvest(),
                settings: settings,
              );

            case dashboard:
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
    );
  }
}