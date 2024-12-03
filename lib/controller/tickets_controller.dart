import 'package:get/get.dart';
import 'package:turningpoint_tms/model/tickets_model.dart';
import 'package:turningpoint_tms/repository/tickets_repository.dart';

class TicketsController extends GetxController {
  final ticketsRepository = TicketsRepository();
  Rxn<List<TicketModel>> myTicketsListObs = Rxn<List<TicketModel>>();
  Rxn<Exception> ticketsException = Rxn<Exception>();

//====================Raise Ticket====================//
  Future<void> raiseTicket({
    required String title,
    required String description,
  }) async {
    try {
      await ticketsRepository.raiseTicket(
        title: title,
        description: description,
      );
    } catch (_) {
      rethrow;
    }
  }

//====================Get My Tickets====================//
  Future<void> getMyTickets() async {
    try {
      myTicketsListObs.value =
          (await ticketsRepository.getMyTickets())?.tickets;
      ticketsException.value = null;
    } catch (e) {
      ticketsException.value = e as Exception;
    }
  }
}
