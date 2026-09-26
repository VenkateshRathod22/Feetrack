import 'dart:developer';

import 'package:get/get.dart';
import 'package:vlr/data/models/invest_model/investment_package_model.dart';
import 'package:vlr/data/models/response/response_model.dart';
import 'package:vlr/data/repositories/invest_repo/investment_repo_invest.dart';

class InvestmentControllerInvest extends GetxController
    implements GetxService {
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

      if (response.body is Map &&
          response.body['message'] != null) {
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
}