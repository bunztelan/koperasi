import 'dart:math';

import 'package:beamer/beamer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:k2ms_v2/blocs/category/category_repository_imp.dart';
import 'package:k2ms_v2/blocs/category/cubit/category_cubit.dart';
import 'package:k2ms_v2/blocs/plant/cubit/plant_cubit.dart';
import 'package:k2ms_v2/blocs/plant/plant_repository_imp.dart';
import 'package:k2ms_v2/blocs/register/cubit/register_cubit.dart';
import 'package:k2ms_v2/blocs/register/register_repository_imp.dart';
import 'package:k2ms_v2/blocs/sign_in/cubit/sign_in_cubit.dart';
import 'package:k2ms_v2/blocs/sign_in/sign_in_repository_impl.dart';
import 'package:k2ms_v2/blocs/user/cubit/user_cubit.dart';
import 'package:k2ms_v2/config/color_config.dart';
import 'package:k2ms_v2/config/route/dashboard_location.dart';
import 'package:k2ms_v2/config/route/general_location.dart';
import 'package:k2ms_v2/config/route/order_location.dart';
import 'package:k2ms_v2/config/route/route_name.dart';
import 'package:k2ms_v2/models/plant.dart';
import 'package:k2ms_v2/models/user.dart';
import 'package:k2ms_v2/ui/pages/order/order_list_page.dart';
import 'package:k2ms_v2/ui/pages/profile/profile_page.dart';
import 'package:k2ms_v2/ui/widgets/custom_header.dart';
import 'package:k2ms_v2/ui/widgets/custom_snackbar.dart';
import 'package:k2ms_v2/ui/widgets/loading_dialog.dart';
import 'package:k2ms_v2/ui/widgets/map_picker.dart';
import 'package:k2ms_v2/ui/widgets/widgets.dart';
import 'package:supercharged/supercharged.dart';

part 'auth/add_address_page.dart';
part 'auth/sign_in_page.dart';
part 'auth/sign_up_page.dart';
part 'dashboard_page.dart';
part 'general_page.dart';
part 'home_page.dart';
part 'product_detail_page.dart';
part 'profile/update_address_page.dart';
part 'profile/update_profile_page.dart';
