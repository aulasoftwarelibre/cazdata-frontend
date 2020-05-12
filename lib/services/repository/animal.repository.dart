import 'package:cazdata_frontend/model/animal.dart';
import 'package:cazdata_frontend/services/networking/index.dart';
import 'package:cazdata_frontend/util/url.dart';


class AnimalRepository {
  ApiProvider _provider = ApiProvider();

 Future<AnimalsList> getAnimals() async {
    final response =
        await _provider.get(Url.apiBaseUrl + "/animals");


    AnimalsList animalsList = AnimalsList.fromJson(response);

    return animalsList;
  }
}
