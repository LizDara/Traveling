import 'dart:convert';

Itinerary itineraryFromJson(String str) => Itinerary.fromJson(json.decode(str));

String itineraryToJson(Itinerary data) => json.encode(data.toJson());

class Itinerary {
  Itinerary({
    this.id,
    this.duracion,
    this.reservaViajeId,
  });

  int id;
  String duracion;
  int reservaViajeId;

  factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
        id: json["id"],
        duracion: json["duracion"],
        reservaViajeId: json["reserva_viaje_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "duracion": duracion,
        "reserva_viaje_id": reservaViajeId,
      };
}
