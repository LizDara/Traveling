import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.personaId,
    this.correoElectronico,
    this.contrasena,
    this.accessToken,
    this.refreshToken,
  });

  int? personaId;
  String? correoElectronico;
  String? contrasena;
  String? accessToken;
  String? refreshToken;

  factory User.fromJson(Map<String, dynamic> json) => User(
        personaId: json["persona_id"],
        correoElectronico: json["correo_electronico"],
        contrasena: json["contrasena"],
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "persona_id": personaId,
        "correo_electronico": correoElectronico,
        "contrasena": contrasena,
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };
}
