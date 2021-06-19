import 'package:http/http.dart' as http;
import 'package:traveling/src/models/client_model.dart';
import 'package:traveling/src/preferences/user_preferences.dart';

class ClientProvider {
  final String _url = 'http://192.168.43.21:8080';
  final _preferences = new UserPreferences();

  Future<bool> register(Client client) async {
    final url = '$_url/registrar-cliente/';
    print(client.nombres +
        client.apellidos +
        client.ci.toString() +
        client.fechaNacimiento +
        client.correoElectronico +
        client.sexo +
        client.contrasena);

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: clientToJson(client));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> login(Client client) async {
    final url = '$_url/';

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: clientToJson(client));

    if (response.statusCode == 200) {
      _preferences.token = response.body.replaceAll(new RegExp(r'"'), '');
      _preferences.lastPage = 'home';
      return true;
    }
    return false;
  }

  Future<bool> update(int id, Client client) async {
    final url = '$_url/';

    final response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '${_preferences.token}'
        },
        body: clientToJson(client));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> delete(int id) async {
    final url = '$_url/';

    final response = await http.delete(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '${_preferences.token}'
    });

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
