import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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

const platform = 'customer';
const somethingWentWrongMsg = 'Terjadi kesalahan, coba lagi.';
const host_auth = 'https://data.dev-k2ms.com/auth';
const host_plant = 'https://data.dev-k2ms.com/plant';
const host_product = 'https://data.dev-k2ms.com/product';
const host_order = 'https://data.dev-k2ms.com/orders';
const host_user = 'https://data.dev-k2ms.com/user';
const host_address = 'https://data.dev-k2ms.com/address';
const host_file = 'https://data.dev-k2ms.com/file';
const host_banner = 'https://data.dev-k2ms.com/banner';
