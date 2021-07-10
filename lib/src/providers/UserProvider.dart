import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:traveling/src/models/user_model.dart';
import 'package:traveling/src/preferences/user_preferences.dart';

class UserProvider {
  final String _url = 'http://192.168.0.15:8080';
  final _preferences = new UserPreferences();

  Future<bool> login(User user) async {
    final url = '$_url/iniciar-sesion/';

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: userToJson(user));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _preferences.accessToken = data["access_token"];
      _preferences.refreshToken = data["refresh_token"];
      _preferences.lastPage = 'home';
      return true;
    }
    return false;
  }

  Future<bool> updatePassword(User user) async {
    final url = '$_url/cambiar-contrasena/';

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: userToJson(user));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> logout(User user) async {
    final url = '$_url/cerrar-sesion/';

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: userToJson(user));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
