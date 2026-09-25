import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/data/models/invest_model/user_model_invest.dart';
import 'package:vlr/data/models/response/response_model.dart';
import 'package:vlr/data/repositories/invest_repo/auth_repo_invest.dart';
import 'package:vlr/services/constants.dart';

class AuthControllerInvest extends GetxController implements GetxService {
  final AuthRepoInvest authRepoInvest;

  AuthControllerInvest({
    required this.authRepoInvest,
  });

  bool isLoading = false;
  bool _acceptTerms = true;

  bool get acceptTerms => _acceptTerms;

  final TextEditingController userIdController =
      TextEditingController(text: "WG1290");
  final TextEditingController passwordController =
      TextEditingController(text: "123");

  Future<ResponseModel> loginInvest() async {
    log('----------- loginInvest Called ----------');

    isLoading = true;
    update();

    try {
      // Request data
      final Map<String, dynamic> data = {
        "userid": userIdController.text.trim(),
        "password": passwordController.text.trim(),
      };

      log("Login request: $data");

      final Response response = await authRepoInvest.postLoginInvest(
        data: data,
      );

      log("Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}");

      // HTTP success
      if (response.statusCode == 200) {
        final dynamic responseBody = response.body;

        // Make sure response is a Map
        if (responseBody is Map) {
          final Map<String, dynamic> body =
              Map<String, dynamic>.from(responseBody);

          final bool status = body['status'] == true;

          // =========================
          // LOGIN SUCCESS
          // =========================
          if (status) {
            final String? sponsorCode = body['sponsor_code']?.toString();

            final Map<String, dynamic>? user = body['user'] is Map
                ? Map<String, dynamic>.from(body['user'])
                : null;

            // Save token
            if (sponsorCode != null && sponsorCode.isNotEmpty) {
              await authRepoInvest.setUserToken(sponsorCode);

              log("Saved token: $sponsorCode");
            }

            // Optional: save user ID
            if (user != null) {
              final String? signupId = user['signup_id']?.toString();

              if (signupId != null && signupId.isNotEmpty) {
                await authRepoInvest.sharedPreferences.setString(
                  AppConstants.userId,
                  signupId,
                );

                log("Saved user ID: $signupId");
              }
            }

            // Clear text fields after successful login
            userIdController.clear();
            passwordController.clear();

            return ResponseModel(
              true,
              "Login successful",
              user,
            );
          }

          // =========================
          // LOGIN FAILED
          // =========================
          final String message =
              body['message']?.toString().trim().isNotEmpty == true
                  ? body['message'].toString()
                  : "Invalid credentials";

          log("Login failed: $message");

          return ResponseModel(
            false,
            message,
          );
        }

        return ResponseModel(
          false,
          "Invalid server response",
        );
      }

      // =========================
      // HTTP ERROR
      // =========================
      String errorMessage = "Unable to login. Please try again.";

      if (response.body is Map) {
        final Map<String, dynamic> body =
            Map<String, dynamic>.from(response.body);

        if (body['message'] != null) {
          errorMessage = body['message'].toString();
        }
      }

      return ResponseModel(
        false,
        errorMessage,
      );
    } catch (e, stackTrace) {
      log(
        'ERROR AT loginInvest(): $e',
        stackTrace: stackTrace,
      );

      return ResponseModel(
        false,
        "Something went wrong. Please try again.",
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  UserModelInvest? userModelInvest;

  Future<ResponseModel> fetchProfileInvest() async {
    log('----------- fetchProfileInvest Called ----------');

    isLoading = true;
    update();

    try {
      final Response response = await authRepoInvest.fetchProfileInvest();

      log('Status Code: ${response.statusCode}');

      if (response.statusCode == 200 && response.body is Map) {
        final Map<String, dynamic> body =
            Map<String, dynamic>.from(response.body);

        final String status = body['status']?.toString() ?? '';

        if (status == '1') {
          userModelInvest = UserModelInvest.fromJson(body);

          log(
            'Profile loaded: ${userModelInvest?.name}',
          );

          return ResponseModel(
            true,
            'Profile fetched successfully',
            userModelInvest,
          );
        }

        return ResponseModel(
          false,
          body['message']?.toString() ?? 'Unable to fetch profile',
        );
      }

      String message = 'Unable to fetch profile';

      if (response.body is Map && response.body['message'] != null) {
        message = response.body['message'].toString();
      }

      return ResponseModel(
        false,
        message,
      );
    } catch (e, stackTrace) {
      log(
        'ERROR AT fetchProfileInvest(): $e',
        stackTrace: stackTrace,
      );

      return ResponseModel(
        false,
        'Error while fetching profile',
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  bool isLoggedIn() {
    return authRepoInvest.isLoggedIn();
  }

  bool clearSharedData() {
    return authRepoInvest.clearSharedData();
  }

  String getUserToken() {
    return authRepoInvest.getUserToken();
  }

  @override
  void onClose() {
    userIdController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
