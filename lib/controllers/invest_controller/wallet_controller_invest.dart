import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/data/models/invest_model/bank_model_invest.dart';
import 'package:vlr/data/models/response/response_model.dart';
import 'package:vlr/data/repositories/invest_repo/wallet_repo_invest.dart';
import 'package:vlr/services/constants.dart';

class WalletControllerInvest extends GetxController implements GetxService {
  final WalletRepoInvest walletRepoInvest;

  WalletControllerInvest({required this.walletRepoInvest});

  bool isLoading = false;

  TextEditingController amountController = TextEditingController();

  BankModelInvest? selectBank;

  Future<ResponseModel> withdrawFundsInvest() async {
    log('----------- withdrawFundsInvest Called ----------');

    ResponseModel responseModel;

    isLoading = true;
    update();

    try {
      final Map<String, dynamic> body = {
        'amount': amountController.text.trim(),
        'mode': 'IMPS',
        'bankid': selectBank?.id ?? "",
      };

      log('Withdraw Request Body: $body');

      final Response response = await walletRepoInvest.withdrawFundsInvest(
        body: body,
      );

      log('Withdraw Status Code: ${response.statusCode}');
      log('Withdraw Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        String message = 'Withdrawal request submitted successfully';

        if (response.body is Map && response.body['message'] != null) {
          message = response.body['message'].toString();
        }

        responseModel = ResponseModel(
          true,
          message,
          response.body,
        );
        cleanMethod();
      } else {
        String errorMessage = 'Unable to process withdrawal';

        if (response.body is Map && response.body['message'] != null) {
          errorMessage = response.body['message'].toString();
        } else if (response.statusText != null &&
            response.statusText!.isNotEmpty) {
          errorMessage = response.statusText!;
        }

        responseModel = ResponseModel(
          false,
          errorMessage,
        );
      }
    } catch (e, stackTrace) {
      log(
        'ERROR AT withdrawFundsInvest(): $e',
        stackTrace: stackTrace,
      );

      responseModel = ResponseModel(
        false,
        'Something went wrong while processing withdrawal',
      );
    } finally {
      isLoading = false;
      update();
    }

    return responseModel;
  }

  String? adminFee;
  String? netCreditedAmount;

  void adminFeeCal() {
    final double? amount = double.tryParse(
      amountController.text.trim(),
    );
    double? finalAmount;

    if (amount == null || amount <= 0) {
      adminFee = null;
      return;
    }

    final double fee = amount * 2 / 100;

    adminFee = "-${PriceConverter.convertToNumberFormat(fee)}";
    finalAmount = amount + fee;
    netCreditedAmount = PriceConverter.convertToNumberFormat(finalAmount);
    update();
  }

  Timer? withdrawalAmountTimer;

  void withdrawalAmountDebounce(VoidCallback callback) {
    withdrawalAmountTimer?.cancel();

    withdrawalAmountTimer = Timer(
      const Duration(seconds: 2),
      callback,
    );
  }

  void cleanMethod() {
    withdrawalAmountTimer?.cancel();
    amountController.clear();
    adminFee = "0.0";
    netCreditedAmount = "0.0";
    update();
  }

  final TextEditingController fundAmountController = TextEditingController();

  final TextEditingController transactionIdController = TextEditingController();

  final TextEditingController fundModeController = TextEditingController();

  final TextEditingController fundRemarkController = TextEditingController();

  File? fundScreenshot;

  void setFundScreenshot(File file) {
    fundScreenshot = file;
    update();
  }

  void removeFundScreenshot() {
    fundScreenshot = null;
    update();
  }

  Future<bool> sendRequestForWalletFund() async {
    isLoading = true;
    update();

    try {
      final body = <String, dynamic>{
        'amount': fundAmountController.text.trim(),
        'transaction_id': transactionIdController.text.trim(),
        'mode': fundModeController.text.trim(),
        'remark': fundRemarkController.text.trim(),
        'screenshot': MultipartFile(
          fundScreenshot!.path,
          filename: fundScreenshot!.path.split(RegExp(r'[/\\]')).last,
        ),
      };

      final response = await walletRepoInvest.sendRequestForWalletFund(
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        String message = 'Fund request submitted successfully';

        if (response.body is Map) {
          final responseBody = response.body as Map;

          message = responseBody['message']?.toString() ??
              responseBody['msg']?.toString() ??
              message;
        }

        showToast(
          message: message,
          typeCheck: true,
        );

        clearFundRequestForm();

        return true;
      }

      // ----------------------------------------------------------
      // API Error
      // ----------------------------------------------------------

      String message = 'Unable to submit fund request';

      if (response.body is Map) {
        final responseBody = response.body as Map;

        message = responseBody['message']?.toString() ??
            responseBody['msg']?.toString() ??
            message;
      }

      showToast(
        message: message,
        typeCheck: false,
      );

      return false;
    } catch (e) {
      debugPrint(
        'sendRequestForWalletFund error: $e',
      );

      showToast(
        message: 'Something went wrong. Please try again.',
        typeCheck: false,
      );

      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  void clearFundRequestForm() {
    fundAmountController.clear();
    transactionIdController.clear();
    fundModeController.clear();
    fundRemarkController.clear();

    fundScreenshot = null;

    update();
  }

  @override
  void onClose() {
    withdrawalAmountTimer?.cancel();
    withdrawalAmountTimer = null;
    fundAmountController.dispose();
    transactionIdController.dispose();
    fundModeController.dispose();
    fundRemarkController.dispose();
    amountController.dispose();

    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
  }
}
