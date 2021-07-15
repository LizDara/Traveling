import 'dart:convert';

Region regionFromJson(String str) => Region.fromJson(json.decode(str));

String regionToJson(Region data) => json.encode(data.toJson());

class Region {
  Region({
    this.isoRegion,
    this.name,
    this.isoCountry,
  });

  String isoRegion;
  String name;
  String isoCountry;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        isoRegion: json["iso_region"],
        name: json["name"],
        isoCountry: json["iso_country"],
      );

  Map<String, dynamic> toJson() => {
        "iso_region": isoRegion,
        "name": name,
        "iso_country": isoCountry,
      };
}
