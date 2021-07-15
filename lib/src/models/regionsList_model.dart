import 'dart:convert';

import 'package:traveling/src/models/region_model.dart';

RegionsList regionsListFromJson(String str) =>
    RegionsList.fromJson(json.decode(str));

String regionsListToJson(RegionsList data) => json.encode(data.toJson());

class RegionsList {
  RegionsList({
    this.results,
  });

  List<Region> results;

  factory RegionsList.fromJson(Map<String, dynamic> json) => RegionsList(
        results:
            List<Region>.from(json["results"].map((x) => Region.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
