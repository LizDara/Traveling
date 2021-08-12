import 'package:http/http.dart' as http;
import 'package:traveling/src/models/acceptOffer_model.dart';
import 'package:traveling/src/models/confirmOffer_model.dart';
import 'package:traveling/src/models/flightOffer_model.dart';
import 'package:traveling/src/models/searchTicket_model.dart';
import 'package:traveling/src/models/ticketList_model.dart';
import 'package:traveling/src/preferences/user_preferences.dart';
import 'package:traveling/src/providers/global.dart';

class TicketProvider {
  final String _url = baseUrl;

  Future<List<TicketList>> searchTickets(SearchTicket searchTicket) async {
    final url = '$_url/obtener-vuelos-disponibles/';

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: searchTicketToJson(searchTicket));

    if (response.statusCode == 200) {
      final ticketList = ticketListFromJson(response.body);
      return ticketList;
    }
    return [];
  }

  Future<ConfirmOffer> confirmTicket(FlightOffer flightOffer) async {
    final url = '$_url/confirmar-precio-vuelo/';

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: flightOfferToJson(flightOffer));

    if (response.statusCode == 200) {
      final offer = confirmOfferFromJson(response.body);
      return offer;
    }
    return null;
  }

  Future<bool> acceptTicket(AcceptOffer acceptOffer) async {
    final url = '$_url/crear-reserva/';
    final UserPreferences userPreferences = new UserPreferences();

    final response = await http.post(url,
        headers: {'Authorization': 'Bearer ' + userPreferences.accessToken},
        body: acceptOfferToJson(acceptOffer));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
