import 'package:http/http.dart' as http;
import 'package:traveling/src/models/client_model.dart';
import 'package:traveling/src/models/user_model.dart';
import 'package:traveling/src/providers/global.dart';

class ClientProvider {
  Future<bool> register(Client client) async {
    final response = await http.post(Uri.http(baseUrl, '/registrar-cliente/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: clientToJson(client));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<Client> getClient(User user) async {
    final response = await http.post(Uri.parse('$baseUrl/obtener-cliente/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: userToJson(user));

    Client client = new Client();
    print(response.body);
    if (response.statusCode == 200) {
      client = clientFromJson(response.body);
    }
    return client;
  }

  Future<bool> update(Client client) async {
    final response = await http.post(Uri.parse('$baseUrl/modificar-cliente/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: clientToJson(client));

    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
