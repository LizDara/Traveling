import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
  Client({
    this.ci,
    this.nombres,
    this.apellidos,
    this.telefono,
    this.fechaNacimiento,
    this.sexo,
    this.direccion,
    this.pasaporte,
    this.nit,
    this.nombreNit,
    this.correoElectronico,
    this.contrasena,
  });

  int ci;
  String nombres;
  String apellidos;
  int telefono;
  String fechaNacimiento;
  String sexo;
  String direccion;
  String pasaporte;
  int nit;
  String nombreNit;
  String correoElectronico;
  String contrasena;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        ci: json["ci"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        telefono: json["telefono"],
        fechaNacimiento: json["fecha_nacimiento"],
        sexo: json["sexo"],
        direccion: json["direccion"],
        pasaporte: json["pasaporte"],
        nit: json["nit"],
        nombreNit: json["nombre_nit"],
        correoElectronico: json["correo_electronico"],
        contrasena: json["contrasena"],
      );

  Map<String, dynamic> toJson() => {
        "ci": ci,
        "nombres": nombres,
        "apellidos": apellidos,
        "telefono": telefono,
        "fecha_nacimiento": fechaNacimiento,
        "sexo": sexo,
        "direccion": direccion,
        "pasaporte": pasaporte,
        "nit": nit,
        "nombre_nit": nombreNit,
        "correo_electronico": correoElectronico,
        "contrasena": contrasena,
      };
}
