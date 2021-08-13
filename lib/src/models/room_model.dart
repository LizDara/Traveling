import 'dart:convert';

Room roomFromJson(String str) => Room.fromJson(json.decode(str));

String roomToJson(Room data) => json.encode(data.toJson());

class Room {
  Room({
    this.id,
    this.tipo,
    this.camas,
    this.tipoCama,
  });

  int? id;
  String? tipo;
  int? camas;
  String? tipoCama;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["id"],
        tipo: json["tipo"],
        camas: json["camas"],
        tipoCama: json["tipo_cama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "camas": camas,
        "tipo_cama": tipoCama,
      };
}
