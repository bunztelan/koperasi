import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k2ms_v2/blocs/token/cubit/token_cubit.dart';
import 'package:k2ms_v2/blocs/upload_photo/cubit/upload_photo_cubit.dart';
import 'package:k2ms_v2/blocs/user/cubit/user_cubit.dart';
import 'package:k2ms_v2/config/route/general_location.dart';
import 'package:k2ms_v2/config/route/route_name.dart';
import 'package:k2ms_v2/ui/widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/color_config.dart';

// Enum for camera and gallery
enum ImagePickerType { camera, file }
enum LogoutPickerType { logout, cancel }

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _profileImage; // Photo profile image
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker(); // Poster image
  bool _isUploadingPhoto = false;
  double _photoOpacity = 1.0;

  @override
  void initState() {
    super.initState();
  }

  /// Logout
  _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.clear();

    Beamer.of(context).clearBeamLocationHistory();
    Beamer.of(context).clearBeamStateHistory();

    Beamer.of(context).beamTo(GeneralLocation());
  }

  /// Handle image picker
  Future _handleImagePicker(ImagePickerType type, String userId) async {
    PickedFile pickedFile;
    const double MAX_WIDTH = 1080;
    const double MAX_HEIGHT = 1080;

    if (type == ImagePickerType.camera) {
      pickedFile = await _picker.getImage(
        maxHeight: MAX_HEIGHT,
        maxWidth: MAX_WIDTH,
        source: ImageSource.camera,
      );
    } else {
      pickedFile = await _picker.getImage(
        maxHeight: MAX_HEIGHT,
        maxWidth: MAX_WIDTH,
        source: ImageSource.gallery,
      );
    }

    if (pickedFile != null) {
      // Crop image
      File croppedImage = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        maxWidth: MAX_WIDTH.round(), // parse double to int with round()
        maxHeight: MAX_HEIGHT.round(), // parse double to int with round()
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        androidUiSettings: AndroidUiSettings(
          hideBottomControls: true,
        ),
      );

      if (croppedImage != null) {
        BlocProvider.of<UploadPhotoCubit>(context).uploadPhoto(
          authToken: context.read<TokenCubit>().state.token,
          filePath: croppedImage.path.toString(),
          email: context.read<UserCubit>().state.user.email,
          userId: context.read<UserCubit>().state.user.id.toString(),
        );

        setState(() {
          _isUploadingPhoto = true;
          _profileImage = File(croppedImage.path);
        });
      }
    }
  }

  /// Show picker menu
  Future _askedToImagePicker(BuildContext context, String userId) async {
    switch (await showDialog<ImagePickerType>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              'Ganti foto anda',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                onPressed: () {
                  Navigator.pop(context, ImagePickerType.camera);
                },
                child: Text('Buka kamera'),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                onPressed: () {
                  Navigator.pop(context, ImagePickerType.file);
                },
                child: Text(
                  'Ambil dari galeri',
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Batal',
                  style: TextStyle(color: AppColor.textDangerColor),
                ),
              )
            ],
          );
        })) {
      case ImagePickerType.camera:
        _handleImagePicker(ImagePickerType.camera, userId);
        break;
      case ImagePickerType.file:
        _handleImagePicker(ImagePickerType.file, userId);
        break;
      default:
    }
  }

  /// Show picker menu
  Future _askedToLogoutPicker(BuildContext context) async {
    switch (await showDialog<LogoutPickerType>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              'Apakah anda ingin keluar?',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                onPressed: () {
                  Navigator.pop(context, LogoutPickerType.logout);
                },
                child: Text('Keluar'),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                onPressed: () {
                  Navigator.pop(context, LogoutPickerType.cancel);
                },
                child: Text(
                  'Batal',
                  style: TextStyle(color: AppColor.textDangerColor),
                ),
              ),
            ],
          );
        })) {
      case LogoutPickerType.logout:
        _logout(context);
        break;
      case LogoutPickerType.cancel:
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
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
                          GestureDetector(
                            onTap: () => _askedToImagePicker(
                              context,
                              state.user.id.toString(),
                            ),
                            child: DottedBorder(
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
                                  color: AppColor.black70,
                                  child: Stack(
                                    children: [
                                      Opacity(
                                        opacity: _photoOpacity,
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          child: Image(
                                            fit: BoxFit.cover,
                                            image: context
                                                            .read<UserCubit>()
                                                            .state
                                                            .user
                                                            .avatar ==
                                                        null ||
                                                    context
                                                            .read<UserCubit>()
                                                            .state
                                                            .user
                                                            .avatar ==
                                                        'null'
                                                ? AssetImage(
                                                    'assets/default_avatar.png',
                                                  )
                                                : NetworkImage(
                                                    context
                                                        .read<UserCubit>()
                                                        .state
                                                        .user
                                                        .avatar,
                                                  ),
                                          ),
                                        ),
                                      ),
                                      BlocListener<UploadPhotoCubit,
                                          UploadPhotoState>(
                                        listener: (context, state) {
                                          if (state
                                              is UploadPhotoLoadingState) {
                                            setState(() {
                                              _photoOpacity = 0.2;
                                            });
                                          } else if (state
                                              is UploadPhotoLoadedState) {
                                            CustomSnackbar.showSuccessSnackbar(
                                                context,
                                                'Foto anda berhasil diubah');
                                            BlocProvider.of<UserCubit>(context)
                                                .updatePhoto(
                                              state.path,
                                              context
                                                  .read<UserCubit>()
                                                  .state
                                                  .user,
                                            );
                                            setState(() {
                                              _photoOpacity = 1;
                                            });
                                          } else if (state
                                              is UploadPhotoErrorState) {
                                            CustomSnackbar.showDangerSnackbar(
                                                context,
                                                'Terjadi kesalahan, coba lagi');
                                            setState(() {
                                              _photoOpacity = 1;
                                            });
                                          } else {
                                            setState(() {
                                              _photoOpacity = 1;
                                            });
                                          }
                                        },
                                        child: BlocBuilder<UploadPhotoCubit,
                                            UploadPhotoState>(
                                          builder: (context, state) {
                                            if (state
                                                is UploadPhotoLoadingState) {
                                              return Center(
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  child:
                                                      CircularProgressIndicator(
                                                    backgroundColor:
                                                        AppColor.primaryColor,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      AppColor
                                                          .primaryLighterColor,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            return Container();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
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
                                  '/${RouteName.userDashboard}/${RouteName.updateProfile}',
                                  data: {
                                    'userData':
                                        context.read<UserCubit>().state.user
                                  });
                            },
                            child: MenuCard('Ubah Profil'),
                          ),
                          SizedBox(height: 24),
                          GestureDetector(
                            onTap: () {
                              Beamer.of(context).beamToNamed(
                                  '/${RouteName.userDashboard}/${RouteName.updateAddress}');
                            },
                            child: MenuCard(
                              'Ubah Alamat',
                            ),
                          ),
                          SizedBox(height: 24),
                          GestureDetector(
                            onTap: () {
                              Beamer.of(context).beamToNamed(
                                  '/${RouteName.userDashboard}/${RouteName.authResetPassword}');
                            },
                            child: MenuCard(
                              'Ubah Kata Sandi',
                            ),
                          ),
                          SizedBox(height: 24),
                          GestureDetector(
                            onTap: () => _askedToLogoutPicker(context),
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
