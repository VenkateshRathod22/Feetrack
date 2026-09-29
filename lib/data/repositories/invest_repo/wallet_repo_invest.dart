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
}
