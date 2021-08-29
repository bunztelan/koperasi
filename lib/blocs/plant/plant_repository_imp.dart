import 'package:k2ms_v2/blocs/plant/plant_repository.dart';
import 'package:k2ms_v2/models/plant.dart';
import 'package:k2ms_v2/services/services.dart';

class PlantRepositoryImp extends PlantRepository {
  @override
  Future<List<Plant>> getPlant() async {
    try {
      var response = await PlantServices.getPlant();
      return response.value;
    } catch (e) {
      throw (e);
    }
  }
}
