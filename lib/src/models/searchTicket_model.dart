import 'dart:convert';

SearchTicket searchTicketFromJson(String str) =>
    SearchTicket.fromJson(json.decode(str));

String searchTicketToJson(SearchTicket data) => json.encode(data.toJson());

class SearchTicket {
  SearchTicket({
    this.fromIsoRegion,
    this.fromDateRange,
    this.fromTimeRange,
    this.toIsoRegion,
    this.toDateRange,
    this.toTimeRange,
    this.travelersNumbers,
    this.roundTrip,
  });

  String fromIsoRegion;
  String fromDateRange;
  String fromTimeRange;
  String toIsoRegion;
  String toDateRange;
  String toTimeRange;
  int travelersNumbers;
  bool roundTrip;

  factory SearchTicket.fromJson(Map<String, dynamic> json) => SearchTicket(
        fromIsoRegion: json["from_iso_region"],
        fromDateRange: json["from_date_range"],
        fromTimeRange: json["from_time_range"],
        toIsoRegion: json["to_iso_region"],
        toDateRange: json["to_date_range"],
        toTimeRange: json["to_time_range"],
        travelersNumbers: json["travelers_numbers"],
        roundTrip: json["round_trip"],
      );

  Map<String, dynamic> toJson() => {
        "from_iso_region": fromIsoRegion,
        "from_date_range": fromDateRange,
        "from_time_range": fromTimeRange,
        "to_iso_region": toIsoRegion,
        "to_date_range": toDateRange,
        "to_time_range": toTimeRange,
        "travelers_numbers": travelersNumbers,
        "round_trip": roundTrip,
      };
}
