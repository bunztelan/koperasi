import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:k2ms_v2/config/color_config.dart';
import 'package:k2ms_v2/config/route/general_location.dart';
import 'package:k2ms_v2/ui/widgets/custom_header.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() {
    return _ResetPasswordPageState();
  }
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _passwordSecured = true;
  bool _rePasswordSecured = true;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _rePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                  title: 'Reset Kata Sandi',
                  subTitle: 'Kata sandi baru',
                  backFunction: () =>
                      Beamer.of(context).beamTo(GeneralLocation()),
                  isBackIcon: false,
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
                          SizedBox(height: 16),
                          Text("Kata sandi Baru",
                              style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _passwordController,
                            validator: (val) {
                              if (val.trim().isEmpty) {
                                return 'Kata sandi tidak boleh kosong';
                              }
                              return null;
                            },
                            style: GoogleFonts.poppins(fontSize: 14),
                            obscureText: _passwordSecured,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 12),
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
                              hintText: "Sandi321",
                              // Here is key idea
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordSecured
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColor.primaryDarkColor,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordSecured = !_passwordSecured;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text("Konfirmasi Kata sandi",
                              style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _rePasswordController,
                            validator: (val) {
                              if (val.trim().isEmpty ||
                                  val != _passwordController.text.toString()) {
                                return 'Kata sandi anda harus sama dengan sebelumnya';
                              }
                              return null;
                            },
                            style: GoogleFonts.poppins(fontSize: 14),
                            obscureText: _rePasswordSecured,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 12),
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
                              hintText: "Sandi321",
                              // Here is key idea
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _rePasswordSecured
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColor.primaryDarkColor,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _rePasswordSecured = !_rePasswordSecured;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Ganti Kata Sandi",
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
