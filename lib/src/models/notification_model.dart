import 'dart:convert';

class Notify {
  Notify({
    this.fechaSalida,
    this.fechaLlegada,
    this.salidaIsoCodigo,
    this.llegadaIsoCodigo,
    this.idaVuelta,
    this.numeroViajeros,
    this.segmentoId,
    this.segmentoSalidaIataCodigo,
    this.segmentoSalidaHora,
    this.segmentoLlegadaIataCodigo,
    this.segmentoLlegadaHora,
    this.segmentoCodigoAerolinea,
    this.segmentoDuracion,
    this.segmentoCodigoVuelo,
    this.segmentoCodigoAvion,
    this.menos30Minutos,
    this.entre30Y60Minutos,
    this.entre60MinutosY120Minutos,
    this.mas60MinutosOCancelado,
    this.reservaId,
    this.lugarSalida,
    this.lugarLlegada,
  });

  String? fechaSalida;
  String? fechaLlegada;
  String? salidaIsoCodigo;
  String? llegadaIsoCodigo;
  bool? idaVuelta;
  int? numeroViajeros;
  String? segmentoId;
  String? segmentoSalidaIataCodigo;
  String? segmentoSalidaHora;
  String? segmentoLlegadaIataCodigo;
  String? segmentoLlegadaHora;
  String? segmentoCodigoAerolinea;
  String? segmentoDuracion;
  String? segmentoCodigoVuelo;
  String? segmentoCodigoAvion;
  String? menos30Minutos;
  String? entre30Y60Minutos;
  String? entre60MinutosY120Minutos;
  String? mas60MinutosOCancelado;
  String? reservaId;
  String? lugarSalida;
  String? lugarLlegada;

  factory Notify.fromRawJson(String str) => Notify.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Notify.fromJson(Map<String, dynamic> json) => Notify(
        fechaSalida: json["fecha_salida"],
        fechaLlegada: json["fecha_llegada"],
        salidaIsoCodigo: json["salida_iso_codigo"],
        llegadaIsoCodigo: json["llegada_iso_codigo"],
        idaVuelta: json["ida_vuelta"],
        numeroViajeros: json["numero_viajeros"],
        segmentoId: json["segmento_id"],
        segmentoSalidaIataCodigo: json["segmento_salida_iata_codigo"],
        segmentoSalidaHora: json["segmento_salida_hora"],
        segmentoLlegadaIataCodigo: json["segmento_llegada_iata_codigo"],
        segmentoLlegadaHora: json["segmento_llegada_hora"],
        segmentoCodigoAerolinea: json["segmento_codigo_aerolinea"],
        segmentoDuracion: json["segmento_duracion"],
        segmentoCodigoVuelo: json["segmento_codigo_vuelo"],
        segmentoCodigoAvion: json["segmento_codigo_avion"],
        menos30Minutos: json["menos_30_minutos"],
        entre30Y60Minutos: json["entre_30_y_60_minutos"],
        entre60MinutosY120Minutos: json["entre_60_minutos_y_120_minutos"],
        mas60MinutosOCancelado: json["mas_60_minutos_o_cancelado"],
        reservaId: json["reserva_id"],
        lugarSalida: json["lugar_salida"],
        lugarLlegada: json["lugar_llegada"],
      );

  Map<String, dynamic> toJson() => {
        "fecha_salida": fechaSalida,
        "fecha_llegada": fechaLlegada,
        "salida_iso_codigo": salidaIsoCodigo,
        "llegada_iso_codigo": llegadaIsoCodigo,
        "ida_vuelta": idaVuelta,
        "numero_viajeros": numeroViajeros,
        "segmento_id": segmentoId,
        "segmento_salida_iata_codigo": segmentoSalidaIataCodigo,
        "segmento_salida_hora": segmentoSalidaHora,
        "segmento_llegada_iata_codigo": segmentoLlegadaIataCodigo,
        "segmento_llegada_hora": segmentoLlegadaHora,
        "segmento_codigo_aerolinea": segmentoCodigoAerolinea,
        "segmento_duracion": segmentoDuracion,
        "segmento_codigo_vuelo": segmentoCodigoVuelo,
        "segmento_codigo_avion": segmentoCodigoAvion,
        "menos_30_minutos": menos30Minutos,
        "entre_30_y_60_minutos": entre30Y60Minutos,
        "entre_60_minutos_y_120_minutos": entre60MinutosY120Minutos,
        "mas_60_minutos_o_cancelado": mas60MinutosOCancelado,
        "reserva_id": reservaId,
        "lugar_salida": lugarSalida,
        "lugar_llegada": lugarLlegada,
      };
}
