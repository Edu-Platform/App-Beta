import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'place_list.dart';
import 'place_map.dart';
import 'educastle_app.dart';

class MapScreen extends StatefulWidget {
  @override
  MapScreenState createState() {
    return new MapScreenState();
  }
}

class MapScreenState extends State<MapScreen> {


  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: 
          AppState.of(context).viewType == PlaceTrackerViewType.map ? 0 : 1,
      children: <Widget>[
          PlaceList(),
          PlaceMap(center: const LatLng(37.350078,127.1067633)),
      ],
    );
  }
}


