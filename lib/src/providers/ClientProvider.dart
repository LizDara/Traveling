import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:traveling/src/models/client_model.dart';
import 'package:traveling/src/models/user_model.dart';

class ClientProvider {
  final String _url = 'http://192.168.0.15:8080';

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

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      Client client = new Client();
      client.ci = data["ci"];
      client.nombres = data["nombres"];
      client.apellidos = data["apellidos"];
      client.telefono = data["telefono"];
      client.fechaNacimiento = data["fecha_nacimiento"];
      client.sexo = data["sexo"];
      client.direccion = data["direccion"];
      client.correoElectronico = data["correo_electronico"];
      client.pasaporte = data["pasaporte"];
      client.nit = data["nit"];
      client.nombreNit = data["nombre_nit"];
      return client;
    }
    return null;
  }

  Future<bool> update(Client client) async {
    final url = '$_url/modificar-cliente/';

    final response = await http.put(url,
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
