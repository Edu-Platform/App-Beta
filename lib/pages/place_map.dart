import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class PlaceMap extends StatefulWidget {
  const PlaceMap({
    Key key,
    this.center,
  }) : super(key: key);

  final LatLng center;

  @override
  PlaceMapState createState() => PlaceMapState();
}


class PlaceMapState extends State<PlaceMap> {

  Completer<GoogleMapController> mapController = Completer();

  MapType _currentMapType = MapType.normal;

  LatLng _lastMapPosition;

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController.complete(controller);
    _lastMapPosition = widget.center;

    // Draw initial place markers on creation so that we have something
    // interesting to look at.
    setState(() {
      /*
      for (Place place in AppState.of(context).places) {
        _markers.add(_createPlaceMarker(place));
      }
      */
    });

  }


  @override
  Widget build(BuildContext context) {

    return Builder(builder: (context) {
      // We need this additional builder here so that we can pass its context to
      // _AddPlaceButtonBar's onSavePressed callback. This callback shows a
      // SnackBar and to do this, we need a build context that has Scaffold as
      // an ancestor.
      return Center(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                target: widget.center,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
            ),
            
          ],
        ),
      );
    });
  }

}