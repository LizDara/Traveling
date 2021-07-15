import 'package:http/http.dart' as http;
import 'package:traveling/src/models/client_model.dart';
import 'package:traveling/src/models/user_model.dart';
import 'package:traveling/src/providers/global.dart';

class ClientProvider {
  final String _url = baseUrl;

  Future<bool> register(Client client) async {
    final url = '$_url/registrar-cliente/';

    final response = await http.post(url,
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
    final url = '$_url/obtener-cliente/';

    final response = await http.post(url,
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
    final url = '$_url/modificar-cliente/';

    print(clientToJson(client));
    final response = await http.post(url,
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

  Future<bool> delete(int id) async {
    final url = '$_url/';

    final response = await http.delete(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
