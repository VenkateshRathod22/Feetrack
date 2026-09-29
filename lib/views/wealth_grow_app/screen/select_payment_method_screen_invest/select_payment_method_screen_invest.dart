import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vlr/controllers/invest_controller/auth_controller_invest.dart';
import 'package:vlr/controllers/invest_controller/basic_controller_invest.dart';
import 'package:vlr/controllers/invest_controller/investment_controller_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/wealth_grow_app/investment_app.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class SelectPaymentMethodScreenInvest extends StatefulWidget {
  const SelectPaymentMethodScreenInvest({
    super.key,
  });

  @override
  State<SelectPaymentMethodScreenInvest> createState() =>
      _SelectPaymentMethodScreenInvestState();
}

class _SelectPaymentMethodScreenInvestState
    extends State<SelectPaymentMethodScreenInvest> {
  String selectedPaymentMethod = 'wallet';

  final AppLinks _appLinks = AppLinks();

  StreamSubscription<Uri>? _paymentLinkSubscription;

  bool _paymentHandled = false;

  @override
  void initState() {
    super.initState();

    _listenForPaymentCallback();
  }

  @override
  void dispose() {
    _paymentLinkSubscription?.cancel();
    super.dispose();
  }

  // =========================================================
  // PAYMENT CALLBACK LISTENER
  // =========================================================

  Future<void> _listenForPaymentCallback() async {
    _paymentLinkSubscription = _appLinks.uriLinkStream.listen(
      (Uri uri) {
        _handlePaymentCallback(uri);
      },
      onError: (Object error) {
        debugPrint(
          'Payment callback error: $error',
        );
      },
    );
  }

  // =========================================================
  // HANDLE PAYMENT SUCCESS CALLBACK
  // =========================================================

 void _handlePaymentCallback(Uri uri) {
  if (_paymentHandled) {
    return;
  }

  debugPrint('==========================================');
  debugPrint('PAYMENT CALLBACK RECEIVED');
  debugPrint('Callback URL: $uri');
  debugPrint('Scheme: ${uri.scheme}');
  debugPrint('Host: ${uri.host}');
  debugPrint('Path: ${uri.path}');
  debugPrint('Query Params: ${uri.queryParameters}');
  debugPrint('==========================================');

  final String paymentStatus =
      uri.queryParameters['payment_status']?.trim().toLowerCase() ?? '';

  final String status =
      uri.queryParameters['status']?.trim().toLowerCase() ?? '';

  final String transactionId =
      uri.queryParameters['transaction_id']?.trim() ?? '';

  debugPrint('Payment Status: $paymentStatus');
  debugPrint('Status: $status');
  debugPrint('Transaction ID: $transactionId');

  // =========================================================
  // PAYMENT SUCCESS
  // =========================================================

  if (paymentStatus == 'success' &&
      transactionId.isNotEmpty) {
    _paymentHandled = true;

    if (!mounted) {
      return;
    }

    Navigator.of(context).pushNamed(
      InvestmentApp.investmentSuccessfulScreenInvest,
    );

    showToast(
      message: 'Payment completed successfully',
      typeCheck: true,
    );

    return;
  }

  // =========================================================
  // PAYMENT FAILED
  // =========================================================

  if (paymentStatus == 'failed' ||
      paymentStatus == 'failure' ||
      status == 'false') {
    if (!mounted) {
      return;
    }

    showToast(
      message: 'Payment failed',
      typeCheck: false,
    );

    return;
  }

  // =========================================================
  // PAYMENT CANCELLED
  // =========================================================

  if (paymentStatus == 'cancelled' ||
      paymentStatus == 'canceled') {
    if (!mounted) {
      return;
    }

    showToast(
      message: 'Payment cancelled',
      typeCheck: false,
    );
    

    return;
  }
}
  // =========================================================
  // SELECT PAYMENT METHOD
  // =========================================================

  void _selectPaymentMethod(String method) {
    setState(() {
      selectedPaymentMethod = method;
    });
  }

  // =========================================================
  // OPEN ONLINE PAYMENT
  // =========================================================

  Future<void> _openOnlinePayment(
    BuildContext context,
    InvestmentControllerInvest controller,
  ) async {
    final String paymentUrl = controller.onlinePaymentUrl ?? '';

    if (paymentUrl.trim().isEmpty) {
      showToast(
        message: 'Payment URL not received',
        typeCheck: false,
      );
      return;
    }

    final Uri? uri = Uri.tryParse(paymentUrl);

    if (uri == null) {
      showToast(
        message: 'Invalid payment URL',
        typeCheck: false,
      );
      return;
    }

    try {
      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.inAppBrowserView,
        browserConfiguration: const BrowserConfiguration(
          showTitle: true,
        ),
      );

      if (!launched) {
        showToast(
          message: 'Unable to open payment page',
          typeCheck: false,
        );
      }
    } catch (e, stackTrace) {
      debugPrint(
        'ERROR AT _openOnlinePayment(): $e',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );

      showToast(
        message: 'Unable to open payment page',
        typeCheck: false,
      );
    }
  }

  // =========================================================
  // PAYMENT OPTION UI
  // =========================================================

  Widget _buildPaymentOption({
    required String value,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final bool isSelected = selectedPaymentMethod == value;

    return GestureDetector(
      onTap: () => _selectPaymentMethod(value),
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 180,
        ),
        width: double.infinity,
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withValues(alpha: 0.08)
              : surfaceNavy,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? primaryColor
                : borderDark,
            width: isSelected ? 1.4.w : 1.w,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? primaryColor.withValues(alpha: 0.15)
                    : surfaceLow,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? primaryColor
                    : textSecondary,
                size: 24.w,
              ),
            ),

            sizedBoxWidth(
              width: 14,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title,
                    style: Helper(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: textPrimary,
                        ),
                  ),

                  sizedBoxHeight(
                    height: 4,
                  ),

                  CustomText(
                    subtitle,
                    style: Helper(context)
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

            sizedBoxWidth(
              width: 10,
            ),

            Container(
              width: 22.w,
              height: 22.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? primaryColor
                      : textMuted,
                  width: 1.5.w,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10.w,
                        height: 10.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,

      appBar: AppBar(
        backgroundColor: backgroundDark,
        elevation: 0,
        centerTitle: false,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: textPrimary,
            size: 20.w,
          ),
        ),

        title: CustomText(
          'Select Payment Method',
          style: Helper(context)
              .textTheme
              .titleLarge
              ?.copyWith(
                fontSize: 19.sp,
                fontWeight: FontWeight.w700,
                color: textPrimary,
              ),
        ),
      ),

      body: Padding(
        padding: AppConstants.screenPadding,
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            sizedBoxHeight(
              height: 10,
            ),

            CustomText(
              'Choose how you want to pay',
              style: Helper(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    color: textPrimary,
                  ),
            ),

            sizedBoxHeight(
              height: 6,
            ),

            CustomText(
              'Select one payment method to continue with your investment.',
              style: Helper(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                    fontSize: 13.sp,
                    color: textSecondary,
                    height: 1.5,
                  ),
            ),

            sizedBoxHeight(
              height: 28,
            ),

            // =================================================
            // WALLET
            // =================================================

            _buildPaymentOption(
              value: 'wallet',
              title: 'Wallet',
              subtitle:
                  'Pay using your available wallet balance',
              icon:
                  Icons.account_balance_wallet_outlined,
            ),

            sizedBoxHeight(
              height: 14,
            ),

            // =================================================
            // ONLINE
            // =================================================

            _buildPaymentOption(
              value: 'online',
              title: 'Pay Online',
              subtitle:
                  'Pay securely using UPI, Card or Net Banking',
              icon: Icons.payment_outlined,
            ),

            const Spacer(),

            // =================================================
            // CONTINUE BUTTON
            // =================================================

            GetBuilder<InvestmentControllerInvest>(
              builder: (
                investmentControllerInvest,
              ) {
                return GetBuilder<AuthControllerInvest>(
                  builder: (
                    authControllerInvest,
                  ) {
                    return GetBuilder<BasicControllerInvest>(
                      builder: (
                        basicControllerInvest,
                      ) {
                        return CustomButton(
                          isLoading:
                              investmentControllerInvest
                                  .isLoading,

                          onTap: () async {
                            // =================================================
                            // USER SPONSOR CODE
                            // =================================================

                            final String userSponsorCode =
                                "${basicControllerInvest.appSettingInvestModel?.setting?.pre ?? ""}"
                                "${authControllerInvest.userModelInvest?.sponsorCode ?? ""}";

                            // =================================================
                            // WALLET PAYMENT
                            // =================================================

                            if (selectedPaymentMethod ==
                                'wallet') {
                              final value =
                                  await investmentControllerInvest
                                      .investmentInvest(
                                isActivationRequest:
                                    authControllerInvest
                                            .userModelInvest
                                            ?.isUserActive ??
                                        false,
                                userSponsorCode:
                                    userSponsorCode,
                              );

                              if (!mounted) {
                                return;
                              }

                              if (value.isSuccess) {
                                Navigator.of(context)
                                    .pushNamed(
                                  InvestmentApp
                                      .investmentSuccessfulScreenInvest,
                                );

                                showToast(
                                  message:
                                      value.message,
                                  typeCheck: true,
                                );
                              } else {
                                showToast(
                                  message:
                                      value.message,
                                  typeCheck: false,
                                );
                              }

                              return;
                            }

                            // =================================================
                            // ONLINE PAYMENT
                            // =================================================

                            final value =
                                await investmentControllerInvest
                                    .investOnlineInvest();

                            if (!mounted) {
                              return;
                            }

                            if (value.isSuccess) {
                              // API successfully created
                              // the online payment request.
                              //
                              // payment URL will be opened.
                              //
                              // DO NOT navigate to success
                              // screen here.

                              await _openOnlinePayment(
                                context,
                                investmentControllerInvest,
                              );

                              // =================================================
                              // IMPORTANT
                              // =================================================
                              //
                              // DO NOT DO THIS HERE:
                              //
                              // Navigator.of(context).pushNamed(
                              //   InvestmentApp
                              //       .investmentSuccessfulScreenInvest,
                              // );
                              //
                              // The success navigation happens
                              // inside _handlePaymentCallback()
                              // after:
                              //
                              // payment_status == "success"
                              // =================================================
                            } else {
                              showToast(
                                message:
                                    value.message,
                                typeCheck: false,
                              );
                            }
                          },

                          height: 56.h,
                          radius: 18.r,
                          gradient: goldGradient,
                          borderColor: primaryColor,

                          child: CustomText(
                            'Continue',
                            style: Helper(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  fontSize: 15.sp,
                                  color: neutralColor,
                                ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),

            sizedBoxHeight(
              height: 12,
            ),

            Center(
              child: CustomText(
                selectedPaymentMethod == 'wallet'
                    ? 'Wallet payment selected'
                    : 'Online payment selected',
                style: Helper(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                      fontSize: 12.sp,
                      color: textMuted,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}