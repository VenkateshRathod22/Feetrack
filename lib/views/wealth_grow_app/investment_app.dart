import 'package:flutter/material.dart';
import 'package:vlr/views/wealth_grow_app/screen/add_money_wallet/add_funds_screen_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/auth/forget_password/forget_password_screen.dart';

import 'package:vlr/views/wealth_grow_app/screen/auth/login_screen/login_screen_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/auth/reset_password/reset_password_screen_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/auth/user_profile_invest/user_profile_edit/user_profile_edit_screen_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/auth/user_profile_invest/user_profile_screen_invest/user_profile_screen_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/bank_screen_invest/add_bank_account/add_bank_account_screen_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/bank_screen_invest/bank_list_screen_invest/bank_list_screen_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/dashboard_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/fund_transaction/fund_transaction_detail_screen/fund_transaction_detail_screen.dart';
import 'package:vlr/views/wealth_grow_app/screen/fund_transaction/fund_transaction_screen/fund_transaction_list_screen.dart';
import 'package:vlr/views/wealth_grow_app/screen/investment_plan_detail_screen_invest/investment_plan_detail_screen_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/investment_successful_screen_invest/investment_successful_screen_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/my_investments/my_investments_screen_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/select_payment_method_screen_invest/select_payment_method_screen_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/splach_screen/splach_screen_invert.dart';
import 'package:vlr/views/wealth_grow_app/screen/withdraw_funds_screen_invest/withdraw_funds_screen_invest.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class InvestmentApp extends StatefulWidget {
  const InvestmentApp({super.key});

  static const String splash = '/splash_invest';
  static const String login = '/login_invest';
  static const String dashboard = '/dashboard_invest';
  static const String forgetPassword = '/forget_password';

  static const String investmentPlanDetailScreenInvest =
      '/investment_plan_detail_screen_invest';
  static const String myInvestmentsScreenInvest =
      '/my_investments_screen_invest';
  static const String bankListScreenInvest = '/bank_list_screen_invest';
  static const String addBankAccountScreenInvest =
      '/add_bank_account_screen_invest';
  static const String withdrawFundsScreenInvest =
      '/withdraw_funds_screen_invest';

  static const String addFundsScreenInvest = '/add_funds_screen_invest';

  static const String selectPaymentMethodScreenInvest =
      '/select_payment_method_screen_invest';

  static const String investmentSuccessfulScreenInvest =
      '/investment_successful_screen_invest';

  static const String fundTransactionListScreen =
      '/fund_transaction_list_screen';

  static const String fundTransactionDetailScreen =
      '/fund_transaction_detail_screen';

//* profile
  static const String userProfileScreenInvest = '/user_profile_screen_invest';
  static const String userProfileEditScreenInvest =
      '/user_profile_edit_screen_invest';

  static const String resetPasswordScreenInvest =
      '/reset_password_screen_invest';

  @override
  State<InvestmentApp> createState() => _InvestmentAppState();
}

class _InvestmentAppState extends State<InvestmentApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
                  builder: (_) => const InvestmentPlanDetailScreenInvest(),
                  settings: settings,
                );

              case InvestmentApp.dashboard:
                return MaterialPageRoute(
                  builder: (_) => const DashboardScreenInvert(),
                  settings: settings,
                );

              case InvestmentApp.myInvestmentsScreenInvest:
                return MaterialPageRoute(
                  builder: (_) => const MyInvestmentsScreenInvest(),
                  settings: settings,
                );

              case InvestmentApp.bankListScreenInvest:
                return MaterialPageRoute(
                  builder: (_) => const BankListScreenInvest(),
                  settings: settings,
                );

              case InvestmentApp.addBankAccountScreenInvest:
                return MaterialPageRoute(
                  builder: (_) => const AddBankAccountScreenInvest(),
                  settings: settings,
                );
              case InvestmentApp.withdrawFundsScreenInvest:
                return MaterialPageRoute(
                  builder: (_) => const WithdrawFundsScreenInvest(),
                  settings: settings,
                );
              case InvestmentApp.addFundsScreenInvest:
                return MaterialPageRoute(
                  builder: (_) => AddFundsScreenInvest(),
                  settings: settings,
                );
              case InvestmentApp.selectPaymentMethodScreenInvest:
                return MaterialPageRoute(
                  builder: (_) => const SelectPaymentMethodScreenInvest(),
                  settings: settings,
                );

              case InvestmentApp.investmentSuccessfulScreenInvest:
                return MaterialPageRoute(
                  builder: (_) => const InvestmentSuccessfulScreenInvest(),
                  settings: settings,
                );
              case InvestmentApp.fundTransactionListScreen:
                return MaterialPageRoute(
                  builder: (_) => const FundTransactionListScreen(),
                  settings: settings,
                );
              case InvestmentApp.fundTransactionDetailScreen:
                return MaterialPageRoute(
                  builder: (_) => const FundTransactionDetailScreen(),
                  settings: settings,
                );
              case InvestmentApp.userProfileScreenInvest:
                return MaterialPageRoute(
                  builder: (_) => const UserProfileScreenInvest(),
                  settings: settings,
                );
              case InvestmentApp.userProfileEditScreenInvest:
                return MaterialPageRoute(
                  builder: (_) => const UserProfileEditScreenInvest(),
                  settings: settings,
                );
              case InvestmentApp.resetPasswordScreenInvest:
                return MaterialPageRoute(
                  builder: (_) => const ResetPasswordScreenInvest(),
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




                  // Navigator.of(context).pushNamed(
                  //   InvestmentApp.investmentPlanDetailScreenInvest,
                  // );