import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'place.dart';
import 'place_details.dart';
import 'educastle_app.dart';

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
  static BitmapDescriptor _getPlaceMarkerIcon(PlaceCategory category) {
    switch (category) {
      case PlaceCategory.favorite:
        return BitmapDescriptor.fromAsset('assets/heart.png');
        break;
      case PlaceCategory.visited:
        return BitmapDescriptor.fromAsset('assets/visited.png');
        break;
      case PlaceCategory.wantToGo:
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  static List<Place> _getPlacesForCategory(
      PlaceCategory category, List<Place> places) {
    return places.where((place) => place.category == category).toList();
  }

  Completer<GoogleMapController> mapController = Completer();

  MapType _currentMapType = MapType.normal;

  LatLng _lastMapPosition;

  Map<Marker, Place> _markedPlaces = Map<Marker, Place>();

  final Set<Marker> _markers = {};

  Marker _pendingMarker;

  MapConfiguration _configuration;

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController.complete(controller);
    _lastMapPosition = widget.center;

    // Draw initial place markers on creation so that we have something
    // interesting to look at.
    setState(() {
      for (Place place in AppState.of(context).places) {
        _markers.add(_createPlaceMarker(place));
      }
    });

    // Zoom to fit the initially selected category.
    await _zoomToFitPlaces(
      _getPlacesForCategory(
        AppState.of(context).selectedCategory,
        _markedPlaces.values.toList(),
      ),
    );
  }

  Marker _createPlaceMarker(Place place) {
    final marker = Marker(
      markerId: MarkerId(place.latLng.toString()),
      position: place.latLng,
      infoWindow: InfoWindow(
        title: place.name,
        snippet: '${place.starRating} Star Rating',
        onTap: () => _pushPlaceDetailsScreen(place),
      ),
      icon: _getPlaceMarkerIcon(place.category),
      visible: place.category == AppState.of(context).selectedCategory,
    );
    _markedPlaces[marker] = place;
    return marker;
  }

  void _pushPlaceDetailsScreen(Place place) {
    assert(place != null);

    Navigator.push<void>(
      context,
      MaterialPageRoute(builder: (context) {
        return PlaceDetails(
          place: place,
          onChanged: (value) => _onPlaceChanged(value),
        );
      }),
    );
  }

  void _onPlaceChanged(Place value) {
    // Replace the place with the modified version.
    final newPlaces = List<Place>.from(AppState.of(context).places);
    final index = newPlaces.indexWhere((place) => place.id == value.id);
    newPlaces[index] = value;

    _updateExistingPlaceMarker(place: value);

    // Manually update our map configuration here since our map is already
    // updated with the new marker. Otherwise, the map would be reconfigured
    // in the main build method due to a modified AppState.
    _configuration = MapConfiguration(
      places: newPlaces,
      selectedCategory: AppState.of(context).selectedCategory,
    );

    AppState.updateWith(context, places: newPlaces);
  }

  void _updateExistingPlaceMarker({@required Place place}) {
    Marker marker = _markedPlaces.keys
        .singleWhere((value) => _markedPlaces[value].id == place.id);

    setState(() {
      final updatedMarker = marker.copyWith(
        infoWindowParam: InfoWindow(
          title: place.name,
          snippet:
              place.starRating != 0 ? '${place.starRating} Star Rating' : null,
        ),
      );
      _updateMarker(marker: marker, updatedMarker: updatedMarker, place: place);
    });
  }

  void _updateMarker({
    @required Marker marker,
    @required Marker updatedMarker,
    @required Place place,
  }) {
    _markers.remove(marker);
    _markedPlaces.remove(marker);

    _markers.add(updatedMarker);
    _markedPlaces[updatedMarker] = place;
  }


  Future<void> _showPlacesForSelectedCategory(PlaceCategory category) async {
    setState(() {
      for (Marker marker in List.of(_markedPlaces.keys)) {
        final place = _markedPlaces[marker];
        final updatedMarker = marker.copyWith(
          visibleParam: place.category == category,
        );

        _updateMarker(
          marker: marker,
          updatedMarker: updatedMarker,
          place: place,
        );
      }
    });

    await _zoomToFitPlaces(_getPlacesForCategory(
      category,
      _markedPlaces.values.toList(),
    ));
  }

  Future<void> _zoomToFitPlaces(List<Place> places) async {
    GoogleMapController controller = await mapController.future;

    // Default min/max values to latitude and longitude of center.
    double minLat = widget.center.latitude;
    double maxLat = widget.center.latitude;
    double minLong = widget.center.longitude;
    double maxLong = widget.center.longitude;

    for (Place place in places) {
      minLat = min(minLat, place.latitude);
      maxLat = max(maxLat, place.latitude);
      minLong = min(minLong, place.longitude);
      maxLong = max(maxLong, place.longitude);
    }

    await controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLong),
          northeast: LatLng(maxLat, maxLong),
        ),
        48.0,
      ),
    );
  }

  Future<void> _maybeUpdateMapConfiguration() async {
    _configuration ??= MapConfiguration.of(AppState.of(context));
    final MapConfiguration newConfiguration =
        MapConfiguration.of(AppState.of(context));

    // Since we manually update [_configuration] when place or selectedCategory
    // changes come from the [place_map], we should only enter this if statement
    // when returning to the [place_map] after changes have been made from
    // [place_list].
    if (_configuration != newConfiguration && mapController != null) {
      if (_configuration.places == newConfiguration.places &&
          _configuration.selectedCategory !=
              newConfiguration.selectedCategory) {
        // If the configuration change is only a category change, just update
        // the marker visibilities.
        await _showPlacesForSelectedCategory(newConfiguration.selectedCategory);
      } else {
        // At this point, we know the places have been updated from the list
        // view. We need to reconfigure the map to respect the updates.
        newConfiguration.places
            .where((p) => !_configuration.places.contains(p))
            .map((value) => _updateExistingPlaceMarker(place: value));

        await _zoomToFitPlaces(
          _getPlacesForCategory(
            newConfiguration.selectedCategory,
            newConfiguration.places,
          ),
        );
      }
      _configuration = newConfiguration;
    }
  }

  @override
  Widget build(BuildContext context) {
    _maybeUpdateMapConfiguration();

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
              markers: _markers,
              onCameraMove: (position) => _lastMapPosition = position.target,
            ),
            
            _MapFabs(
              visible: _pendingMarker == null,
            ),
          ],
        ),
      );
    });
  }
}


