import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.personaId,
    this.correoElectronico,
    this.contrasena,
  });

  int personaId;
  String correoElectronico;
  String contrasena;

  factory User.fromJson(Map<String, dynamic> json) => User(
        personaId: json["persona_id"],
        correoElectronico: json["correo_electronico"],
        contrasena: json["contrasena"],
      );

  Map<String, dynamic> toJson() => {
        "persona_id": personaId,
        "correo_electronico": correoElectronico,
        "contrasena": contrasena,
      };
}
