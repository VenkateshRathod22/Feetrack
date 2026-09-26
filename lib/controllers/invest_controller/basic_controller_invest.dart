import 'dart:developer';

import 'package:get/get.dart';
import 'package:vlr/data/models/invest_model/app_model_invest.dart';
import 'package:vlr/data/models/invest_model/home_model_invest.dart';
import 'package:vlr/data/models/response/response_model.dart';
import 'package:vlr/data/repositories/invest_repo/basic_repo_invest.dart';

class BasicControllerInvest extends GetxController implements GetxService {
  final BasicRepoInvest basicRepoInvest;

  BasicControllerInvest({
    required this.basicRepoInvest,
  });

  bool isLoading = false;

  AppSettingInvestModel? appSettingInvestModel;

  // Selected return frequency
  String? selectedIncomeFrequencyId;

  Future<ResponseModel> fetchAppSettingInvest() async {
    log('----------- fetchAppSettingInvest Called ----------');

    ResponseModel responseModel;

    isLoading = true;
    update();

    try {
      Response response =
          await basicRepoInvest.fetchAppSettingInvest();

      log("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        appSettingInvestModel =
            AppSettingInvestModel.fromJson(response.body);

        // Set first frequency as default
        final frequencyList =
            appSettingInvestModel?.incomeFrequency;

        if (frequencyList != null &&
            frequencyList.isNotEmpty &&
            selectedIncomeFrequencyId == null) {
          selectedIncomeFrequencyId =
              frequencyList.first.id;
        }

        responseModel = ResponseModel(
          true,
          response.body['message'] ??
              "Fetch App Setting investment success",
        );
      } else {
        responseModel = ResponseModel(
          false,
          response.body['message'] ??
              "Error while fetch App Setting investment",
        );
      }
    } catch (e) {
      log('ERROR AT fetchAppSettingInvest(): $e');

      responseModel = ResponseModel(
        false,
        "Error while fetchAppSettingInvest $e",
      );
    }

    isLoading = false;
    update();

    return responseModel;
  }

  void selectIncomeFrequency(String? id) {
    selectedIncomeFrequencyId = id;

    log(
      'Selected Income Frequency ID: $selectedIncomeFrequencyId',
    );

    update();
  }

  IncomeFrequency? get selectedIncomeFrequency {
    final list =
        appSettingInvestModel?.incomeFrequency;

    if (list == null || list.isEmpty) {
      return null;
    }

    for (final item in list) {
      if (item.id == selectedIncomeFrequencyId) {
        return item;
      }
    }

    return list.first;
  }

  HomeInvestModel? homeInvestModel;

  Future<ResponseModel> fetchHomeInvest() async {
    log('----------- fetchHomeInvest Called ----------');

    ResponseModel responseModel;

    isLoading = true;
    update();

    try {
      Response response =
          await basicRepoInvest.fetchHomeInvest();

      if (response.statusCode == 200) {
        homeInvestModel =
            HomeInvestModel.fromJson(response.body);

        responseModel = ResponseModel(
          true,
          response.body['message'] ??
              "Fetch home investment success",
        );
      } else {
        responseModel = ResponseModel(
          false,
          response.body['message'] ??
              "Error while fetch home investment",
        );
      }
    } catch (e) {
      log('ERROR AT fetchHomeInvest(): $e');

      responseModel = ResponseModel(
        false,
        "Error while fetchHomeInvest $e",
      );
    }

    isLoading = false;
    update();

    return responseModel;
  }
}