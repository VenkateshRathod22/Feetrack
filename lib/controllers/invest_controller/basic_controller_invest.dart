import 'dart:developer';

import 'package:get/get.dart';
import 'package:vlr/data/models/invest_model/app_model_invest.dart';
import 'package:vlr/data/models/invest_model/home_model_invest.dart';
import 'package:vlr/data/models/response/response_model.dart';
import 'package:vlr/data/repositories/invest_repo/basic_repo_invest.dart';

class BasicControllerInvest extends GetxController implements GetxService {
  final BasicRepoInvest basicRepoInvest;

  BasicControllerInvest({required this.basicRepoInvest});

  bool isLoading = false;

  AppSettingInvestModel? appSettingInvestModel;

  Future<ResponseModel> fetchAppSettingInvest() async {
    log('----------- fetchAppSettingInvest Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await basicRepoInvest.fetchAppSettingInvest();
      log("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        appSettingInvestModel = AppSettingInvestModel.fromJson(response.body);
        responseModel = ResponseModel(
            true,
            response.body['message'] ??
                " fetch App Setting investment success");
      } else {
        responseModel = ResponseModel(
            false,
            response.body['message'] ??
                "Error while fetch App Setting investment");
      }
    } catch (e) {
      log('ERROR AT fetchAppSettingInvest(): $e');
      responseModel =
          ResponseModel(false, "Error while fetchAppSettingInvest $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  HomeInvestModel? homeInvestModel;
  Future<ResponseModel> fetchHomeInvest() async {
    log('----------- fetchHomeInvest Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await basicRepoInvest.fetchHomeInvest();
      // log("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        homeInvestModel = HomeInvestModel.fromJson(response.body);
        responseModel = ResponseModel(true,
            response.body['message'] ?? " fetch home  investment success");
      } else {
        responseModel = ResponseModel(false,
            response.body['message'] ?? "Error while home App home investment");
      }
    } catch (e) {
      log('ERROR AT fetchHomeInvest(): $e');
      responseModel = ResponseModel(false, "Error while fetchHomeInvest $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }
}
