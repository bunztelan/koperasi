import 'package:k2ms_v2/models/banner.dart';

abstract class BannerRepository {
  Future<List<BannerModel>> getBanner(String authToken);
}
