import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/data/models/invest_model/bank_model_invest.dart';
import 'package:vlr/data/models/invest_model/fund_history_model_invest.dart';
import 'package:vlr/data/models/response/response_model.dart';
import 'package:vlr/data/repositories/invest_repo/wallet_repo_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/views/wealth_grow_app/screen/widget/pagination_invest/pagination_state_invest.dart';

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

  final PaginationStateInvest<FundHistoryModelInvest>
      fundHistoryApprovedPagination =
      PaginationStateInvest<FundHistoryModelInvest>(
    pageSize: 10,
  );

  Future<ResponseModel> fetchApprovedFundHistory({
    bool loadMore = false,
  }) async {
    if (loadMore) {
      if (!fundHistoryApprovedPagination.canLoadMore) {
        return ResponseModel(
          true,
          "No more fund history",
        );
      }

      if (fundHistoryApprovedPagination.isMoreLoading) {
        return ResponseModel(
          false,
          "Already loading more fund history",
        );
      }

      fundHistoryApprovedPagination.isMoreLoading = true;
      update();
    } else {
      if (fundHistoryApprovedPagination.isInitialLoading) {
        return ResponseModel(
          false,
          "Already loading fund history",
        );
      }

      fundHistoryApprovedPagination.reset();
      fundHistoryApprovedPagination.isInitialLoading = true;
      update();
    }

    try {
      final int nextPage =
          loadMore ? fundHistoryApprovedPagination.page + 1 : 1;

      final int result = fundHistoryApprovedPagination.pageSize;

      final Response response = await walletRepoInvest.fetchFundHistoryInvest(
        page: nextPage,
        result: result,
        typeApprovedAndPending: 1,
      );

      log(
        "Fund History "
        "Page: $nextPage "
        "Status: ${response.statusCode}",
      );

      if (response.statusCode != 200) {
        String message = "Unable to fetch fund history";

        if (response.body is Map && response.body['message'] != null) {
          message = response.body['message'].toString();
        }

        return ResponseModel(
          false,
          message,
        );
      }

      if (response.body is! Map) {
        return ResponseModel(
          false,
          "Invalid fund history response",
        );
      }

      final Map<String, dynamic> body =
          Map<String, dynamic>.from(response.body);

      final int total = int.tryParse(body['counts']?.toString() ?? '') ?? 0;

      final List<dynamic> responseList =
          body['data'] is List ? body['data'] : <dynamic>[];

      final List<FundHistoryModelInvest> newItems = responseList
          .whereType<Map>()
          .map(
            (item) => FundHistoryModelInvest.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();

      final int lastPage = total == 0 ? 1 : (total / result).ceil();

      fundHistoryApprovedPagination.lastPage = lastPage;

      if (loadMore) {
        fundHistoryApprovedPagination.appendItems(
          newItems,
          getId: (item) => item.id,
        );

        fundHistoryApprovedPagination.page = nextPage;
      } else {
        fundHistoryApprovedPagination.setItems(
          newItems,
          getId: (item) => item.id,
        );

        fundHistoryApprovedPagination.page = 1;
      }

      log(
        "Fund History -> "
        "Total: $total, "
        "Current Page: ${fundHistoryApprovedPagination.page}, "
        "Last Page: ${fundHistoryApprovedPagination.lastPage}, "
        "Items: ${fundHistoryApprovedPagination.items.length}",
      );

      return ResponseModel(
        true,
        "Fund history fetched successfully",
        fundHistoryApprovedPagination.items,
      );
    } catch (e, stackTrace) {
      log(
        "ERROR AT fetchFundHistory(): $e",
        stackTrace: stackTrace,
      );

      return ResponseModel(
        false,
        "Error while fetching fund history",
      );
    } finally {
      if (loadMore) {
        fundHistoryApprovedPagination.isMoreLoading = false;
      } else {
        fundHistoryApprovedPagination.isInitialLoading = false;
      }

      update();
    }
  }

  final PaginationStateInvest<FundHistoryModelInvest>
      fundHistoryPendingPagination =
      PaginationStateInvest<FundHistoryModelInvest>(
    pageSize: 10,
  );

  Future<ResponseModel> fetchPendingFundHistory({
    bool loadMore = false,
  }) async {
    if (loadMore) {
      if (!fundHistoryPendingPagination.canLoadMore) {
        return ResponseModel(
          true,
          "No more fund history",
        );
      }

      if (fundHistoryPendingPagination.isMoreLoading) {
        return ResponseModel(
          false,
          "Already loading more fund history",
        );
      }

      fundHistoryPendingPagination.isMoreLoading = true;
      update();
    } else {
      if (fundHistoryPendingPagination.isInitialLoading) {
        return ResponseModel(
          false,
          "Already loading fund history",
        );
      }

      fundHistoryPendingPagination.reset();
      fundHistoryPendingPagination.isInitialLoading = true;
      update();
    }

    try {
      final int nextPage = loadMore ? fundHistoryPendingPagination.page + 1 : 1;

      final int result = fundHistoryPendingPagination.pageSize;

      final Response response = await walletRepoInvest.fetchFundHistoryInvest(
        page: nextPage,
        result: result,
        typeApprovedAndPending: 0,
      );

      log(
        "Fund History "
        "Page: $nextPage "
        "Status: ${response.statusCode}",
      );

      if (response.statusCode != 200) {
        String message = "Unable to fetch fund history";

        if (response.body is Map && response.body['message'] != null) {
          message = response.body['message'].toString();
        }

        return ResponseModel(
          false,
          message,
        );
      }

      if (response.body is! Map) {
        return ResponseModel(
          false,
          "Invalid fund history response",
        );
      }

      final Map<String, dynamic> body =
          Map<String, dynamic>.from(response.body);

      final int total = int.tryParse(body['counts']?.toString() ?? '') ?? 0;

      final List<dynamic> responseList =
          body['data'] is List ? body['data'] : <dynamic>[];

      final List<FundHistoryModelInvest> newItems = responseList
          .whereType<Map>()
          .map(
            (item) => FundHistoryModelInvest.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();

      final int lastPage = total == 0 ? 1 : (total / result).ceil();

      fundHistoryPendingPagination.lastPage = lastPage;

      if (loadMore) {
        fundHistoryPendingPagination.appendItems(
          newItems,
          getId: (item) => item.id,
        );

        fundHistoryPendingPagination.page = nextPage;
      } else {
        fundHistoryPendingPagination.setItems(
          newItems,
          getId: (item) => item.id,
        );

        fundHistoryPendingPagination.page = 1;
      }

      log(
        "Fund History -> "
        "Total: $total, "
        "Current Page: ${fundHistoryPendingPagination.page}, "
        "Last Page: ${fundHistoryPendingPagination.lastPage}, "
        "Items: ${fundHistoryPendingPagination.items.length}",
      );

      return ResponseModel(
        true,
        "Fund history fetched successfully",
        fundHistoryPendingPagination.items,
      );
    } catch (e, stackTrace) {
      log(
        "ERROR AT fetchFundHistory(): $e",
        stackTrace: stackTrace,
      );

      return ResponseModel(
        false,
        "Error while fetching fund history",
      );
    } finally {
      if (loadMore) {
        fundHistoryPendingPagination.isMoreLoading = false;
      } else {
        fundHistoryPendingPagination.isInitialLoading = false;
      }

      update();
    }
  }

  Future<void> loadFundHistory() async {
    await Future.wait([
      fetchApprovedFundHistory(),
      fetchPendingFundHistory(),
    ]);

    fundHistorySortedList();
  }

  List<FundHistoryModelInvest> fundHistoryModelInvestList = [];

  void fundHistorySortedList() {
    fundHistoryModelInvestList = [
      ...fundHistoryApprovedPagination.items,
      ...fundHistoryPendingPagination.items,
    ];

    fundHistoryModelInvestList.sort((a, b) {
      final DateTime dateA = DateTime.tryParse(a.createdAt) ??
          DateTime.fromMillisecondsSinceEpoch(0);

      final DateTime dateB = DateTime.tryParse(b.createdAt) ??
          DateTime.fromMillisecondsSinceEpoch(0);

      return dateB.compareTo(dateA); // Newest first
    });

    update();
  }

  FundHistoryModelInvest? selectFundHistoryModelInvest;

  void updateFundHistoryModelInvest(
      {required FundHistoryModelInvest fundHistoryModelInvest}) {
    selectFundHistoryModelInvest = fundHistoryModelInvest;
    update();
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
