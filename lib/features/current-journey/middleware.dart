import 'package:cazdata_frontend/models/journey/journey.dart';
import 'package:cazdata_frontend/features/current-journey/actions.dart';
import 'package:cazdata_frontend/models/journey/journey.repository.dart';
import 'package:cazdata_frontend/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction postCurrentJourneyAction(Journey journey, String userId, BuildContext context) {
  JourneyRepository _journeyRepository = new JourneyRepository();

  return (Store store) async {
    new Future(() async {
      store.dispatch(new SendJourneyRequestAction());
      _journeyRepository.postJourney(journey, userId).then((journey) async {
        store.dispatch(new SendJourneySuccessAction());
        Navigator.pushNamed(context, Routes.home);
      }, onError: (error) {
        store.dispatch(new SendJourneyFailureAction());
      });
    });
  };
}
