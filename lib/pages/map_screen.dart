import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'place_list.dart';
import 'place_map.dart';

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
      children: <Widget>[
          PlaceMap(center: const LatLng(45.521563, -122.677433)),
          PlaceList(),
        ],
    );
  }
}