import 'package:get/get_connect/http/src/response/response.dart';
import 'package:vlr/data/api/invest_api_client.dart';
import 'package:vlr/services/constants.dart';

class TicketRepoInvest {

   final InvestApiClient investApiClient;

  TicketRepoInvest({required this.investApiClient});


  Future<Response> fetchTicketInvest() async {
    return await investApiClient.getData(
      AppConstants.fetchTicketInvest,
      "fetchTicketInvest",
      contentType: 'application/json',
      requiresAuth: false,
      headers: investApiClient.getSponsorHeaders(),
    );
  }

  Future<Response> addComplainInvest({
    required Map<String, dynamic> body,
  }) async {
    return await investApiClient.postData(
      AppConstants.addComplainInvest,
      "addComplainInvest",
      body,
      contentType: 'application/json',
      requiresAuth: true,
      headers: investApiClient.getSponsorHeaders(),
    );
  }

  
}