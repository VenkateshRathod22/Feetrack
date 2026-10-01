import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vlr/data/models/invest_model/user_model_invest.dart';
import 'package:vlr/data/models/response/response_model.dart';
import 'package:vlr/data/repositories/invest_repo/auth_repo_invest.dart';
import 'package:vlr/services/constants.dart';
import 'package:path/path.dart' as path;
import 'package:vlr/views/wealth_grow_app/investment_app.dart';

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

  File? selectedProfileImage;

  final TextEditingController nameController = TextEditingController();

  Future<void> selectProfileImage() async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile == null) {
        return;
      }

      selectedProfileImage = File(pickedFile.path);

      update();
    } catch (e, stackTrace) {
      log(
        "ERROR AT selectProfileImage(): $e",
        stackTrace: stackTrace,
      );
    }
  }

  Future<ResponseModel> updateProfileInvest() async {
    log(
      '----------- updateProfileInvest Called ----------',
    );

    if (isLoading) {
      return ResponseModel(
        false,
        "Profile update already in progress",
      );
    }

    isLoading = true;
    update();

    try {
      final Map<String, dynamic> data = {
        "name": nameController.text.trim(),
      };

      // Add profile image only if user selected a new image
      if (selectedProfileImage != null) {
        final File file = selectedProfileImage!;

        final List<int> bytes = await file.readAsBytes();

        data["profile"] = MultipartFile(
          bytes,
          filename: path.basename(file.path),
        );
      }

      final FormData formData = FormData(data);

      log(
        "Update Profile Data: "
        "name=${nameController.text.trim()}, "
        "profile=${selectedProfileImage?.path}",
      );

      final Response response = await authRepoInvest.updateProfileInvest(
        formData: formData,
      );

      log(
        "Status Code: ${response.statusCode}",
      );

      log(
        "Response Body: ${response.body}",
      );

      if (response.statusCode != 200) {
        String errorMessage = "Unable to update profile";

        if (response.body is Map && response.body['message'] != null) {
          errorMessage = response.body['message'].toString();
        }

        return ResponseModel(
          false,
          errorMessage,
        );
      }

      String successMessage = "Profile updated successfully";

      if (response.body is Map && response.body['message'] != null) {
        successMessage = response.body['message'].toString();
      }

      // Clear selected image after successful update
      selectedProfileImage = null;

      return ResponseModel(
        true,
        successMessage,
        userModelInvest,
      );
    } catch (e, stackTrace) {
      log(
        'ERROR AT updateProfileInvest(): $e',
        stackTrace: stackTrace,
      );

      return ResponseModel(
        false,
        'Error while updating profile',
      );
    } finally {
      isLoading = false;
      update();
    }
  }

//* ---- send opt ----

  Future<ResponseModel> sendOtpInvest() async {
    log(
      '----------- sendOtpInvest Called ----------',
    );

    isLoading = true;
    update();

    try {
      final Map<String, dynamic> data = {
        "username": userIdFormat,
      };

      final Response response = await authRepoInvest.sendOtpInvest(
        data: data,
      );

      log(
        "sendOtpInvest Status Code: ${response.statusCode}",
      );

      log(
        "sendOtpInvest Response Body: ${response.body}",
      );

      if (response.statusCode != 200) {
        String errorMessage = "Unable to send OTP";

        if (response.body is Map && response.body['message'] != null) {
          errorMessage = response.body['message'].toString();
        }

        return ResponseModel(
          false,
          errorMessage,
        );
      }

      String successMessage = "OTP sent successfully";

      if (response.body is Map && response.body['message'] != null) {
        successMessage = response.body['message'].toString();
      }

      return ResponseModel(
        true,
        successMessage,
        response.body,
      );
    } catch (e, stackTrace) {
      log(
        'ERROR AT sendOtpInvest(): $e',
        stackTrace: stackTrace,
      );

      return ResponseModel(
        false,
        "Error while sending OTP",
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  final TextEditingController otpController = TextEditingController();

//* -------- resetPasswordInvest---------
  Future<ResponseModel> resetPasswordInvest() async {
    log(
      '----------- resetPasswordInvest Called ----------',
    );

    isLoading = true;
    update();
    try {
      final Response response = await authRepoInvest.resetPasswordInvest(
        username: userIdFormat ?? "",
        otp: otpController.text.trim(),
        password: passwordController.text.trim(),
      );

      log(
        "Reset Password Status Code: "
        "${response.statusCode}",
      );

      log(
        "Reset Password Response Body: "
        "${response.body}",
      );

      if (response.statusCode != 200) {
        String errorMessage = "Unable to Reset password";

        if (response.body is Map && response.body['message'] != null) {
          errorMessage = response.body['message'].toString();
        }

        return ResponseModel(
          false,
          errorMessage,
        );
      }

      // Check API's own status field
      if (response.body is Map) {
        final Map<String, dynamic> body =
            Map<String, dynamic>.from(response.body);

        final bool apiStatus = body['status'] == true;

        final String message = body['message']?.toString() ??
            (apiStatus
                ? "Password updated successfully"
                : "Unable to reset password");

        if (!apiStatus) {
          return ResponseModel(
            false,
            message,
            body,
          );
        }

        return ResponseModel(
          true,
          message,
          body,
        );
      }

      return ResponseModel(
        false,
        "Invalid Reset password response",
      );
    } catch (e, stackTrace) {
      log(
        'ERROR AT resetPasswordInvest(): $e',
        stackTrace: stackTrace,
      );

      return ResponseModel(
        false,
        "Error while resetting password",
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  String? userIdFormat;

  void updateUserIdFormat({required String pre}) {
    userIdFormat = "$pre${userModelInvest?.sponsorCode ?? ""}";
    update();
  }

  void logout({required BuildContext context}) {
    clearSharedData();
    Navigator.of(context).pushReplacementNamed(
      InvestmentApp.login,
    );
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
    nameController.dispose();
    otpController.dispose();
    super.onClose();
  }
}
