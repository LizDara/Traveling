import 'dart:convert';

ReservationHotel reservationHotelFromJson(String str) =>
    ReservationHotel.fromJson(json.decode(str));

String reservationHotelToJson(ReservationHotel data) =>
    json.encode(data.toJson());

class ReservationHotel {
  ReservationHotel({
    this.id,
    this.nombreHotel,
    this.direccionHotel,
    this.telefonoHotel,
    this.fechaIngreso,
    this.fechaSalida,
    this.precio,
    this.itinerarioId,
  });

  int? id;
  String? nombreHotel;
  String? direccionHotel;
  String? telefonoHotel;
  String? fechaIngreso;
  String? fechaSalida;
  double? precio;
  int? itinerarioId;

  factory ReservationHotel.fromJson(Map<String, dynamic> json) =>
      ReservationHotel(
        id: json["id"],
        nombreHotel: json["nombre_hotel"],
        direccionHotel: json["direccion_hotel"],
        telefonoHotel: json["telefono_hotel"],
        fechaIngreso: json["fecha_ingreso"],
        fechaSalida: json["fecha_salida"],
        precio: json["precio"].toDouble(),
        itinerarioId: json["itinerario_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre_hotel": nombreHotel,
        "direccion_hotel": direccionHotel,
        "telefono_hotel": telefonoHotel,
        "fecha_ingreso": fechaIngreso,
        "fecha_salida": fechaSalida,
        "precio": precio,
        "itinerario_id": itinerarioId,
      };
}
