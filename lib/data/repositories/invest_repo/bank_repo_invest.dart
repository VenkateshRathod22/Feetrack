import 'package:get/get_connect/http/src/response/response.dart';
import 'package:vlr/data/api/invest_api_client.dart' show InvestApiClient;
import 'package:vlr/services/constants.dart';

class BankRepoInvest {
  final InvestApiClient investApiClient;

  BankRepoInvest({required this.investApiClient});

  Future<Response> fetchGetAllBankInvest() async {
    return await investApiClient.getData(
      AppConstants.getAllBankInvest,
      "fetchGetAllBankInvest",
      contentType: 'application/json',
      requiresAuth: false,
      headers: investApiClient.getSponsorHeaders(),
    );
  }
}
