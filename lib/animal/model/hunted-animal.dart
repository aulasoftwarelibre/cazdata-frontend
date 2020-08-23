import 'package:cazdata_frontend/animal/model/animal.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HuntedAnimal {
  Animal animal;
  LatLng position;

  HuntedAnimal({this.animal, this.position});
}
