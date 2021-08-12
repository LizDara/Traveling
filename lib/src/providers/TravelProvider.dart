import 'package:http/http.dart' as http;
import 'package:traveling/src/models/reservationTravel_model.dart';
import 'package:traveling/src/preferences/user_preferences.dart';
import 'package:traveling/src/providers/global.dart';

class TravelProvider {
  final String _url = baseUrl;

  Future<List<ReservationTravel>> getTravels() async {
    final url = '$_url/listar-reservas/';
    final UserPreferences userPreferences = new UserPreferences();

    final response = await http.get(url,
        headers: {'Authorization': 'Bearer ' + userPreferences.accessToken});

    if (response.statusCode == 200) {
      final travels = reservationTravelFromJson(response.body);
      return travels;
    }
    return [];
  }
}
