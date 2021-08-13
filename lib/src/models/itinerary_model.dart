import 'dart:convert';

Itinerary itineraryFromJson(String str) => Itinerary.fromJson(json.decode(str));

String itineraryToJson(Itinerary data) => json.encode(data.toJson());

class Itinerary {
  Itinerary({
    this.id,
    this.duracion,
    this.reservaId,
    this.lugarSalida,
    this.lugarLlegada,
    this.salidaIataCodigo,
    this.llegadaIataCodigo,
    this.fechaSalida,
    this.fechaLlegada,
  });

  String? id;
  String? duracion;
  String? reservaId;
  String? lugarSalida;
  String? lugarLlegada;
  String? salidaIataCodigo;
  String? llegadaIataCodigo;
  String? fechaSalida;
  String? fechaLlegada;

  factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
        id: json["id"],
        duracion: json["duracion"],
        reservaId: json["reserva_id"],
        lugarSalida: json["lugar_salida"],
        lugarLlegada: json["lugar_llegada"],
        salidaIataCodigo: json["salida_iata_codigo"],
        llegadaIataCodigo: json["llegada_iata_codigo"],
        fechaSalida: json["fecha_salida"],
        fechaLlegada: json["fecha_llegada"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "duracion": duracion,
        "reserva_id": reservaId,
        "lugar_salida": lugarSalida,
        "lugar_llegada": lugarLlegada,
        "salida_iata_codigo": salidaIataCodigo,
        "llegada_iata_codigo": llegadaIataCodigo,
        "fecha_salida": fechaSalida,
        "fecha_llegada": fechaLlegada,
      };
}
