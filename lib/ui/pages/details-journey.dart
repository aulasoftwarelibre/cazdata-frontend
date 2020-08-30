import 'package:auto_size_text/auto_size_text.dart';
import 'package:cazdata_frontend/models/journey/journey.dart';
import 'package:cazdata_frontend/ui/pages/journey.dart';
import 'package:cazdata_frontend/ui/widget/data-on-map.widget.dart';
import 'package:cazdata_frontend/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailsJourney extends StatelessWidget {
  final Journey journey;

  const DetailsJourney({
    this.journey,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime startTime = journey.startsAt;
    DateTime endTime = journey.endsAt;
    final int difference = endTime.difference(startTime).inMinutes;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    padding: EdgeInsets.zero,
                    iconSize: 50,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Detalle Jornada',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Información',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Center(
                            child: AutoSizeText(
                              journey.title + " | " + journey.startsAt.toString().substring(0, 10),
                              style: TextStyle(fontSize: 20),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              minFontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Card(
                            color: Color.fromARGB(255, 241, 243, 246),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            )),
                            child: Center(
                                child: Column(
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    DataOnMapWidget(
                                        distance: journey.distance.toString(),
                                        time: difference.toString(),
                                        calories: journey.calories.toString())
                                  ],
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height / 2,
                                  child: GoogleMap(
                                    myLocationEnabled: false,
                                    compassEnabled: true,
                                    rotateGesturesEnabled: true,
                                    scrollGesturesEnabled: true,
                                    tiltGesturesEnabled: false,
                                    zoomGesturesEnabled: true,
                                    zoomControlsEnabled: true,
                                    mapType: MapType.hybrid,
                                    polylines: Set<Polyline>.of([
                                      Polyline(
                                        polylineId: PolylineId("poly"),
                                        color: Color.fromARGB(255, 40, 122, 198),
                                        width: 7,
                                        points: journey.geopoints
                                            .map<LatLng>((e) => LatLng(e.latitude, e.longitude))
                                            .toList(),
                                      )
                                    ]),
                                    initialCameraPosition: CameraPosition(
                                        zoom: CAMERA_ZOOM,
                                        tilt: CAMERA_TILT,
                                        bearing: CAMERA_BEARING,
                                        target: LatLng(journey.geopoints[0].latitude, journey.geopoints[0].longitude)),
                                  ),
                                ),
                              ],
                            ))),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
