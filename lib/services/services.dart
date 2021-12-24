import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:k2ms_v2/models/category.dart';
import 'package:k2ms_v2/models/order.dart';
import 'package:k2ms_v2/models/ordered_item.dart';
import 'package:k2ms_v2/models/plant.dart';
import 'package:k2ms_v2/models/product.dart';
import 'package:k2ms_v2/models/response/api_return_value.dart';
import 'package:k2ms_v2/models/sign_in_value.dart';
import 'package:k2ms_v2/models/user.dart';
import 'package:k2ms_v2/models/banner.dart';

part 'plant_services.dart';
part 'user_services.dart';
part 'category_services.dart';
part 'product_services.dart';
part 'order_services.dart';
part 'banner_services.dart';
part 'forgot_password_services.dart';

const platform = 'customer';
const somethingWentWrongMsg = 'Terjadi kesalahan, coba lagi.';
const host_auth = 'https://api.kopkardenso.id/auth';
const host_plant = 'https://api.kopkardenso.id/plant';
const host_product = 'https://api.kopkardenso.id/product';
const host_order = 'https://api.kopkardenso.id/orders';
const host_user = 'https://api.kopkardenso.id/user';
const host_address = 'https://api.kopkardenso.id/address';
const host_file = 'https://api.kopkardenso.id/file';
const host_banner = 'https://api.kopkardenso.id/banner';
