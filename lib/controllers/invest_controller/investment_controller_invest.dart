import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/invest_controller/basic_controller_invest.dart';
import 'package:vlr/data/models/invest_model/activation_history_model_invest.dart';
import 'package:vlr/data/models/invest_model/investment_package_model.dart';
import 'package:vlr/data/models/response/response_model.dart';
import 'package:vlr/data/repositories/invest_repo/investment_repo_invest.dart';
import 'package:vlr/views/wealth_grow_app/screen/widget/pagination_invest/pagination_state_invest.dart';

class InvestmentControllerInvest extends GetxController implements GetxService {
  final InvestmentRepoInvest investmentRepoInvest;

  InvestmentControllerInvest({
    required this.investmentRepoInvest,
  });

  bool isLoading = false;

  List<InvestmentPackageModel> investmentPackageModelList = [];

  Future<ResponseModel> fetchAllPackageInvest() async {
    log('----------- fetchAllPackageInvest Called ----------');

    isLoading = true;
    update();

    try {
      final Response response =
          await investmentRepoInvest.fetchAllPackageInvest();

      log("Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        if (response.body is List) {
          final List<dynamic> responseList = response.body;

          investmentPackageModelList = responseList
              .whereType<Map>()
              .map(
                (item) => InvestmentPackageModel.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .toList();

          log(
            "Investment packages loaded: "
            "${investmentPackageModelList.length}",
          );

          return ResponseModel(
            true,
            "Investment packages fetched successfully",
            investmentPackageModelList,
          );
        }

        investmentPackageModelList = [];

        return ResponseModel(
          false,
          "Invalid investment package response",
        );
      }

      String errorMessage = "Unable to fetch investment packages";

      if (response.body is Map && response.body['message'] != null) {
        errorMessage = response.body['message'].toString();
      }

      return ResponseModel(
        false,
        errorMessage,
      );
    } catch (e, stackTrace) {
      log(
        'ERROR AT fetchAllPackageInvest(): $e',
        stackTrace: stackTrace,
      );

      investmentPackageModelList = [];

      return ResponseModel(
        false,
        "Error while fetching investment packages",
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  InvestmentPackageModel? selectInvestmentPackageModel;

  void updateInvestmentPackageModel({
    required InvestmentPackageModel investmentPackageModel,
  }) {
    selectInvestmentPackageModel = investmentPackageModel;

    // Set default calculation to daily
    updateReturnCalculation(
      period: "daily",
      notify: false,
    );

    update();
  }

  TextEditingController amountController = TextEditingController();

  String selectedReturnPeriod = "daily";
  String selectedReturnPeriodPer = "";

  void updateReturnCalculation({
    required String period,
    bool notify = true,
  }) {
    selectedReturnPeriod = period.trim().toLowerCase();

    final package = selectInvestmentPackageModel;

    if (package == null) {
      selectedReturnPeriodPer = "";

      if (notify) {
        update();
      }

      return;
    }

    // Get percentage based on selected period
    switch (selectedReturnPeriod) {
      case "daily":
        selectedReturnPeriodPer = package.dailyPercent ?? "";
        break;

      case "monthly":
        selectedReturnPeriodPer = package.monthlyPercent ?? "";
        break;

      case "yearly":
        selectedReturnPeriodPer = package.yearlyPercent ?? "";
        break;

      default:
        selectedReturnPeriodPer = "";
    }

    // Get entered investment amount
    final double? investmentAmount =
        double.tryParse(amountController.text.trim());

    // Get selected percentage

    log('Return Calculation -> '
        'Period: $selectedReturnPeriod, '
        'Percentage: $selectedReturnPeriodPer, '
        'Investment: $investmentAmount, ');

    if (notify) {
      update();
    }
  }

  /// Recalculate return when investment amount changes.
  void updateInvestmentAmount(String value) {
    updateReturnCalculation(
      period: selectedReturnPeriod,
    );
  }

  final PaginationStateInvest<ActivationHistoryModelInvest>
      activationHistoryPagination =
      PaginationStateInvest<ActivationHistoryModelInvest>(
    pageSize: 10,
  );

  Future<ResponseModel> fetchActivationHistory({
    bool loadMore = false,
  }) async {
    if (loadMore) {
      if (!activationHistoryPagination.canLoadMore) {
        return ResponseModel(
          true,
          "No more activation history",
        );
      }

      if (activationHistoryPagination.isMoreLoading) {
        return ResponseModel(
          false,
          "Already loading more data",
        );
      }

      activationHistoryPagination.isMoreLoading = true;
      update();
    } else {
      if (activationHistoryPagination.isInitialLoading) {
        return ResponseModel(
          false,
          "Already loading activation history",
        );
      }

      activationHistoryPagination.reset();
      activationHistoryPagination.isInitialLoading = true;
      update();
    }

    try {
      final int nextPage = loadMore ? activationHistoryPagination.page + 1 : 1;

      final int result = activationHistoryPagination.pageSize;

      final Response response =
          await investmentRepoInvest.fetchActivationHistoryInvest(
        page: nextPage,
        result: result,
      );

      log(
        "Activation History "
        "Page: $nextPage "
        "Status: ${response.statusCode}",
      );

      if (response.statusCode != 200) {
        String message = "Unable to fetch activation history";

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
          "Invalid activation history response",
        );
      }

      final Map<String, dynamic> body =
          Map<String, dynamic>.from(response.body);

      final int total = int.tryParse(
            body['counts']?.toString() ?? '',
          ) ??
          0;

      final List<dynamic> responseList =
          body['data'] is List ? body['data'] : <dynamic>[];

      final List<ActivationHistoryModelInvest> newItems = responseList
          .whereType<Map>()
          .map(
            (item) => ActivationHistoryModelInvest.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();

      final int lastPage = total == 0 ? 1 : (total / result).ceil();

      activationHistoryPagination.lastPage = lastPage;

      if (loadMore) {
        activationHistoryPagination.appendItems(
          newItems,
          getId: (item) => item.uniqueId,
        );

        activationHistoryPagination.page = nextPage;
      } else {
        activationHistoryPagination.setItems(
          newItems,
          getId: (item) => item.uniqueId,
        );

        activationHistoryPagination.page = 1;
      }

      log(
        "Activation History -> "
        "Total: $total, "
        "Current Page: ${activationHistoryPagination.page}, "
        "Last Page: ${activationHistoryPagination.lastPage}, "
        "Items: ${activationHistoryPagination.items.length}",
      );

      return ResponseModel(
        true,
        "Activation history fetched successfully",
        activationHistoryPagination.items,
      );
    } catch (e, stackTrace) {
      log(
        "ERROR AT fetchActivationHistory(): $e",
        stackTrace: stackTrace,
      );

      return ResponseModel(
        false,
        "Error while fetching activation history",
      );
    } finally {
      if (loadMore) {
        activationHistoryPagination.isMoreLoading = false;
      } else {
        activationHistoryPagination.isInitialLoading = false;
      }

      update();
    }
  }

  List<ActivationHistoryModelInvest> historyInvestmentModelInvestList = [];
  Future<ResponseModel> fetchHistoryInvestmentInvest() async {
    log(
      '----------- fetchHistoryInvestmentInvest Called ----------',
    );

    isLoading = true;
    update();

    try {
      final Response response =
          await investmentRepoInvest.fetchHistoryInvestmentInvest();

      log(
        "Status Code: ${response.statusCode}",
      );

      if (response.statusCode != 200) {
        String errorMessage = "Unable to fetch completed investments";

        if (response.body is Map && response.body['message'] != null) {
          errorMessage = response.body['message'].toString();
        }

        return ResponseModel(
          false,
          errorMessage,
        );
      }

      final dynamic body = response.body;

      List<dynamic> responseList = [];

      if (body is Map && body['data'] is List) {
        responseList = body['data'];
      } else if (body is List) {
        responseList = body;
      }

      historyInvestmentModelInvestList = responseList
          .whereType<Map>()
          .map(
            (e) => ActivationHistoryModelInvest.fromJson(
              Map<String, dynamic>.from(e),
            ),
          )
          .toList();

      log(
        "Completed investments loaded: "
        "${historyInvestmentModelInvestList.length}",
      );

      return ResponseModel(
        true,
        "Completed investments fetched successfully",
        historyInvestmentModelInvestList,
      );
    } catch (e, stackTrace) {
      log(
        'ERROR AT fetchHistoryInvestmentInvest(): $e',
        stackTrace: stackTrace,
      );

      historyInvestmentModelInvestList = [];

      return ResponseModel(
        false,
        "Error while fetching completed investments",
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<ResponseModel> investmentInvest({
    required bool isActivationRequest,
    required String userSponsorCode,
    required,
  }) async {
    log('----------- investmentInvest Called ----------');

    ResponseModel responseModel;

    isLoading = true;
    update();

    try {
      String incomeTypeId = Get.find<BasicControllerInvest>()
          .getIncomeFrequencyId(selectedReturnPeriod);
      final Map<String, dynamic> body = {
        'user_sponsor_code': userSponsorCode,
        'package': selectInvestmentPackageModel?.id ?? "",
        'income_type': incomeTypeId,
      };

      log('Investment Request Body: $body');

      log('isActivationRequest stuts : $isActivationRequest');

      // ----------------------------------------------------------
      // API Request
      // ----------------------------------------------------------

      final Response response = await investmentRepoInvest.investmentInvest(
        body: body,
        isActivationRequest: isActivationRequest,
      );

      log(
        'Investment Status Code: ${response.statusCode}',
      );

      log(
        'Investment Response Body: ${response.body}',
      );

      // ----------------------------------------------------------
      // Success
      // ----------------------------------------------------------

      if (response.statusCode == 200 || response.statusCode == 201) {
        String message = 'Investment request submitted successfully';

        if (response.body is Map && response.body['message'] != null) {
          message = response.body['message'].toString();
        }

        responseModel = ResponseModel(
          true,
          message,
          response.body,
        );
      }

      // ----------------------------------------------------------
      // Error
      // ----------------------------------------------------------

      else {
        String errorMessage = 'Unable to process investment request';

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
        'ERROR AT investmentInvest(): $e',
        stackTrace: stackTrace,
      );

      responseModel = ResponseModel(
        false,
        'Something went wrong while processing investment request',
      );
    } finally {
      isLoading = false;
      update();
    }

    return responseModel;
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }
}
