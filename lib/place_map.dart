// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'place.dart';
import 'place_details.dart';
import 'place_tracker_app.dart';

class MapConfiguration {
  final List<Place> places;

  final PlaceCategory selectedCategory;

  const MapConfiguration(
      {required this.places, required this.selectedCategory});

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

class PlaceMap extends StatefulWidget {
  final LatLng? center;

  const PlaceMap(
      {Key? key, this.center, GoogleMapController? googleMapController})
      : super(key: key);

  @override
  PlaceMapState createState() => PlaceMapState();
}

class PlaceMapState extends State<PlaceMap> {
  Geolocator geolocator = Geolocator();

  Completer<GoogleMapController> mapController = Completer();

  MapType _currentMapType = MapType.normal;

  static LatLng _initialPosition = new LatLng(59.436962, 24.753574);
  static LatLng _currentPosition = _initialPosition;
  LatLng? _lastMapPosition;

  final Map<Marker, Place> _markedPlaces = <Marker, Place>{};

  final Set<Marker> _markers = {};

  Marker? _pendingMarker;

  MapConfiguration? _configuration;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _getUserLocation(GoogleMapController googleMapController) async {
    Position position =
    await Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
    Position currentPositionConverted = Position(
        longitude: _currentPosition.longitude,
        latitude: _currentPosition.latitude,
        timestamp: DateTime
            .now(),
        accuracy: 0.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0);
    if (currentPositionConverted != position) {
      _initialPosition = LatLng(position.latitude, position.longitude);
      googleMapController
          .animateCamera(CameraUpdate.newLatLngZoom(_initialPosition, 14));
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });

