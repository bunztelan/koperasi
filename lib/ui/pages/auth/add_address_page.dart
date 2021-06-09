part of '../pages.dart';

class AddAddressPage extends StatefulWidget {
  AddAddressPage({Key key}) : super(key: key);

  @override
  _AddAddressPageState createState() {
    return _AddAddressPageState();
  }
}

class _AddAddressPageState extends State<AddAddressPage> {
  RegisterCubit _registerCubit;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _telpController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  String latitude = '';
  String longitude = '';

  @override
  void initState() {
    _registerCubit = RegisterCubit(RegisterRepositoryImp());

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Register
  void _register(BuildContext context) {
    FocusScope.of(context).unfocus();

    var data = Beamer.of(context).currentBeamLocation.state.data;

    if (!_formKey.currentState.validate()) {
      return;
    }

    if (latitude.trim().isEmpty && longitude.trim().isEmpty) {
      CustomSnackbar.showDangerSnackbar(
          context, 'Anda belum melakukan pin lokasi');
      return;
    }

    // TODO: This not use real data at all
    _registerCubit.register(
      data['name'],
      data['email'],
      data['password'],
      data['nip'],
      data['plant'],
      '1',
      _telpController.text.toString(),
      data['marital'],
      _addressController.text.toString(),
      _addressController.text.toString(),
      latitude,
      longitude,
      '1',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _registerCubit,
      child: BlocListener<RegisterCubit, RegisterState>(
        bloc: _registerCubit,
        listener: (context, state) {
          if (state is RegisterLoadingState) {
            LoadingDialog.showLoadingDialog(context, 'Mendaftarkan...');
          } else if (state is RegisterErrorState) {
            Navigator.pop(context);
            CustomSnackbar.showDangerSnackbar(context, state.message);
          } else if (state is RegisterLoadedState) {
            Navigator.pop(context);
            CustomSnackbar.showSuccessSnackbar(context, state.message);
          }
        },
        child: Scaffold(
          body: Container(
            color: AppColor.bodyColor,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 24),
                    CustomHeader(
                      title: 'Alamat',
                      subTitle: 'Pastikan alamat anda benar',
                    ),
                    SizedBox(height: 24),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 24),
                          Text("No Telp",
                              style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _telpController,
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if (val.trim().isEmpty) {
                                return 'Nomor telepon tidak boleh kosong';
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
                              hintText: "0811234567",
                            ),
                          ),
                          SizedBox(height: 16),
                          Text("Alamat",
                              style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _addressController,
                            validator: (val) {
                              if (val.trim().isEmpty) {
                                return 'Alamat tidak boleh kosong';
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
                              hintText:
                                  "Jl. Danau toba, no.10, Malang, Jawa Timur",
                            ),
                          ),
                          SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return MapPicker(
                                    onLatLongChange: (lat, long) {
                                      setState(() {
                                        latitude = lat;
                                        longitude = long;
                                      });
                                    },
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Pin lokasi anda pada map",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  '145DA0'.toColor()),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 50),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: AppColor.black30),
                              ),
                              child: Row(
                                children: [
                                  Icon(CupertinoIcons.placemark_fill,
                                      color: AppColor.primaryColor),
                                  SizedBox(width: 8),
                                  latitude.trim().isEmpty &&
                                          longitude.trim().isEmpty
                                      ? Text('Lokasi anda belum diset',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                  color:
                                                      AppColor.textDangerColor))
                                      : Text('Lokasi telah diset',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2)
                                ],
                              )),
                          SizedBox(height: 32),
                          TextButton(
                            onPressed: () {
                              _register(context);
                            },
                            child: Text(
                              "Daftar",
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
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
