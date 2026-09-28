import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import 'package:vlr/data/models/invest_model/bank_model_invest.dart';
import 'package:vlr/data/models/response/response_model.dart';
import 'package:vlr/data/repositories/invest_repo/bank_repo_invest.dart';

class BankControllerInvest extends GetxController implements GetxService {
  final BankRepoInvest bankRepoInvest;

  BankControllerInvest({
    required this.bankRepoInvest,
  });

  // ============================================================
  // LOADING
  // ============================================================

  bool isLoading = false;

  // ============================================================
  // BANK LIST
  // ============================================================

  List<BankModelInvest> bankModelInvestList = [];

  // ============================================================
  // ADD BANK ACCOUNT FORM
  // ============================================================

  final TextEditingController bankNameController = TextEditingController();

  final TextEditingController accountHolderController = TextEditingController();

  final TextEditingController accountNumberController = TextEditingController();

  final TextEditingController confirmAccountNumberController =
      TextEditingController();

  final TextEditingController ifscController = TextEditingController();

  String accountType = 'Savings';

  // ============================================================
  // ACCOUNT TYPE
  // ============================================================

  void setAccountType(String value) {
    accountType = value;
    update();
  }

  // ============================================================
  // GET ALL BANK ACCOUNTS
  // ============================================================

  Future<ResponseModel> fetchGetAllBankInvest() async {
    log(
      '----------- fetchGetAllBankInvest Called ----------',
    );

    isLoading = true;
    update();

    try {
      final Response response = await bankRepoInvest.fetchGetAllBankInvest();

      log(
        'Status Code: ${response.statusCode}',
      );

      if (response.statusCode != 200) {
        String errorMessage = 'Unable to fetchGetAllBankInvest';

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
        'Bank accounts loaded: '
        '${bankModelInvestList.length}',
      );

      return ResponseModel(
        true,
        'Bank accounts fetched successfully',
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
        'Error while fetchGetAllBankInvest',
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  // ============================================================
  // ADD BANK ACCOUNT
  // ============================================================

  Future<ResponseModel> addBankAccountInvest() async {
    log(
      '----------- addBankAccountInvest Called ----------',
    );

    isLoading = true;
    update();

    try {
      // ========================================================
      // REQUEST BODY
      // ========================================================

      final Map<String, dynamic> body = {
        'bank_name': bankNameController.text.trim(),
        'account_holder_name': accountHolderController.text.trim(),
        'account_no': accountNumberController.text.trim(),
        'ifsc': ifscController.text.trim().toUpperCase(),
        'account_type': accountType.trim(),
      };

      log(
        'Add Bank Request Body: $body',
      );

      // ========================================================
      // API CALL
      // ========================================================

      final Response response = await bankRepoInvest.addBankInvest(
        body: body,
      );

      log(
        'Add Bank Status Code: '
        '${response.statusCode}',
      );

      log(
        'Add Bank Response: '
        '${response.body}',
      );

      // ========================================================
      // STATUS CHECK
      // ========================================================

      if (response.statusCode != 200 && response.statusCode != 201) {
        String errorMessage = 'Unable to add bank account';

        if (response.body is Map) {
          final dynamic message =
              response.body['message'] ?? response.body['error'];

          if (message != null) {
            errorMessage = message.toString();
          }
        }

        return ResponseModel(
          false,
          errorMessage,
        );
      }

      // ========================================================
      // RESPONSE
      // ========================================================

      final dynamic bodyResponse = response.body;

      bool success = true;

      String message = 'Bank account added successfully';

      if (bodyResponse is Map) {
        if (bodyResponse['success'] != null) {
          success = bodyResponse['success'] == true ||
              bodyResponse['success'].toString() == '1' ||
              bodyResponse['success'].toString().toLowerCase() == 'true';
        }

        if (bodyResponse['message'] != null) {
          message = bodyResponse['message'].toString();
        }
      }

      if (!success) {
        return ResponseModel(
          false,
          message,
        );
      }

      // ========================================================
      // REFRESH BANK LIST
      // ========================================================

      await fetchGetAllBankInvest();

      // ========================================================
      // CLEAR FORM
      // ========================================================

      clearAddBankForm();

      return ResponseModel(
        true,
        message,
      );
    } catch (e, stackTrace) {
      log(
        'ERROR AT addBankAccountInvest(): $e',
        stackTrace: stackTrace,
      );

      return ResponseModel(
        false,
        'Error while adding bank account',
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  // ============================================================
  // CLEAR ADD BANK FORM
  // ============================================================

  void clearAddBankForm() {
    bankNameController.clear();
    accountHolderController.clear();
    accountNumberController.clear();
    confirmAccountNumberController.clear();
    ifscController.clear();

    accountType = 'Savings';

    update();
  }

  Future<ResponseModel> deleteBankAccountInvest({
    required String id,
  }) async {
    log(
      '----------- deleteBankAccountInvest Called ----------',
    );

    isLoading = true;
    update();

    try {
      final Response response = await bankRepoInvest.deleteBankInvest(
        id: id,
      );

      log(
        'Delete Bank Status Code: ${response.statusCode}',
      );

      log(
        'Delete Bank Response: ${response.body}',
      );

      if (response.statusCode != 200) {
        String errorMessage = 'Unable to delete bank account';

        if (response.body is Map) {
          final dynamic message =
              response.body['message'] ?? response.body['error'];

          if (message != null) {
            errorMessage = message.toString();
          }
        }

        return ResponseModel(
          false,
          errorMessage,
        );
      }

      final dynamic bodyResponse = response.body;

      bool success = true;

      String message = 'Bank account deleted successfully';

      if (bodyResponse is Map) {
        if (bodyResponse['success'] != null) {
          success = bodyResponse['success'] == true ||
              bodyResponse['success'].toString() == '1' ||
              bodyResponse['success'].toString().toLowerCase() == 'true';
        }

        if (bodyResponse['message'] != null) {
          message = bodyResponse['message'].toString();
        }
      }

      if (!success) {
        return ResponseModel(
          false,
          message,
        );
      }

      // Refresh bank list after delete.
      await fetchGetAllBankInvest();

      return ResponseModel(
        true,
        message,
      );
    } catch (e, stackTrace) {
      log(
        'ERROR AT deleteBankAccountInvest(): $e',
        stackTrace: stackTrace,
      );

      return ResponseModel(
        false,
        'Error while deleting bank account',
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void onClose() {
    bankNameController.dispose();
    accountHolderController.dispose();
    accountNumberController.dispose();
    confirmAccountNumberController.dispose();
    ifscController.dispose();

    super.onClose();
  }
}
