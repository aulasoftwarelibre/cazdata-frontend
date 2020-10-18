import 'package:cazdata_frontend/models/animal/hunted-animal.dart';

Map<HuntedAnimal, int> getNumberOfOccurrences(List<HuntedAnimal> huntedAnimals) {
  Map<String, int> huntedAnimalsIdsCount = new Map<String, int>();

  for (int i = 0; i < huntedAnimals.length; i++) {
    huntedAnimalsIdsCount.update(huntedAnimals[i].animal.id, (v) => v = v + 1, ifAbsent: () => 1);
  }

  Map<HuntedAnimal, int> huntedAnimalsWithCounts = new Map<HuntedAnimal, int>();

  huntedAnimalsIdsCount.forEach((huntedAnimalId, huntedAnimalCount) {
    huntedAnimalsWithCounts[_getHuntedAnimalById(huntedAnimals, huntedAnimalId)] = huntedAnimalCount;
  });

  return huntedAnimalsWithCounts;
}

HuntedAnimal _getHuntedAnimalById(List<HuntedAnimal> huntedAnimals, String huntedAnimalId) {
  return huntedAnimals.firstWhere((huntedAnimal) => huntedAnimal.animal.id == huntedAnimalId);
}
