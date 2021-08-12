import 'dart:convert';

import 'package:traveling/src/models/flightOffer_model.dart';

ConfirmOffer confirmOfferFromJson(String str) =>
    ConfirmOffer.fromJson(json.decode(str));

String confirmOfferToJson(ConfirmOffer data) => json.encode(data.toJson());

class ConfirmOffer {
  ConfirmOffer({
    this.data,
    this.dictionaries,
  });

  Data data;
  Dictionaries dictionaries;

  factory ConfirmOffer.fromJson(Map<String, dynamic> json) => ConfirmOffer(
        data: Data.fromJson(json["data"]),
        dictionaries: Dictionaries.fromJson(json["dictionaries"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "dictionaries": dictionaries.toJson(),
      };
}

class Dictionaries {
  Dictionaries({
    this.locations,
  });

  Map<String, Location> locations;

  factory Dictionaries.fromJson(Map<String, dynamic> json) => Dictionaries(
        locations: Map.from(json["locations"])
            .map((k, v) => MapEntry<String, Location>(k, Location.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "locations": Map.from(locations)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Location {
  Location({
    this.cityCode,
    this.countryCode,
  });

  String cityCode;
  String countryCode;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        cityCode: json["cityCode"],
        countryCode: json["countryCode"],
      );

  Map<String, dynamic> toJson() => {
        "cityCode": cityCode,
        "countryCode": countryCode,
      };
}
