import 'package:cazdata_frontend/model/animal.dart';
import 'package:cazdata_frontend/services/networking/index.dart';
import 'package:cazdata_frontend/util/url.dart';

class AnimalRepository {
  ApiProvider _provider = ApiProvider();

  Future<AnimalsList> getAnimals() async {
    AnimalsList animalsList;

    try {
      final response = await _provider.get(Url.apiBaseUrl + "/animals");
      animalsList = AnimalsList.fromJson(response);
    } catch (exeption) {}

    return animalsList;
  }
}
