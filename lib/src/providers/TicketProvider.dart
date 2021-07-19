import 'package:http/http.dart' as http;
import 'package:traveling/src/models/searchTicket_model.dart';
import 'package:traveling/src/models/ticketList_model.dart';
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

    print(response.body);

    if (response.statusCode == 200) {
      final ticketList = ticketListFromJson(response.body);
      return ticketList;
    }
    return [];
  }
}
