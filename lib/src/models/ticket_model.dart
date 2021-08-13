import 'dart:convert';

Ticket ticketFromJson(String str) => Ticket.fromJson(json.decode(str));

String ticketToJson(Ticket data) => json.encode(data.toJson());

class Ticket {
  Ticket({
    this.id,
    this.cabina,
    this.clase,
    this.precio,
    this.boleto,
    this.segmentoId,
  });

  int? id;
  String? cabina;
  String? clase;
  double? precio;
  String? boleto;
  int? segmentoId;

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json["id"],
        cabina: json["cabina"],
        clase: json["clase"],
        precio: json["precio"].toDouble(),
        boleto: json["boleto"],
        segmentoId: json["segmento_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cabina": cabina,
        "clase": clase,
        "precio": precio,
        "boleto": boleto,
        "segmento_id": segmentoId,
      };
}
