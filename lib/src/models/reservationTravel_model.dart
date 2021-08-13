import 'dart:convert';

import 'package:traveling/src/models/itinerary_model.dart';

List<ReservationTravel> reservationTravelFromJson(String str) =>
    List<ReservationTravel>.from(
        json.decode(str).map((x) => ReservationTravel.fromJson(x)));

String reservationTravelToJson(List<ReservationTravel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReservationTravel {
  ReservationTravel({
    this.id,
    this.fecha,
    this.precio,
    this.itinerarios,
  });

  String? id;
  String? fecha;
  String? precio;
  List<Itinerary>? itinerarios;

  factory ReservationTravel.fromJson(Map<String, dynamic> json) =>
      ReservationTravel(
        id: json["id"],
        fecha: json["fecha"],
        precio: json["precio"],
        itinerarios: json["itinerarios"] == null
            ? null
            : List<Itinerary>.from(
                json["itinerarios"].map((x) => Itinerary.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fecha": fecha,
        "precio": precio,
        "itinerarios": itinerarios == null
            ? null
            : List<dynamic>.from(itinerarios!.map((x) => x.toJson())),
      };
}
