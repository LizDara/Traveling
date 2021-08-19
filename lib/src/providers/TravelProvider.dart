import 'dart:convert';

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
    print('TOKEN: ' + accessToken);
    final response = await http.get(Uri.parse('$baseUrl/listar-reservas/'),
        headers: {'Authorization': 'Bearer ' + accessToken});

    print(response.body);
    if (response.statusCode == 200) {
      final travels = reservationTravelFromJson(response.body);
      return travels;
    }
    return [];
  }

  Future<bool> deleteTravel(String id) async {
    final travel = {"id": id};
    final response = await http.post(Uri.parse('$baseUrl/eliminar-reserva/'),
        body: json.encode(travel));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
