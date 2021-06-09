import 'package:dio/dio.dart';
import 'package:k2ms_v2/models/plant.dart';
import 'package:k2ms_v2/models/response/api_return_value.dart';
import 'package:k2ms_v2/models/user.dart';

part 'plant_services.dart';
part 'user_services.dart';

const platform = 'customer';
const somethingWentWrongMsg = 'Terjadi kesalahan, coba lagi.';
const host_auth = 'https://data.dev-k2ms.com/auth';
const host_plant = 'https://data.dev-k2ms.com/plant';
