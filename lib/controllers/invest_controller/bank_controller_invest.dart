import 'dart:developer';

import 'package:get/get.dart';
import 'package:vlr/data/models/invest_model/bank_model_invest.dart';
import 'package:vlr/data/models/response/response_model.dart';
import 'package:vlr/data/repositories/invest_repo/bank_repo_invest.dart';

class BankControllerInvest extends GetxController implements GetxService {
  final BankRepoInvest bankRepoInvest;

  BankControllerInvest({required this.bankRepoInvest});

  bool isLoading = false;

  List<BankModelInvest> bankModelInvestList = [];

  Future<ResponseModel> fetchGetAllBankInvest() async {
    log(
      '----------- fetchGetAllBankInvest Called ----------',
    );

    isLoading = true;
    update();

    try {
      final Response response = await bankRepoInvest.fetchGetAllBankInvest();

      log(
        "Status Code: ${response.statusCode}",
      );

      if (response.statusCode != 200) {
        String errorMessage = "Unable to fetchGetAllBankInvest";

        if (response.body is Map && response.body['message'] != null) {
          errorMessage = response.body['message'].toString();
        }

        return ResponseModel(
          false,
          errorMessage,
        );
      }

      final dynamic body = response.body;

      List<dynamic> responseList = [];

      if (body is Map && body['data'] is List) {
        responseList = body['data'];
      } else if (body is List) {
        responseList = body;
      }

      bankModelInvestList = responseList
          .whereType<Map>()
          .map(
            (e) => BankModelInvest.fromJson(
              Map<String, dynamic>.from(e),
            ),
          )
          .toList();

      log(
        "Completed investments loaded: "
        "${bankModelInvestList.length}",
      );

      return ResponseModel(
        true,
        "Completed investments fetched successfully",
        bankModelInvestList,
      );
    } catch (e, stackTrace) {
      log(
        'ERROR AT fetchGetAllBankInvest(): $e',
        stackTrace: stackTrace,
      );

      bankModelInvestList = [];

      return ResponseModel(
        false,
        "Error while fetchGetAllBankInvest",
      );
    } finally {
      isLoading = false;
      update();
    }
  }
}
