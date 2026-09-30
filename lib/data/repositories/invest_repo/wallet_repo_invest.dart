import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:vlr/data/api/invest_api_client.dart';
import 'package:vlr/services/constants.dart';

class WalletRepoInvest {
  final InvestApiClient investApiClient;

  WalletRepoInvest({required this.investApiClient});

  Future<Response> withdrawFundsInvest({
    required Map<String, dynamic> body,
  }) async {
    return await investApiClient.postData(
      AppConstants.withdrawRequestInvest,
      'withdrawFundsInvest',
      body,
      contentType: 'application/json',
      requiresAuth: true,
      headers: investApiClient.getSponsorHeaders(),
    );
  }

  Future<Response> sendRequestForWalletFund({
    required Map<String, dynamic> body,
  }) async {
    return await investApiClient.postData(
      AppConstants.fundRequestInvest,
      'sendRequestForWalletFund',
      FormData(body),
      contentType: 'multipart/form-data',
      requiresAuth: true,
      headers: investApiClient.getSponsorHeaders(),
    );
  }

  Future<Response> fetchFundHistoryInvest({
    required int page,
    required int result,
    required int typeApprovedAndPending,
  }) async {
    return await investApiClient.getData(
      "${AppConstants.getFundHistoryInvest}?type=$typeApprovedAndPending&page=$page&result=$result",
      "fetchFundHistory",
      contentType: "application/json",
      requiresAuth: false,
      headers: investApiClient.getSponsorHeaders(),
    );
  }
}
