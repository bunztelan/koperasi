import 'package:k2ms_v2/blocs/banner/banner_repository.dart';
import 'package:k2ms_v2/models/banner.dart';
import 'package:k2ms_v2/services/services.dart';

class BannerRepositoryImp extends BannerRepository {
  @override
  Future<List<BannerModel>> getBanner(String authToken) async {
    try {
      var response = await BannerServices.getBanner(authToken);

      return response.value;
    } catch (e) {
      throw (e);
    }
  }
}
