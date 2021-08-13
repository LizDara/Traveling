import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:traveling/src/models/acceptOffer_model.dart';
import 'package:traveling/src/models/confirmOffer_model.dart';
import 'package:traveling/src/models/flightOffer_model.dart';
import 'package:traveling/src/models/searchTicket_model.dart';
import 'package:traveling/src/models/ticketList_model.dart';
import 'package:traveling/src/providers/UserProvider.dart';
import 'package:traveling/src/providers/global.dart';

class TicketProvider {
  Future<List<TicketList>> searchTickets(SearchTicket searchTicket) async {
    final response = await http.post(
        Uri.parse('$baseUrl/obtener-vuelos-disponibles/'),
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

  Future<ConfirmOffer?> confirmTicket(FlightOffer flightOffer) async {
    final response = await http.post(
        Uri.parse('$baseUrl/confirmar-precio-vuelo/'),
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

  Future<bool> acceptTicket(
      AcceptOffer acceptOffer, BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final accessToken = await userProvider.readAccessToken();
    final response = await http.post(Uri.parse('$baseUrl/crear-reserva/'),
        headers: {'Authorization': 'Bearer ' + accessToken},
        body: acceptOfferToJson(acceptOffer));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