class _MapFabs extends StatelessWidget {
  const _MapFabs({
    Key key,
    @required this.visible,
  })  : assert(visible != null),
        super(key: key);

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(top: 12.0, right: 12.0),
      child: Visibility(
        visible: visible,
        child: Column(
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'add_place_button',
              onPressed: () {
                AppState.updateWith(
                  context,
                  viewType:
                      AppState.of(context).viewType == PlaceTrackerViewType.map
                          ? PlaceTrackerViewType.list
                          : PlaceTrackerViewType.map,
                );
              },
              mini: true,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              backgroundColor: Colors.green,
              child: const Icon(Icons.list, size: 36.0),
            ),
          ],
        ),
      ),
    );
  }
}

class MapConfiguration {
  const MapConfiguration({
    @required this.places,
    @required this.selectedCategory,
  })  : assert(places != null),
        assert(selectedCategory != null);

  final List<Place> places;
  final PlaceCategory selectedCategory;

  @override
  int get hashCode => places.hashCode ^ selectedCategory.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is MapConfiguration &&
        other.places == places &&
        other.selectedCategory == selectedCategory;
  }

  static MapConfiguration of(AppState appState) {
    return MapConfiguration(
      places: appState.places,
      selectedCategory: appState.selectedCategory,
    );
  }
}
