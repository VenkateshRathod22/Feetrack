import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlr/data/api/invest_api_client.dart';
import 'package:vlr/services/constants.dart';

class BasicRepoInvest {
  final SharedPreferences sharedPreferences;
  final InvestApiClient investApiClient;

  BasicRepoInvest(
      {required this.sharedPreferences, required this.investApiClient});

  Future<Response> fetchAppSettingInvest() async {
    return await investApiClient.getData(
      AppConstants.appSettingInvest,
      "fetchAppSettingInvest",
      contentType: 'application/json',
      requiresAuth: false,
      headers: investApiClient.getSponsorHeaders(),
    );
  }
}
