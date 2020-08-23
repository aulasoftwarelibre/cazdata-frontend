import 'package:cazdata_frontend/models/journey/journey.dart';
import 'package:cazdata_frontend/features/current-journey/actions.dart';
import 'package:cazdata_frontend/models/journey/journey.repository.dart';
import 'package:cazdata_frontend/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction postCurrentJourneyAction(BuildContext context, Journey journey, String userId, List<LatLng> polylines) {
  JourneyRepository _journeyRepository = new JourneyRepository();

  return (Store store) async {
    new Future(() async {
      store.dispatch(new SendJourneyRequestAction());
      _journeyRepository.postJourney(journey, userId, polylines).then((journey) async {
        store.dispatch(new SendJourneySuccessAction());
        Navigator.pushNamed(context, Routes.home);
      }, onError: (error) {
        store.dispatch(new SendJourneyFailureAction());
      });
    });
  };
}
