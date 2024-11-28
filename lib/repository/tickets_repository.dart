import 'package:turningpoint_tms/model/tickets_model.dart';
import 'package:turningpoint_tms/service/api/api_endpoints.dart';
import 'package:turningpoint_tms/service/api/api_service.dart';

class TicketsRepository {
//====================Raise Ticket====================//
  Future<void> raiseTicket({
    required String title,
    required String description,
  }) async {
    try {
      await ApiService().sendRequest(
        url: ApiEndpoints.tickets,
        requestMethod: RequestMethod.POST,
        data: {
          'title': title,
          'description': description,
        },
        fieldNameForFiles: null,
        isTokenRequired: true,
      );
    } catch (_) {
      rethrow;
    }
  }

//====================Get My Tickets====================//
  Future<TicketsModelResponse?> getMyTickets() async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.tickets,
        requestMethod: RequestMethod.GET,
        data: {},
        fieldNameForFiles: null,
        isTokenRequired: true,
      );
      return TicketsModelResponse.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }
}
