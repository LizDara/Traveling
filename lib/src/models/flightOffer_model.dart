import 'dart:convert';

import 'package:traveling/src/models/ticketList_model.dart';

FlightOffer flightOfferFromJson(String str) =>
    FlightOffer.fromJson(json.decode(str));

String flightOfferToJson(FlightOffer data) => json.encode(data.toJson());

class FlightOffer {
  FlightOffer({
    this.data,
  });

  Data data;

  factory FlightOffer.fromJson(Map<String, dynamic> json) => FlightOffer(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.type,
    this.flightOffers,
  });

  String type;
  List<TicketList> flightOffers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"],
        flightOffers: List<TicketList>.from(
            json["flightOffers"].map((x) => TicketList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "flightOffers": List<dynamic>.from(flightOffers.map((x) => x.toJson())),
      };
}
