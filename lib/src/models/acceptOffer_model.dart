import 'dart:convert';
import 'package:traveling/src/models/ticketList_model.dart';
import 'package:traveling/src/models/traveler_model.dart';

AcceptOffer acceptOfferFromJson(String str) =>
    AcceptOffer.fromJson(json.decode(str));

String acceptOfferToJson(AcceptOffer data) => json.encode(data.toJson());

class AcceptOffer {
  AcceptOffer({
    this.data,
  });

  Data? data;

  factory AcceptOffer.fromJson(Map<String, dynamic> json) => AcceptOffer(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.type,
    this.flightOffers,
    this.travelers,
  });

  String? type;
  List<TicketList>? flightOffers;
  List<Traveler>? travelers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"],
        flightOffers: List<TicketList>.from(
            json["flightOffers"].map((x) => TicketList.fromJson(x))),
        travelers: List<Traveler>.from(
            json["travelers"].map((x) => Traveler.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "flightOffers":
            List<dynamic>.from(flightOffers!.map((x) => x.toJson())),
        "travelers": List<dynamic>.from(travelers!.map((x) => x.toJson())),
      };
}
