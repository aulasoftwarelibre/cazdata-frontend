import 'dart:convert';

import 'package:cazdata_frontend/model/journey.dart';
import 'package:cazdata_frontend/services/networking/index.dart';
import 'package:cazdata_frontend/util/url.dart';

class JourneyRepository {
  ApiProvider _provider = ApiProvider();

  Future<JourniesList> getJournies() async {
    final response = await _provider.get(Url.apiBaseUrl + "/journeys");

    JourniesList journiesList = JourniesList.fromJson(response);

    return journiesList;
  }

  Future<bool> postJourney(Journey journey, String tokenId) async {
    final String url = Url.apiBaseUrl + "/journeys/" + journey.id;

    var requestBody = jsonEncode(journey);
    final response = await _provider.post(url, requestBody, tokenId);

    return response;
  }
}
