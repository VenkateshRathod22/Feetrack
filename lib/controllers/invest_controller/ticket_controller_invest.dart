import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import 'package:vlr/data/models/invest_model/ticket_model_invest.dart';
import 'package:vlr/data/models/response/response_model.dart';
import 'package:vlr/data/repositories/invest_repo/ticket_repo_invest.dart';

class TicketControllerInvest extends GetxController
    implements GetxService {
  final TicketRepoInvest ticketRepoInvest;

  TicketControllerInvest({
    required this.ticketRepoInvest,
  });

  bool isLoading = false;

  List<TicketModelInvest> ticketList = [];

  final TextEditingController subjectController =
      TextEditingController();

  final TextEditingController userMessageController =
      TextEditingController();

  // =========================================================
  // FETCH ALL TICKETS
  // =========================================================

  Future<ResponseModel> fetchTicketInvest() async {
    log('----------- fetchTicketInvest Called ----------');

    isLoading = true;
    update();

    try {
      final Response response =
          await ticketRepoInvest.fetchTicketInvest();

      log("Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        if (response.body is List) {
          final List<dynamic> responseList = response.body;

          ticketList = responseList
              .whereType<Map>()
              .map(
                (item) => TicketModelInvest.fromMap(
                  Map<String, dynamic>.from(item),
                ),
              )
              .toList();

          log(
            "Tickets loaded: ${ticketList.length}",
          );

          return ResponseModel(
            true,
            "Tickets fetched successfully",
            ticketList,
          );
        }

        ticketList = [];

        return ResponseModel(
          false,
          "Invalid ticket response",
        );
      }

      String errorMessage =
          "Unable to fetch tickets";

      if (response.body is Map &&
          response.body['message'] != null) {
        errorMessage =
            response.body['message'].toString();
      }

      return ResponseModel(
        false,
        errorMessage,
      );
    } catch (e, stackTrace) {
      log(
        'ERROR AT fetchTicketInvest(): $e',
        stackTrace: stackTrace,
      );

      ticketList = [];

      return ResponseModel(
        false,
        "Error while fetching tickets",
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  // =========================================================
  // ADD TICKET / COMPLAINT
  // =========================================================

  Future<ResponseModel> addComplainInvest() async {
    log('----------- addComplainInvest Called ----------');

    isLoading = true;
    update();

    try {
      final Map<String, dynamic> body = {
        'subject': subjectController.text.trim(),
        'usermsg': userMessageController.text.trim(),
      };

      log("Add Ticket Request Body: $body");

      final Response response =
          await ticketRepoInvest.addComplainInvest(
        body: body,
      );

      log("Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}");

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        String message =
            "Ticket submitted successfully";

        dynamic responseData;

        if (response.body is Map) {
          final Map<String, dynamic> responseBody =
              Map<String, dynamic>.from(response.body);

          message =
              responseBody['message']?.toString() ??
              responseBody['msg']?.toString() ??
              message;

          responseData =
              responseBody['data'];
        }

        clearAddTicketForm();

        return ResponseModel(
          true,
          message,
          responseData ?? response.body,
        );
      }

      String errorMessage =
          "Unable to submit ticket";

      if (response.body is Map &&
          response.body['message'] != null) {
        errorMessage =
            response.body['message'].toString();
      }

      return ResponseModel(
        false,
        errorMessage,
      );
    } catch (e, stackTrace) {
      log(
        'ERROR AT addComplainInvest(): $e',
        stackTrace: stackTrace,
      );

      return ResponseModel(
        false,
        "Error while submitting ticket",
      );
    } finally {
      isLoading = false;
      update();
    }
  }


  Future<void> refreshTickets() async {
    await fetchTicketInvest();
  }

  // =========================================================
  // CLEAR ADD TICKET FORM
  // =========================================================

  void clearAddTicketForm() {
    subjectController.clear();
    userMessageController.clear();
    update();
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void onClose() {
    subjectController.dispose();
    userMessageController.dispose();

    super.onClose();
  }
}