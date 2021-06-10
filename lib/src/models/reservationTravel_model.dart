import 'dart:convert';

ReservationTravel reservationTravelFromJson(String str) =>
    ReservationTravel.fromJson(json.decode(str));

String reservationTravelToJson(ReservationTravel data) =>
    json.encode(data.toJson());

class ReservationTravel {
  ReservationTravel({
    this.id,
    this.fecha,
  });

  int id;
  String fecha;

  factory ReservationTravel.fromJson(Map<String, dynamic> json) =>
      ReservationTravel(
        id: json["id"],
        fecha: json["fecha"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fecha": fecha,
      };
}
