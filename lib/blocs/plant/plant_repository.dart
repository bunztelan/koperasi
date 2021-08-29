import 'package:k2ms_v2/models/plant.dart';

abstract class PlantRepository {
  Future<List<Plant>> getPlant();
}
