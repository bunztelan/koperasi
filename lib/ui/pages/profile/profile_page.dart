import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k2ms_v2/blocs/user/cubit/user_cubit.dart';
import 'package:k2ms_v2/config/route/profile_location.dart';
import 'package:k2ms_v2/config/route/route_name.dart';

import '../../../config/color_config.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserCubit _userCubit;

  @override
  void initState() {
    _userCubit = BlocProvider.of<UserCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      bloc: _userCubit,
      builder: (context, state) {
        if (state is UserLoadedState) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: AppColor.bodyColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DottedBorder(
                            dashPattern: [8, 8, 8, 8],
                            color: AppColor.mistyColor,
                            borderType: BorderType.RRect,
                            radius: Radius.circular(40),
                            padding: EdgeInsets.all(6),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              child: Container(
                                height: 70,
                                width: 70,
                                color: Colors.amber,
                                child: Image(
                                  image:
                                      AssetImage('assets/default_avatar.png'),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Text(
                            state.user.name,
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            state.user.email,
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: AppColor.black30,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Akun',
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          SizedBox(height: 24),
                          GestureDetector(
                            onTap: () {
                              Beamer.of(context).beamToNamed(
                                  '/${RouteName.userDashboard}/${RouteName.updateProfile}');
                            },
                            child: MenuCard('Ubah Profil'),
                          ),
                          SizedBox(height: 24),
                          MenuCard('Ubah Alamat'),
                          SizedBox(height: 24),
                          GestureDetector(
                            onTap: () {
                              Beamer.of(context)
                                  .beamToNamed(RouteName.authSignIn);
                            },
                            child: MenuCard('Keluar'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

/// Menu Card
class MenuCard extends StatelessWidget {
  final String title;

  MenuCard(this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        Icon(Icons.chevron_right)
      ],
    );
  }
}
