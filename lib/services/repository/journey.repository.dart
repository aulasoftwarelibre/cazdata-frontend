import 'package:cazdata_frontend/model/journey.dart';
import 'package:cazdata_frontend/services/networking/index.dart';
import 'package:cazdata_frontend/util/url.dart';


class JourneyRepository {
  ApiProvider _provider = ApiProvider();

 Future<JourniesList> getJournies() async {
    final response =
        await _provider.get(Url.apiBaseUrl + "/journeys");


    JourniesList journiesList = JourniesList.fromJson(response);

    return journiesList;
  }
}