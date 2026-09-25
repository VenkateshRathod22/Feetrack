import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/constants.dart';
import '../models/response/error_response.dart';

class InvestApiClient extends GetConnect implements GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;

  String token = '';

  Map<String, String> _mainHeaders = {};

  Map<String, String> getSponsorHeaders() {
    return {
      'Accept': 'application/json',
      'Sponsor': token,
    };
  }

  InvestApiClient({
    required this.appBaseUrl,
    required this.sharedPreferences,
  }) {
    try {
      baseUrl = appBaseUrl.endsWith('/') ? appBaseUrl : '$appBaseUrl/';

      timeout = const Duration(seconds: 30);

      // Investment app has its own token.
      token = sharedPreferences.getString(
            AppConstants.tokenInvest,
          ) ??
          '';

      _updateHeaders();

      if (kDebugMode) {
        log(
          'InvestApiClient initialized',
          name: 'INVEST_API',
        );
      }
    } catch (e) {
      log(
        e.toString(),
        name: 'ERROR AT InvestApiClient()',
      );
    }
  }

  // ============================================================
  // Headers
  // ============================================================

  void _updateHeaders() {
    _mainHeaders = {
      'Accept': 'application/json',
    };

    // Do NOT send Authorization when token is empty.
    if (token.isNotEmpty) {
      _mainHeaders['Authorization'] = 'Bearer $token';
    }
  }

  void updateHeader(String? newToken) {
    token = newToken ?? '';
    _updateHeaders();

    if (kDebugMode) {
      log(
        token.isEmpty ? 'Investment token cleared' : 'Investment token updated',
        name: 'INVEST_API',
      );
    }
  }

  void clearToken() {
    token = '';
    _updateHeaders();
  }

  Map<String, String> _getHeaders({
    Map<String, String>? headers,
    bool requiresAuth = true,
  }) {
    final Map<String, String> result = {
      ..._mainHeaders,
      ...?headers,
    };

    // Login or public API should not receive Authorization.
    if (!requiresAuth) {
      result.remove('Authorization');
    }

    return result;
  }

  // ============================================================
  // GET
  // ============================================================

  Future<Response> getData(
    String uri,
    String name, {
    Map<String, dynamic>? query,
    String? contentType,
    Map<String, String>? headers,
    Function(dynamic)? decoder,
    bool requiresAuth = true,
  }) async {
    try {
      final requestHeaders = _getHeaders(
        headers: headers,
        requiresAuth: requiresAuth,
      );

      if (kDebugMode) {
        log(
          'GET: $uri',
          name: name,
        );
      }

      Response response = await get(
        uri,
        query: query,
        contentType: contentType,
        headers: requestHeaders,
        decoder: decoder,
      );

      log(
        '[$name] GET ${response.statusCode} $uri',
        name: 'INVEST_API',
      );

      response = handleResponse(response);

      return response;
    } catch (e, stackTrace) {
      log(
        'GET Error: $e',
        name: 'InvestApiClient',
        error: e,
        stackTrace: stackTrace,
      );

      return Response(
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }

  // ============================================================
  // POST
  // ============================================================

  Future<Response> postData(
    String uri,
    String name,
    dynamic body, {
    Map<String, dynamic>? query,
    String? contentType,
    Map<String, String>? headers,
    Function(dynamic)? decoder,
    Function(double)? uploadProgress,
    bool requiresAuth = true,
  }) async {
    try {
      final requestHeaders = _getHeaders(
        headers: headers,
        requiresAuth: requiresAuth,
      );

      if (kDebugMode) {
        log(
          'POST: $uri',
          name: name,
        );
        log(
          'Request Body: $body',
          name: name,
        );
        log(
          'Authorization: ${requiresAuth && token.isNotEmpty ? '[PRESENT]' : '[NONE]'}',
          name: name,
        );
      }

      Response response = await post(
        uri,
        body,
        query: query,
        contentType: contentType,
        headers: requestHeaders,
        decoder: decoder,
        uploadProgress: uploadProgress,
      );

      if (kDebugMode) {
        log(
          'URL: ${response.request?.url}',
          name: name,
        );

        log(
          'Response: ${response.bodyString}',
          name: name,
        );
      }

      log(
        '[$name] POST ${response.statusCode} $uri',
        name: 'INVEST_API',
      );

      response = handleResponse(response);

      return response;
    } catch (e, stackTrace) {
      log(
        'POST Error: $e',
        name: 'InvestApiClient',
        error: e,
        stackTrace: stackTrace,
      );

      return Response(
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }

  // ============================================================
  // PUT
  // ============================================================

  Future<Response> putData(
    String uri,
    String name,
    dynamic body, {
    Map<String, dynamic>? query,
    String? contentType,
    Map<String, String>? headers,
    Function(dynamic)? decoder,
    Function(double)? uploadProgress,
    bool requiresAuth = true,
  }) async {
    try {
      final requestHeaders = _getHeaders(
        headers: headers,
        requiresAuth: requiresAuth,
      );

      Response response = await put(
        uri,
        body,
        query: query,
        contentType: contentType,
        headers: requestHeaders,
        decoder: decoder,
        uploadProgress: uploadProgress,
      );

      response = handleResponse(response);

      return response;
    } catch (e) {
      log(
        'PUT Error: $e',
        name: 'InvestApiClient',
      );

      return Response(
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }

  // ============================================================
  // PATCH
  // ============================================================

  Future<Response> patchData(
    String uri,
    String name,
    dynamic body, {
    Map<String, dynamic>? query,
    String? contentType,
    Map<String, String>? headers,
    Function(dynamic)? decoder,
    Function(double)? uploadProgress,
    bool requiresAuth = true,
  }) async {
    try {
      final requestHeaders = _getHeaders(
        headers: headers,
        requiresAuth: requiresAuth,
      );

      Response response = await patch(
        uri,
        body,
        query: query,
        contentType: contentType,
        headers: requestHeaders,
        decoder: decoder,
        uploadProgress: uploadProgress,
      );

      response = handleResponse(response);

      return response;
    } catch (e) {
      log(
        'PATCH Error: $e',
        name: 'InvestApiClient',
      );

      return Response(
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }

  // ============================================================
  // DELETE
  // ============================================================

  Future<Response> deleteData(
    String uri,
    String name, {
    Map<String, dynamic>? query,
    String? contentType,
    Map<String, String>? headers,
    Function(dynamic)? decoder,
    bool requiresAuth = true,
  }) async {
    try {
      final requestHeaders = _getHeaders(
        headers: headers,
        requiresAuth: requiresAuth,
      );

      Response response = await delete(
        uri,
        headers: requestHeaders,
        contentType: contentType,
        query: query,
        decoder: decoder,
      );

      response = handleResponse(response);

      return response;
    } catch (e) {
      log(
        'DELETE Error: $e',
        name: 'InvestApiClient',
      );

      return Response(
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }

  // ============================================================
  // Response Handler
  // ============================================================

  Response handleResponse(Response response) {
    Response result = response;

    if (result.hasError && result.body != null && result.body is! String) {
      if (result.body.toString().startsWith('{errors: [{code:')) {
        final ErrorResponse errorResponse = ErrorResponse.fromJson(result.body);

        result = Response(
          statusCode: result.statusCode,
          body: result.body,
          statusText: errorResponse.errors[0].message,
        );
      } else if (result.body.toString().startsWith('{message')) {
        result = Response(
          statusCode: result.statusCode,
          body: result.body,
          statusText: result.body['message'],
        );
      }
    } else if (result.hasError && result.body == null) {
      result = const Response(
        statusCode: 0,
        statusText:
            'Connection to API server failed due to internet connection',
      );
    }

    return result;
  }
}
