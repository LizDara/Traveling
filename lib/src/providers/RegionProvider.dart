import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:traveling/src/models/region_model.dart';
import 'package:traveling/src/models/regionsList_model.dart';
import 'package:traveling/src/models/searchRegion_model.dart';
import 'package:traveling/src/providers/global.dart';

class RegionProvider {
  final String _url = baseUrl;

  Future<List<Region>> searchRegion(SearchRegion searchRegion) async {
    final url = '$_url/buscar-regiones/';

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: searchRegionToJson(searchRegion));

    final regionList = regionsListFromJson(response.body);

    return regionList.results;
  }
}
