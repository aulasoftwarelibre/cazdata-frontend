import 'dart:async';

import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/ui/widget/bottom-navigation-bar.widget.dart';
import 'package:cazdata_frontend/ui/widget/radial-menu.widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../util/colors.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 0;
const LatLng SOURCE_LOCATION = LatLng(42.747932, -71.167889);

class JourneyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => JourneyPageState();
}

class JourneyPageState extends State<JourneyPage> {
  Completer<GoogleMapController> _controller = Completer();

  //Map markers
  Set<Marker> _markers = Set<Marker>();

  // the user's initial location and current location
  // as it moves
  LocationData _currentLocation;
  // wrapper around the location API
  Location _location;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel(
          user: store.state.firebaseState.firebaseUser,
          currentJourneyState: store.state.currentJourneyState),
      builder: (BuildContext context, _ViewModel vm) => _homeView(context, vm),
    );
  }

  Widget _homeView(BuildContext context, _ViewModel vm) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);

    if (_currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }

    return Scaffold(
      body: Stack(alignment: Alignment.center, children: <Widget>[
        GoogleMap(
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          compassEnabled: false,
          rotateGesturesEnabled: false,
          scrollGesturesEnabled: false,
          tiltGesturesEnabled: false,
          zoomGesturesEnabled: false,
          zoomControlsEnabled: false,
          markers: _markers,
          mapType: MapType.hybrid,
          initialCameraPosition: initialCameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ButtonTheme(
                  child: Row(
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return MaterialApp(
                                    title: 'Group',
                                    theme: ThemeData(
                                        primaryColor: primaryColor,
                                        fontFamily: 'Montserrat'),
                                    home: ChangeNotifierProvider<
                                        BottomNavigationBarProvider>(
                                      child: BottomNavigationBarWidget(),
                                      create: (BuildContext context) =>
                                          BottomNavigationBarProvider(),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          color: Colors.red,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.flag,
                            color: Colors.white,
                            size: 40,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 100.0,
                  ),
                  child: RadialMenu(),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  @override
  void initState() {
    super.initState();

    // create an instance of Location
    _location = new Location();

    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    _location.onLocationChanged().listen((LocationData cLoc) {
      // cLoc contains the lat anrd long of the
      // current user's position in real time,
      // so we're holding on to it
      setState(() {
        _currentLocation = cLoc;
      });

      //Update camera position as the user moves
      goToCurrentLocation();
    });

    // set the initial location
    setInitialLocation();
  }

  Future<void> setInitialLocation() async {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    _currentLocation = await _location.getLocation();
  }

  Future<void> goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(
        _currentLocation.latitude,
        _currentLocation.longitude,
      ),
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
    )));
  }
}

class _ViewModel {
  final FirebaseUser user;
  final CurrentJourneyState currentJourneyState;

  _ViewModel({@required this.user, @required this.currentJourneyState});
}
