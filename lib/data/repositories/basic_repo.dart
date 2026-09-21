import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlr/data/api/api_client.dart';
import 'package:vlr/services/constants.dart';

class BasicRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  const BasicRepo({required this.sharedPreferences, required this.apiClient});

  Future<Response> fetchListingReviewsById({
    required String? id,
  }) async =>
      await apiClient.getData(
        AppConstants.getReviews(id: id),
        "fetchListingReviewsById",
      );

  Future<Response> submitReviewsById({
    required String? id,
    required Map<String, dynamic> data,
  }) async =>
      await apiClient.postData(
        AppConstants.putSubmitReviews(id: id),
        "submitReviewsById",
        data,
      );

  Future<Response> postFetchStatus() async {
    return await apiClient.postData(
        AppConstants.postStatus,
        "postFetchStatus",
        FormData({
          "api_token": sharedPreferences.getString(AppConstants.apiToken),
        } as Map<String, dynamic>));
  }

  Future<Response> fetchDistrictByState({required int? statusId}) async {
    return await apiClient.postData(
        AppConstants.postDistrictByState,
        "postFetchStatus",
        FormData({
          'state_id': statusId,
          "api_token": sharedPreferences.getString(AppConstants.apiToken),
        } as Map<String, dynamic>));
  }
}
