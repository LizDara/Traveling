import 'dart:convert';

List<Promotion> promotionFromJson(String str) =>
    List<Promotion>.from(json.decode(str).map((x) => Promotion.fromJson(x)));

String promotionToJson(List<Promotion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Promotion {
  Promotion({
    this.id,
    this.fechaInicio,
    this.fechaFin,
    this.descuento,
    this.salida,
    this.salidaIataCodigo,
    this.llegada,
    this.llegadaIataCodigo,
    this.salidaIsoCodigo,
    this.llegadaIsoCodigo,
  });

  int id;
  String fechaInicio;
  String fechaFin;
  int descuento;
  String salida;
  String salidaIataCodigo;
  String llegada;
  String llegadaIataCodigo;
  String salidaIsoCodigo;
  String llegadaIsoCodigo;

  factory Promotion.fromJson(Map<String, dynamic> json) => Promotion(
        id: json["id"],
        fechaInicio: json["fecha_inicio"],
        fechaFin: json["fecha_fin"],
        descuento: json["descuento"],
        salida: json["salida"],
        salidaIataCodigo: json["salida_iata_codigo"],
        llegada: json["llegada"],
        llegadaIataCodigo: json["llegada_iata_codigo"],
        salidaIsoCodigo: json["salida_iso_codigo"],
        llegadaIsoCodigo: json["llegada_iso_codigo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fecha_inicio": fechaInicio,
        "fecha_fin": fechaFin,
        "descuento": descuento,
        "salida": salida,
        "salida_iata_codigo": salidaIataCodigo,
        "llegada": llegada,
        "llegada_iata_codigo": llegadaIataCodigo,
        "salida_iso_codigo": salidaIsoCodigo,
        "llegada_iso_codigo": llegadaIsoCodigo,
      };
}
