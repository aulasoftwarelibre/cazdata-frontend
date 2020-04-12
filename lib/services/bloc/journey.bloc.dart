import 'dart:async';

import 'package:cazdata_frontend/model/journey.dart';
import 'package:cazdata_frontend/services/networking/index.dart';
import 'package:cazdata_frontend/services/repository/journey.repository.dart';
import 'package:rxdart/subjects.dart';

class JourneyBloc {
  JourneyRepository _journeyRepository;
  StreamController _journeyController;

  StreamSink<Response<JourniesList>> get journeySinkJourneys =>
      _journeyController.sink;
  Stream<Response<JourniesList>> get journeyStreamJourneys =>
      _journeyController.stream;

  JourneyBloc() {
    _journeyRepository = new JourneyRepository();
    _journeyController = BehaviorSubject<Response<JourniesList>>();
  }

  getJournies() async {
    _journeyController.add(Response.loading('Get journeys.'));
    try {
      JourniesList journeyResponse = await _journeyRepository.getJournies();

      _journeyController.add(Response.completed(journeyResponse));
    } catch (e) {
      _journeyController.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _journeyController?.close();
  }
}
