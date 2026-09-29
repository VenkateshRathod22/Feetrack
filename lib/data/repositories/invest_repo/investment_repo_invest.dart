import 'package:get/get_connect/http/src/response/response.dart';
import 'package:vlr/data/api/invest_api_client.dart';
import 'package:vlr/services/constants.dart';

class InvestmentRepoInvest {
  final InvestApiClient investApiClient;

  InvestmentRepoInvest({required this.investApiClient});

  Future<Response> fetchAllPackageInvest() async {
    return await investApiClient.getData(
      AppConstants.getPackageInvest,
      "fetchAllPackageInvest",
      contentType: 'application/json',
      requiresAuth: false,
      headers: investApiClient.getSponsorHeaders(),
    );
  }

  Future<Response> fetchActivationHistoryInvest({
    required int page,
    required int result,
  }) async {
    return await investApiClient.getData(
      "${AppConstants.getActivateInvestmentInvest}?page=$page&result=$result",
      "fetchActivationHistory",
      contentType: "application/json",
      requiresAuth: false,
      headers: investApiClient.getSponsorHeaders(),
    );
  }

  Future<Response> fetchHistoryInvestmentInvest() async {
    return await investApiClient.getData(
      AppConstants.getHistoryInvestmentInvest,
      "fetchAllPackageInvest",
      contentType: 'application/json',
      requiresAuth: false,
      headers: investApiClient.getSponsorHeaders(),
    );
  }

  Future<Response> investmentInvest({
    required Map<String, dynamic> body,
    required bool isActivationRequest,
  }) async {
    return await investApiClient.postData(
      isActivationRequest
          ? AppConstants.investUpdateInvest
          : AppConstants.investActivationInvest,
      "investmentInvest",
      body,
      contentType: 'application/json',
      requiresAuth: false,
      headers: investApiClient.getSponsorHeaders(),
    );
  }
}
