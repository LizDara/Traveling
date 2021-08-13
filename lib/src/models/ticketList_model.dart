import 'dart:convert';

List<TicketList> ticketListFromJson(String str) =>
    List<TicketList>.from(json.decode(str).map((x) => TicketList.fromJson(x)));

String ticketListToJson(List<TicketList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TicketList {
  TicketList({
    this.instantTicketingRequired,
    this.nonHomogeneous,
    this.oneWay,
    this.itineraries,
    this.pricingOptions,
    this.id,
    this.source,
    this.numberOfBookableSeats,
    this.price,
    this.validatingAirlineCodes,
    this.travelerPricings,
    this.type,
    this.lastTicketingDate,
  });

  bool? instantTicketingRequired;
  bool? nonHomogeneous;
  bool? oneWay;
  List<Itinerary>? itineraries;
  PricingOptions? pricingOptions;
  String? id;
  String? source;
  int? numberOfBookableSeats;
  TicketListPrice? price;
  List<String>? validatingAirlineCodes;
  List<TravelerPricing>? travelerPricings;
  String? type;
  String? lastTicketingDate;

  factory TicketList.fromJson(Map<String, dynamic> json) => TicketList(
        instantTicketingRequired: json["instantTicketingRequired"],
        nonHomogeneous: json["nonHomogeneous"],
        oneWay: json["oneWay"],
        itineraries: List<Itinerary>.from(
            json["itineraries"].map((x) => Itinerary.fromJson(x))),
        pricingOptions: PricingOptions.fromJson(json["pricingOptions"]),
        id: json["id"],
        source: json["source"],
        numberOfBookableSeats: json["numberOfBookableSeats"],
        price: TicketListPrice.fromJson(json["price"]),
        validatingAirlineCodes:
            List<String>.from(json["validatingAirlineCodes"].map((x) => x)),
        travelerPricings: List<TravelerPricing>.from(
            json["travelerPricings"].map((x) => TravelerPricing.fromJson(x))),
        type: json["type"],
        lastTicketingDate: json["lastTicketingDate"],
      );

  Map<String, dynamic> toJson() => {
        "instantTicketingRequired": instantTicketingRequired,
        "nonHomogeneous": nonHomogeneous,
        "oneWay": oneWay,
        "itineraries": List<dynamic>.from(itineraries!.map((x) => x.toJson())),
        "pricingOptions": pricingOptions!.toJson(),
        "id": id,
        "source": source,
        "numberOfBookableSeats": numberOfBookableSeats,
        "price": price!.toJson(),
        "validatingAirlineCodes":
            List<dynamic>.from(validatingAirlineCodes!.map((x) => x)),
        "travelerPricings":
            List<dynamic>.from(travelerPricings!.map((x) => x.toJson())),
        "type": type,
        "lastTicketingDate": lastTicketingDate,
      };
}

class Itinerary {
  Itinerary({
    this.duration,
    this.segments,
  });

  String? duration;
  List<Segment>? segments;

  factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
        duration: json["duration"],
        segments: List<Segment>.from(
            json["segments"].map((x) => Segment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "duration": duration,
        "segments": List<dynamic>.from(segments!.map((x) => x.toJson())),
      };
}

class Segment {
  Segment({
    this.duration,
    this.id,
    this.blacklistedInEu,
    this.departure,
    this.arrival,
    this.number,
    this.operating,
    this.carrierCode,
    this.aircraft,
    this.numberOfStops,
  });

  String? duration;
  String? id;
  bool? blacklistedInEu;
  Arrival? departure;
  Arrival? arrival;
  String? number;
  Operating? operating;
  String? carrierCode;
  Aircraft? aircraft;
  int? numberOfStops;

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
        duration: json["duration"],
        id: json["id"],
        blacklistedInEu: json["blacklistedInEU"],
        departure: Arrival.fromJson(json["departure"]),
        arrival: Arrival.fromJson(json["arrival"]),
        number: json["number"],
        operating: Operating.fromJson(json["operating"]),
        carrierCode: json["carrierCode"],
        aircraft: Aircraft.fromJson(json["aircraft"]),
        numberOfStops: json["numberOfStops"],
      );

  Map<String, dynamic> toJson() => {
        "duration": duration,
        "id": id,
        "blacklistedInEU": blacklistedInEu,
        "departure": departure!.toJson(),
        "arrival": arrival!.toJson(),
        "number": number,
        "operating": operating!.toJson(),
        "carrierCode": carrierCode,
        "aircraft": aircraft!.toJson(),
        "numberOfStops": numberOfStops,
      };
}

class Aircraft {
  Aircraft({
    this.code,
  });

  String? code;

  factory Aircraft.fromJson(Map<String, dynamic> json) => Aircraft(
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
      };
}

class Arrival {
  Arrival({
    this.at,
    this.iataCode,
  });

  String? at;
  String? iataCode;

  factory Arrival.fromJson(Map<String, dynamic> json) => Arrival(
        at: json["at"],
        iataCode: json["iataCode"],
      );

  Map<String, dynamic> toJson() => {
        "at": at,
        "iataCode": iataCode,
      };
}

class Operating {
  Operating({
    this.carrierCode,
  });

  String? carrierCode;

  factory Operating.fromJson(Map<String, dynamic> json) => Operating(
        carrierCode: json["carrierCode"],
      );

  Map<String, dynamic> toJson() => {
        "carrierCode": carrierCode,
      };
}

class TicketListPrice {
  TicketListPrice({
    this.base,
    this.fees,
    this.grandTotal,
    this.currency,
    this.total,
  });

  String? base;
  List<Fee>? fees;
  String? grandTotal;
  String? currency;
  String? total;

  factory TicketListPrice.fromJson(Map<String, dynamic> json) =>
      TicketListPrice(
        base: json["base"],
        fees: List<Fee>.from(json["fees"].map((x) => Fee.fromJson(x))),
        grandTotal: json["grandTotal"],
        currency: json["currency"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "base": base,
        "fees": List<dynamic>.from(fees!.map((x) => x.toJson())),
        "grandTotal": grandTotal,
        "currency": currency,
        "total": total,
      };
}

class Fee {
  Fee({
    this.type,
    this.amount,
  });

  String? type;
  String? amount;

  factory Fee.fromJson(Map<String, dynamic> json) => Fee(
        type: json["type"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "amount": amount,
      };
}

class PricingOptions {
  PricingOptions({
    this.fareType,
    this.includedCheckedBagsOnly,
  });

  List<String>? fareType;
  bool? includedCheckedBagsOnly;

  factory PricingOptions.fromJson(Map<String, dynamic> json) => PricingOptions(
        fareType: List<String>.from(json["fareType"].map((x) => x)),
        includedCheckedBagsOnly: json["includedCheckedBagsOnly"],
      );

  Map<String, dynamic> toJson() => {
        "fareType": List<dynamic>.from(fareType!.map((x) => x)),
        "includedCheckedBagsOnly": includedCheckedBagsOnly,
      };
}

class TravelerPricing {
  TravelerPricing({
    this.fareDetailsBySegment,
    this.travelerId,
    this.fareOption,
    this.travelerType,
    this.price,
  });

  List<FareDetailsBySegment>? fareDetailsBySegment;
  String? travelerId;
  String? fareOption;
  String? travelerType;
  TravelerPricingPrice? price;

  factory TravelerPricing.fromJson(Map<String, dynamic> json) =>
      TravelerPricing(
        fareDetailsBySegment: List<FareDetailsBySegment>.from(
            json["fareDetailsBySegment"]
                .map((x) => FareDetailsBySegment.fromJson(x))),
        travelerId: json["travelerId"],
        fareOption: json["fareOption"],
        travelerType: json["travelerType"],
        price: TravelerPricingPrice.fromJson(json["price"]),
      );

  Map<String, dynamic> toJson() => {
        "fareDetailsBySegment":
            List<dynamic>.from(fareDetailsBySegment!.map((x) => x.toJson())),
        "travelerId": travelerId,
        "fareOption": fareOption,
        "travelerType": travelerType,
        "price": price!.toJson(),
      };
}

class FareDetailsBySegment {
  FareDetailsBySegment({
    this.segmentId,
    this.cabin,
    this.fareBasis,
    this.fareDetailsBySegmentClass,
    this.includedCheckedBags,
  });

  String? segmentId;
  String? cabin;
  String? fareBasis;
  String? fareDetailsBySegmentClass;
  IncludedCheckedBags? includedCheckedBags;

  factory FareDetailsBySegment.fromJson(Map<String, dynamic> json) =>
      FareDetailsBySegment(
        segmentId: json["segmentId"],
        cabin: json["cabin"],
        fareBasis: json["fareBasis"],
        fareDetailsBySegmentClass: json["class"],
        includedCheckedBags:
            IncludedCheckedBags.fromJson(json["includedCheckedBags"]),
      );

  Map<String, dynamic> toJson() => {
        "segmentId": segmentId,
        "cabin": cabin,
        "fareBasis": fareBasis,
        "class": fareDetailsBySegmentClass,
        "includedCheckedBags": includedCheckedBags!.toJson(),
      };
}

class IncludedCheckedBags {
  IncludedCheckedBags({
    this.weight,
    this.weightUnit,
  });

  int? weight;
  String? weightUnit;

  factory IncludedCheckedBags.fromJson(Map<String, dynamic> json) =>
      IncludedCheckedBags(
        weight: json["weight"],
        weightUnit: json["weightUnit"],
      );

  Map<String, dynamic> toJson() => {
        "weight": weight,
        "weightUnit": weightUnit,
      };
}

class TravelerPricingPrice {
  TravelerPricingPrice({
    this.total,
    this.base,
    this.currency,
  });

  String? total;
  String? base;
  String? currency;

  factory TravelerPricingPrice.fromJson(Map<String, dynamic> json) =>
      TravelerPricingPrice(
        total: json["total"],
        base: json["base"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "base": base,
        "currency": currency,
      };
}
