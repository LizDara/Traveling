import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:traveling/src/models/reservationTravel_model.dart';
import 'package:traveling/src/providers/UserProvider.dart';
import 'package:traveling/src/providers/global.dart';

class TravelProvider {
  Future<List<ReservationTravel>> getTravels(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final accessToken = await userProvider.readAccessToken();
    final response = await http.get(Uri.parse('$baseUrl/listar-reservas/'),
        headers: {'Authorization': 'Bearer ' + accessToken});

    if (response.statusCode == 200) {
      final travels = reservationTravelFromJson(response.body);
      return travels;
    }
    return [];
  }
}
