import 'dart:convert';

Segment segmentFromJson(String str) => Segment.fromJson(json.decode(str));

String segmentToJson(Segment data) => json.encode(data.toJson());

class Segment {
  Segment({
    this.id,
    this.salidaIataCodigo,
    this.salidaHora,
    this.llegadaIataCodigo,
    this.llegadaTerminal,
    this.llegadaHora,
    this.codigoAerolinea,
    this.duracion,
    this.codigoVuelo,
    this.itinerarioId,
  });

  int id;
  String salidaIataCodigo;
  String salidaHora;
  String llegadaIataCodigo;
  String llegadaTerminal;
  String llegadaHora;
  String codigoAerolinea;
  String duracion;
  String codigoVuelo;
  int itinerarioId;

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
        id: json["id"],
        salidaIataCodigo: json["salida_iata_codigo"],
        salidaHora: json["salida_hora"],
        llegadaIataCodigo: json["llegada_iata_codigo"],
        llegadaTerminal: json["llegada_terminal"],
        llegadaHora: json["llegada_hora"],
        codigoAerolinea: json["codigo_aerolinea"],
        duracion: json["duracion"],
        codigoVuelo: json["codigo_vuelo"],
        itinerarioId: json["itinerario_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "salida_iata_codigo": salidaIataCodigo,
        "salida_hora": salidaHora,
        "llegada_iata_codigo": llegadaIataCodigo,
        "llegada_terminal": llegadaTerminal,
        "llegada_hora": llegadaHora,
        "codigo_aerolinea": codigoAerolinea,
        "duracion": duracion,
        "codigo_vuelo": codigoVuelo,
        "itinerario_id": itinerarioId,
      };
}