      //track location change

    }
  }

  void _trackLocationChange(GoogleMapController googleMapController) {
    Location location = new Location();
    location.onLocationChanged.listen((currentLocation) async {
      Position position = await Geolocator.getCurrentPosition(
          forceAndroidLocationManager: true);
      _initialPosition = LatLng(position.latitude, position.longitude);
      googleMapController
          .animateCamera(CameraUpdate.newLatLngZoom(_initialPosition, 18));
    });
  }

  @override
  Widget build(BuildContext context) {
    _maybeUpdateMapConfiguration();

    var state = Provider.of<AppState>(context);

    return Builder(builder: (context) {
      // We need this additional builder here so that we can pass its context to
      // _AddPlaceButtonBar's onSavePressed callback. This callback shows a
      // SnackBar and to do this, we need a build context that has Scaffold as
      // an ancestor.
      final googleMap = new GoogleMap(
          onMapCreated: onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _currentPosition, //widget.center!,
            zoom: 11.0,
          ),
          mapType: _currentMapType,
          markers: _markers,
          onCameraMove: (position) => _lastMapPosition = position.target,
          myLocationEnabled: true
      );

      final Future<String> _calculation = Future<String>.delayed(
        const Duration(seconds: 2),
            () => 'Andmed laeti',
      );

      return Center(
        child: Stack(
          children: [
            FutureBuilder<String>(
              future: _calculation,
              // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  children = <Widget>[
                    googleMap,
                    Center(
                      child: Text('Result: ${snapshot.data}'),
                    )
                  ];
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Center(
                      child: Text('Viga: ${snapshot.error}'),
                    )
                  ];
                } else {
                  children = const <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Text('Palun oodake...'),
                    )
                  ];
                }
                return Center(child: children[0]);
              },
            ),
            Container(
              child: Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(
                    state.viewType == PlaceTrackerViewType.map
                        ? Icons.my_location
                        : Icons.my_location,
                    size: 32.0,
                    color: Colors.blue[400],
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    _getUserLocation(controller);
    _trackLocationChange(controller);

    // Draw initial place markers on creation so that we have something
    // interesting to look at.
    var markers = <Marker>{};
    for (var place in Provider
        .of<AppState>(context, listen: false)
        .places) {
      markers.add(await _createPlaceMarker(context, place));
    }
    setState(() {
      _markers.addAll(markers);
    });

    // Zoom to fit the initially selected category.
    _zoomToFitSelectedCategory();
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  @override
  void didUpdateWidget(PlaceMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Zoom to fit the selected category.
    if (mounted) {
      _zoomToFitSelectedCategory();
    }
  }

  /// Applies zoom to fit the places of the selected category
  void _zoomToFitSelectedCategory() {
    _zoomToFitPlaces(
      _getPlacesForCategory(
        Provider
            .of<AppState>(context, listen: false)
            .selectedCategory,
        _markedPlaces.values.toList(),
      ),
    );
  }

  void _cancelAddPlace() {
    if (_pendingMarker != null) {
      setState(() {
        _markers.remove(_pendingMarker);
        _pendingMarker = null;
      });
    }
  }

  Future<void> _confirmAddPlace(BuildContext context) async {
    if (_pendingMarker != null) {
      // Create a new Place and map it to the marker we just added.
      final newPlace = Place(
        id: const Uuid().v1(),
        latLng: _pendingMarker!.position,
        name: _pendingMarker!.infoWindow.title!,
        category:
        Provider
            .of<AppState>(context, listen: false)
            .selectedCategory,
      );

      var placeMarker = await _getPlaceMarkerIcon(context,
          Provider
              .of<AppState>(context, listen: false)
              .selectedCategory);

      setState(() {
        final updatedMarker = _pendingMarker!.copyWith(
          iconParam: placeMarker,
          infoWindowParam: InfoWindow(
            title: 'Uus koht',
            snippet: null,
            onTap: () => _pushPlaceDetailsScreen(newPlace),
          ),
          draggableParam: false,
        );

        _updateMarker(
          marker: _pendingMarker,
          updatedMarker: updatedMarker,
          place: newPlace,
        );

        _pendingMarker = null;
      });

      // Show a confirmation snackbar that has an action to edit the new place.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content:
          const Text('Uus koht lisatud.', style: TextStyle(fontSize: 16.0)),
          action: SnackBarAction(
            label: 'Muuda',
            onPressed: () async {
              _pushPlaceDetailsScreen(newPlace);
            },
          ),
        ),
      );

      // Add the new place to the places stored in appState.
      final newPlaces =
      List<Place>.from(Provider
          .of<AppState>(context, listen: false)
          .places)
        ..add(newPlace);

      // Manually update our map configuration here since our map is already
      // updated with the new marker. Otherwise, the map would be reconfigured
      // in the main build method due to a modified AppState.
      _configuration = MapConfiguration(
        places: newPlaces,
        selectedCategory:
        Provider
            .of<AppState>(context, listen: false)
            .selectedCategory,
      );

      Provider.of<AppState>(context, listen: false).setPlaces(newPlaces);
    }
  }

  Future<Marker> _createPlaceMarker(BuildContext context, Place place) async {
    final marker = Marker(
      markerId: MarkerId(place.latLng.toString()),
      position: place.latLng,
      infoWindow: InfoWindow(
        title: place.name,
        snippet: '${place.starRating}',
        onTap: () => _pushPlaceDetailsScreen(place),
      ),
      icon: await _getPlaceMarkerIcon(context, place.category),
      visible: place.category ==
          Provider
              .of<AppState>(context, listen: false)
              .selectedCategory,
    );
    _markedPlaces[marker] = place;
    return marker;
  }

  Future<void> _maybeUpdateMapConfiguration() async {
    _configuration ??=
        MapConfiguration.of(Provider.of<AppState>(context, listen: false));
    final newConfiguration =
    MapConfiguration.of(Provider.of<AppState>(context, listen: false));

    // Since we manually update [_configuration] when place or selectedCategory
    // changes come from the [place_map], we should only enter this if statement
    // when returning to the [place_map] after changes have been made from
    // [place_list].
    if (_configuration != newConfiguration) {
      if (_configuration!.places == newConfiguration.places &&
          _configuration!.selectedCategory !=
              newConfiguration.selectedCategory) {
        // If the configuration change is only a category change, just update
        // the marker visibilities.
        await _showPlacesForSelectedCategory(newConfiguration.selectedCategory);
      } else {
        // At this point, we know the places have been updated from the list
        // view. We need to reconfigure the map to respect the updates.
        newConfiguration.places
            .where((p) => !_configuration!.places.contains(p))
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

  Future<void> _onAddPlacePressed() async {
    setState(() {
      final newMarker = Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition!,
        infoWindow: const InfoWindow(title: 'Uus koht'),
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );
      _markers.add(newMarker);
      _pendingMarker = newMarker;
    });
  }

  void _onPlaceChanged(Place value) {
    // Replace the place with the modified version.
    final newPlaces =
    List<Place>.from(Provider
        .of<AppState>(context, listen: false)
        .places);
    final index = newPlaces.indexWhere((place) => place.id == value.id);
    newPlaces[index] = value;

    _updateExistingPlaceMarker(place: value);

    // Manually update our map configuration here since our map is already
    // updated with the new marker. Otherwise, the map would be reconfigured
    // in the main build method due to a modified AppState.
    _configuration = MapConfiguration(
      places: newPlaces,
      selectedCategory:
      Provider
          .of<AppState>(context, listen: false)
          .selectedCategory,
    );

    Provider.of<AppState>(context, listen: false).setPlaces(newPlaces);
  }

  void _onToggleMapTypePressed() {
    final nextType =
    MapType.values[(_currentMapType.index + 1) % MapType.values.length];

    setState(() {
      _currentMapType = nextType;
    });
  }

  void _pushPlaceDetailsScreen(Place place) {
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

  Future<void> _showPlacesForSelectedCategory(PlaceCategory category) async {
    setState(() {
      for (var marker in List.of(_markedPlaces.keys)) {
        final place = _markedPlaces[marker]!;
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

  Future<void> _switchSelectedCategory(PlaceCategory category) async {
    Provider.of<AppState>(context, listen: false).setSelectedCategory(category);
    await _showPlacesForSelectedCategory(category);
  }

  void _updateExistingPlaceMarker({required Place place}) {
    var marker = _markedPlaces.keys
        .singleWhere((value) => _markedPlaces[value]!.id == place.id);

    setState(() {
      final updatedMarker = marker.copyWith(
        infoWindowParam: InfoWindow(
          title: place.name,
          snippet: place.starRating != 0 ? '${place.starRating} Hinnang' : null,
        ),
      );
      _updateMarker(marker: marker, updatedMarker: updatedMarker, place: place);
    });
  }

  void _updateMarker({
    required Marker? marker,
    required Marker updatedMarker,
    required Place place,
  }) {
    _markers.remove(marker);
    _markedPlaces.remove(marker);

    _markers.add(updatedMarker);
    _markedPlaces[updatedMarker] = place;
  }

  Future<void> _zoomToFitPlaces(List<Place> places) async {
    var controller = await mapController.future;

    // Default min/max values to latitude and longitude of center.
    var minLat = widget.center!.latitude;
    var maxLat = widget.center!.latitude;
    var minLong = widget.center!.longitude;
    var maxLong = widget.center!.longitude;

    for (var place in places) {
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

  static Future<BitmapDescriptor> _getPlaceMarkerIcon(BuildContext context,
      PlaceCategory category) async {
    switch (category) {
      case PlaceCategory.favorite:
        return BitmapDescriptor.fromAssetImage(
            createLocalImageConfiguration(context, size: const Size.square(32)),
            'assets/heart.png');
      case PlaceCategory.visited:
        return BitmapDescriptor.fromAssetImage(
            createLocalImageConfiguration(context, size: const Size.square(32)),
            'assets/visited.png');
      case PlaceCategory.wantToGo:
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  static List<Place> _getPlacesForCategory(PlaceCategory category,
      List<Place> places) {
    return places.where((place) => place.category == category).toList();
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Asukoha teenused on kinni!');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Asukoha luba puudub!');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Asukoha luba puudub!.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final Position position =
    await Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
    return position;
  }
}

class _AddPlaceButtonBar extends StatelessWidget {
  final bool visible;

  final VoidCallback onSavePressed;
  final VoidCallback onCancelPressed;

  const _AddPlaceButtonBar({
    Key? key,
    required this.visible,
    required this.onSavePressed,
    required this.onCancelPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 14.0),
        alignment: Alignment.bottomCenter,
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              child: const Text(
                'Salvesta',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              onPressed: onSavePressed,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: const Text(
                'Tühista',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              onPressed: onCancelPressed,
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryButtonBar extends StatelessWidget {
  final PlaceCategory selectedPlaceCategory;
  final bool visible;
  final ValueChanged<PlaceCategory> onChanged;

  const _CategoryButtonBar({
    Key? key,
    required this.selectedPlaceCategory,
    required this.visible,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 14.0),
        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 14.0),
        alignment: Alignment.bottomCenter,
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: selectedPlaceCategory == PlaceCategory.favorite
                      ? Colors.blue[700]
                      : Colors.blue),
              child: const Text(
                'Minu tellimused',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
              onPressed: () => onChanged(PlaceCategory.favorite),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: selectedPlaceCategory == PlaceCategory.visited
                      ? Colors.blue[700]
                      : Colors.blue),
              child: const Text(
                'Tühistatud tellimused',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
              onPressed: () => onChanged(PlaceCategory.visited),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapFabs extends StatefulWidget {
  final bool visible;
  final VoidCallback onAddPlacePressed;
  final VoidCallback onToggleMapTypePressed;
  final GoogleMapController googleMapController;

  LatLng? loaction;

  _MapFabs({
    Key? key,
    required this.visible,
    required this.onAddPlacePressed,
    required this.onToggleMapTypePressed,
    required this.googleMapController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(top: 12.0, right: 12.0),
      child: Visibility(
        visible: visible,
        child: Column(
          children: [
            FloatingActionButton(
              heroTag: 'add_place_button',
              onPressed: onAddPlacePressed,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add_location, size: 36.0),
            ),
            const SizedBox(height: 12.0),
            FloatingActionButton(
              heroTag: 'toggle_map_type_button',
              onPressed: onToggleMapTypePressed,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              mini: true,
              backgroundColor: Colors.lightBlue,
              child: const Icon(Icons.layers, size: 28.0),
            ),
            FloatingActionButton(
              heroTag: 'toggle_map_type_button',
              materialTapTargetSize: MaterialTapTargetSize.padded,
              mini: true,
              backgroundColor: Colors.lightBlue,
              onPressed: () async {
                await googleMapController.moveCamera(
                    CameraUpdate.newLatLngZoom(const LatLng(50, -71), 12));
              },
              child: const Icon(Icons.my_location, size: 28.0),
            ),
          ],
        ),
      ),
    );
  }

  @override
  PlaceMapState createState() => PlaceMapState();
}
