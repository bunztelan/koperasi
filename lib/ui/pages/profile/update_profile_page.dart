part of '../pages.dart';

enum UpdateMaritalStatus { SINGLE, MARIED }

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() {
    return _UpdateProfilePageState();
  }
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();

  UpdateMaritalStatus _marital = UpdateMaritalStatus.SINGLE;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nipController = TextEditingController();
  TextEditingController _plantController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  /// Next Step
  void _nextStep() {
    if (_formKey.currentState.validate()) {
      Beamer.of(context).beamToNamed(
        '/${RouteName.authSignUp}/${RouteName.userManageAddress}',
        data: {
          'name': _nameController.text.toString(),
          'email': _emailController.text.toString(),
          'nip': _nipController.text.toString(),
          'plant': _plantController.text.toString(),
          'marital':
              _marital == UpdateMaritalStatus.MARIED ? 'MARIED' : 'SINGLE'
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColor.bodyColor,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomHeader(
                  title: 'Perbaruhi Profile',
                  subTitle: 'Tulis profil anda dengan benar',
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
                          Text("Status Pernikahan",
                              style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(height: 6),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 7),
                            decoration: BoxDecoration(
                                color: AppColor.black70,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  children: [
                                    Radio<UpdateMaritalStatus>(
                                      activeColor: AppColor.textPrimaryColor,
                                      value: UpdateMaritalStatus.SINGLE,
                                      groupValue: _marital,
                                      onChanged: (UpdateMaritalStatus value) {
                                        setState(() {
                                          _marital = value;
                                        });
                                      },
                                    ),
                                    Text('Lajang'),
                                  ],
                                ),
                                SizedBox(width: 24),
                                Row(
                                  children: [
                                    Radio<UpdateMaritalStatus>(
                                      value: UpdateMaritalStatus.MARIED,
                                      activeColor: AppColor.textPrimaryColor,
                                      groupValue: _marital,
                                      onChanged: (UpdateMaritalStatus value) {
                                        setState(() {
                                          _marital = value;
                                        });
                                      },
                                    ),
                                    Text('Menikah'),
                                  ],
                                ),
                              ],
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
                          SizedBox(height: 16),
                          Text("NIP",
                              style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _nipController,
                            validator: (val) {
                              if (val.trim().isEmpty) {
                                return 'NIP tidak boleh kosong';
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
                              hintText: "199802122015051003",
                            ),
                          ),
                          SizedBox(height: 16),
                          Text("Plant",
                              style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _plantController,
                            validator: (val) {
                              if (val.trim().isEmpty) {
                                return 'Plant tidak boleh kosong';
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
                              hintText: "Plant A",
                            ),
                          ),
                          SizedBox(height: 24),
                          TextButton(
                            onPressed: () {
                              _nextStep();
                            },
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
      ),
    );
  }
}
