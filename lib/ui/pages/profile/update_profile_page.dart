part of '../pages.dart';

enum UpdateMaritalStatus { SINGLE, MARIED }

class UpdateProfilePage extends StatefulWidget {
  UpdateProfilePage({Key key}) : super(key: key);

  @override
  _UpdateProfilePageState createState() {
    return _UpdateProfilePageState();
  }
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  PlantCubit _plantCubit;

  UpdateMaritalStatus _marital = UpdateMaritalStatus.SINGLE;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  String _nipText = '';
  TextEditingController _plantController = TextEditingController();
  List<Plant> _plants = [];
  String _selectedPlant = '0';

  @override
  void initState() {
    _plantCubit = PlantCubit(PlantRepositoryImp())..getPlant();
    _nameController.text = BlocProvider.of<UserCubit>(context).state.user.name;
    _emailController.text =
        BlocProvider.of<UserCubit>(context).state.user.email;
    _nipText = BlocProvider.of<UserCubit>(context).state.user.nip;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Set initial plant to form
  String _initialPlantForm(int initialId) {
    for (int i = 0; i < _plants.length; i++) {
      if (_plants[i].id == initialId) {
        return _plants[i].name;
      }
    }
    return '';
  }

  /// Set initial marital status
  void _initialMaritalForm(String status) {
    if (status.toLowerCase() == 'SINGLE'.toLowerCase()) {
      setState(() {
        _marital = UpdateMaritalStatus.SINGLE;
      });
    } else {
      setState(() {
        _marital = UpdateMaritalStatus.MARIED;
      });
    }
  }

  /// Update profile
  void _updateProfile() {
    LoadingDialog.showLoadingDialog(context, 'Menunggu...');

    if (_formKey.currentState.validate()) {
      BlocProvider.of<UpdateProfileCubit>(context).updateProfile(
        authToken: context.read<TokenCubit>().state.token,
        id: context.read<UserCubit>().state.user.id.toString(),
        name: _nameController.text.toString(),
        email: _emailController.text.toString(),
        maritalStatus:
            _marital == UpdateMaritalStatus.MARIED ? 'MARIED' : 'SINGLE',
        nip: _nipText,
        plantId: _selectedPlant,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocListener<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) {
          if (state is UpdateProfileLoadedState) {
            Navigator.pop(context);
            CustomSnackbar.showSuccessSnackbar(
                context, 'Profile berhasil diperbaruhi.');
            BlocProvider.of<UserCubit>(context).updateProfile(
              name: _nameController.text,
              email: _emailController.text,
              maritalStatus:
                  _marital == UpdateMaritalStatus.MARIED ? 'maried' : 'single',
              nip: _nipText,
              plantId: _selectedPlant,
              oldUser: context.read<UserCubit>().state.user,
            );
          } else if (state is UpdateProfileErrorState) {
            Navigator.pop(context);
            CustomSnackbar.showDangerSnackbar(context, state.message);
          }
        },
        child: Container(
          color: AppColor.bodyColor,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomHeader(
                  title: 'Perbaruhi profil',
                  subTitle: 'Isi data secara lengkap',
                  backFunction: () => Navigator.pop(context),
                ),
                SizedBox(height: 24),
                Form(
                  child: Container(
                    padding: EdgeInsets.all(24),
                    color: Colors.white,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Nama Lengkap",
                              style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _nameController,
                            validator: (val) {
                              if (val.trim().isEmpty) {
                                return 'Nama lengkap tidak boleh kosong.';
                              }
                              return null;
                            },
                            style: GoogleFonts.poppins(fontSize: 14),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: AppColor.primaryColor,
                                  width: 1,
                                ),
                              ),
                              hintStyle: GoogleFonts.poppins(
                                color: AppColor.softGrayColor,
                                fontSize: 14,
                              ),
                              hintText: "Bambang setiawan",
                            ),
                          ),
                          SizedBox(height: 16),
                          Text("Alamat Email",
                              style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _emailController,
                            validator: (val) {
                              if (val.trim().isEmpty) {
                                return 'Alamat email tidak boleh kosong';
                              }
                              return null;
                            },
                            style: GoogleFonts.poppins(fontSize: 14),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: AppColor.primaryColor,
                                  width: 1,
                                ),
                              ),
                              hintStyle: GoogleFonts.poppins(
                                color: AppColor.softGrayColor,
                                fontSize: 14,
                              ),
                              hintText: "bambang@gmail.com",
                            ),
                          ),
                          BlocProvider(
                            create: (context) => _plantCubit,
                            child: Builder(
                              builder: (context) {
                                return BlocListener<PlantCubit, PlantState>(
                                  bloc: BlocProvider.of<PlantCubit>(context),
                                  listener: (context, state) {
                                    if (state is PlantLoadedState) {
                                      _plants = state.plants;
                                      _plantController.text = _initialPlantForm(
                                          BlocProvider.of<UserCubit>(context)
                                              .state
                                              .user
                                              .plantId);
                                      _selectedPlant =
                                          BlocProvider.of<UserCubit>(context)
                                              .state
                                              .user
                                              .plantId
                                              .toString();
                                      _initialMaritalForm(
                                          BlocProvider.of<UserCubit>(context)
                                              .state
                                              .user
                                              .status);
                                    }
                                  },
                                  child: Container(),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 24),
                          TextButton(
                            onPressed: _updateProfile,
                            child: Text(
                              "Perbaruhi",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColor.textPrimaryColor,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColor.primaryColor),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 50),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
