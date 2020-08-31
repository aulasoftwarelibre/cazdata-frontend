import 'dart:async';

import 'package:cazdata_frontend/models/hunter/hunter.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/ui/widget/index.dart';
import 'package:cazdata_frontend/util/constants.dart';
import 'package:cazdata_frontend/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../util/colors.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
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
      converter: (store) => _ViewModel(hunter: store.state.hunterState.hunter),
      builder: (BuildContext context, _ViewModel vm) => _homeView(context, vm),
    );
  }

  Widget _homeView(BuildContext context, _ViewModel vm) {
    CameraPosition initialCameraPosition =
        CameraPosition(zoom: CAMERA_ZOOM, tilt: CAMERA_TILT, bearing: CAMERA_BEARING, target: SOURCE_LOCATION);

    if (_currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: PageScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Mapa de Inicio',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Card(
                          color: Color.fromARGB(255, 241, 243, 246),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                          ),
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                ProfileOnMapWidget(
                                  name: vm.hunter.displayName,
                                  location: 'Nivel 1',
                                  profilePic: vm.hunter.photoUrl,
                                ),
                                SizedBox(
                                  //Looks like google api and flutter arent friends so size is defined like this for now
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height / 2,
                                  child: GoogleMap(
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, left: 8, right: 8),
                  child: Row(
                    children: <Widget>[
                      ButtonTheme(
                        height: 50,
                        child: Expanded(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.configurator);
                            },
                            color: primaryColor,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                            ),
                            child: Text(
                              "Iniciar jornada",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // create an instance of Location
    _location = new Location();

    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    _location.onLocationChanged.listen((LocationData cLoc) {
      // cLoc contains the lat anrd long of the
      // current user's position in real time,
      // so we're holding on to it
      _currentLocation = cLoc;

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
  final Hunter hunter;

  _ViewModel({@required this.hunter});
}
