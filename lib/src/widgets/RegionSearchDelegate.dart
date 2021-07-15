import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveling/src/models/region_model.dart';
import 'package:traveling/src/models/searchRegion_model.dart';
import 'package:traveling/src/providers/RegionProvider.dart';

class RegionSearchDelegate extends SearchDelegate {
  SearchRegion searchRegion = new SearchRegion();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('BUILD RESULTS');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Icon(
          Icons.flight_takeoff,
          color: Colors.black26,
          size: 120,
        ),
      );
    }

    final RegionProvider regionProvider = new RegionProvider();
    searchRegion.searchWord = query;

    return FutureBuilder(
      future: regionProvider.searchRegion(searchRegion),
      builder: (BuildContext context, AsyncSnapshot<List<Region>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text(
              'No results.',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
          );
        }
        final regions = snapshot.data;

        return ListView.builder(
          itemCount: regions.length,
          itemBuilder: (BuildContext context, int index) {
            final Region region = regions[index];
            List<String> names = region.name.split(',');
            return ListTile(
              title: Text(names[0]),
              subtitle: Text(names[1]),
              onTap: () {
                print(region.name);
                close(context, region);
              },
            );
          },
        );
      },
    );
  }
}
