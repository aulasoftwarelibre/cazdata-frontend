import 'dart:async';

import 'package:cazdata_frontend/model/hunted-animal.dart';
import 'package:cazdata_frontend/model/journey.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/ui/widget/bottom-navigation-bar.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //Map markers
  Set<Marker> _markers = Set<Marker>();

  // the user's initial location and current location
  // as it moves
  LocationData _currentLocation;
  // wrapper around the location API
  Location _location;

  // this will hold the generated polylines
  Set<Polyline> _polylines = {};
  // this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) => _homeView(context, vm),
    );
  }

  Widget _homeView(BuildContext context, _ViewModel vm) {
    List<SpeedDialChild> buttons = [];
    for (int i = 0; i < vm.currentJourneyState.selectedAnimals.length; i++) {
      buttons.add(SpeedDialChild(
          child: FittedBox(
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  vm.currentJourneyState.selectedAnimals[i].contentUrl),
              backgroundColor: Colors.transparent,
            ),
          ),
          label: vm.currentJourneyState.selectedAnimals[i].name,
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            LatLng current =
                LatLng(_currentLocation.latitude, _currentLocation.longitude);
            HuntedAnimal huntedAnimal = HuntedAnimal(
                animal: vm.currentJourneyState.selectedAnimals[i],
                position: current);
            vm.addHuntedAnimal(huntedAnimal);

            final snackBar = SnackBar(
              content: Text('Se ha cazado: ' +
                  vm.currentJourneyState.selectedAnimals[i].name),
              backgroundColor: accentColor,
            );

            _scaffoldKey.currentState.showSnackBar(snackBar);
          }));
    }
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
      key: _scaffoldKey,
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
          polylines: _polylines,
          initialCameraPosition: initialCameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            setPolylines();
          },
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ButtonTheme(
                  child: Row(
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {
                            vm.saveJourney(vm.currentJourneyState.journey);
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return MaterialApp(
                                    title: 'Jornada',
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
                            size: 22,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        visible: true,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: buttons,
      ),
    );
  }

  setPolylines() async {
    setState(() {
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          width: 7,
          points: polylineCoordinates);
      _polylines.add(polyline);
    });
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
        //Update camera position as the user moves
        _currentLocation = cLoc;

        LatLng current = LatLng(cLoc.latitude, cLoc.longitude);

        polylineCoordinates.add(current);
      });

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
  final CurrentJourneyState currentJourneyState;
  final Function(Journey) saveJourney;
  final Function(HuntedAnimal) addHuntedAnimal;

  _ViewModel(
      {@required this.currentJourneyState,
      @required this.saveJourney,
      @required this.addHuntedAnimal});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      currentJourneyState: store.state.currentJourneyState,
      saveJourney: (Journey journey) {
        store.dispatch(
            postCurrentJourney(journey, store.state.firebaseState.idTokenUser));
      },
      addHuntedAnimal: (HuntedAnimal huntedAnimal) {
        store.dispatch(AddHuntedAnimalAction(huntedAnimal));
      },
    );
  }
}
