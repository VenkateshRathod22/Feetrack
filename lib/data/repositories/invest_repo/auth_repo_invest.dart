import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlr/data/api/invest_api_client.dart';
import 'package:vlr/services/constants.dart';

class AuthRepoInvest {
  final SharedPreferences sharedPreferences;
  final InvestApiClient investApiClient;

  AuthRepoInvest({
    required this.sharedPreferences,
    required this.investApiClient,
  });

  Future<Response> postLoginInvest({
    required Map<String, dynamic> data,
  }) async {
    return await investApiClient.postData(
      AppConstants.loginInvest,
      "postLoginInvest",
      data,
      contentType: 'application/json',
      requiresAuth: false,
    );
  }

  Future<Response> fetchProfileInvest() async {
    return await investApiClient.getData(
      AppConstants.getUserProfileInvest,
      "fetchProfileInvest",
      contentType: 'application/json',
      requiresAuth: false,
      headers: investApiClient.getSponsorHeaders(),
    );
  }

  String getUserToken() {
    return sharedPreferences.getString(
          AppConstants.tokenInvest,
        ) ??
        '';
  }

  Future<void> setUserToken(String token) async {
    await sharedPreferences.setString(
      AppConstants.tokenInvest,
      token,
    );

    investApiClient.updateHeader(token);
  }

  String getUserId() {
    return sharedPreferences.getString(
          AppConstants.userId,
        ) ??
        '';
  }

  bool isLoggedIn() {
    return getUserToken().isNotEmpty;
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.tokenInvest);
    sharedPreferences.remove(AppConstants.userId);

    investApiClient.clearToken();

    return true;
  }
}
