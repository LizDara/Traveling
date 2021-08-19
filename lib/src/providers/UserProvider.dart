import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:traveling/src/models/user_model.dart';
import 'package:traveling/src/providers/global.dart';

class UserProvider extends ChangeNotifier {
  final storage = FlutterSecureStorage();

  Future<bool> login(User user) async {
    final response = await http.post(Uri.parse('$baseUrl/iniciar-sesion/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: userToJson(user));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      await storage.write(key: 'access_token', value: data["access_token"]);
      await storage.write(key: 'refresh_token', value: data["refresh_token"]);
      return true;
    }
    return false;
  }

  Future<bool> updatePassword(User user) async {
    final response = await http.post(Uri.parse('$baseUrl/cambiar-contrasena/'),
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
    final response = await http.post(Uri.parse('$baseUrl/cerrar-sesion/'),
        headers: {'Content-Type': 'application/json'}, body: userToJson(user));

    if (response.statusCode == 200) {
      await storage.deleteAll();
      return true;
    }
    return false;
  }

  Future clearTokens() async {
    return await storage.deleteAll();
  }

  Future<String> readAccessToken() async {
    return await storage.read(key: 'access_token') ?? '';
  }

  Future<String> readRefreshToken() async {
    return await storage.read(key: 'refresh_token') ?? '';
  }

  Future<List<String>> readToken() async {
    String accessToken = await storage.read(key: 'access_token') ?? '';
    String refreshToken = await storage.read(key: 'refresh_token') ?? '';
    return [accessToken, refreshToken];
  }

  Future<bool> existToken() async {
    final accessToken = await storage.read(key: 'access_token') ?? '';
    final refreshToken = await storage.read(key: 'refresh_token') ?? '';
    return (accessToken != '' && refreshToken != '');
  }
}
