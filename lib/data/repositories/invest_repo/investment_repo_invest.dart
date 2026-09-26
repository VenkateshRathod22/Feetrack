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
}
