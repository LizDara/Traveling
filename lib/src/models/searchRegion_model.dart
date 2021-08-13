import 'dart:convert';

SearchRegion searchRegionFromJson(String str) =>
    SearchRegion.fromJson(json.decode(str));

String searchRegionToJson(SearchRegion data) => json.encode(data.toJson());

class SearchRegion {
  SearchRegion({
    this.searchWord,
  });

  String? searchWord;

  factory SearchRegion.fromJson(Map<String, dynamic> json) => SearchRegion(
        searchWord: json["search_word"],
      );

  Map<String, dynamic> toJson() => {
        "search_word": searchWord,
      };
}
