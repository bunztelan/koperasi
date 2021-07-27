import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:k2ms_v2/blocs/change_password/cubit/change_password_cubit.dart';
import 'package:k2ms_v2/blocs/logged_change_password/cubit/logged_change_password_cubit.dart';
import 'package:k2ms_v2/blocs/token/cubit/token_cubit.dart';
import 'package:k2ms_v2/blocs/user/cubit/user_cubit.dart';
import 'package:k2ms_v2/config/color_config.dart';
import 'package:k2ms_v2/ui/widgets/custom_header.dart';
import 'package:k2ms_v2/ui/widgets/custom_snackbar.dart';
import 'package:k2ms_v2/ui/widgets/loading_dialog.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() {
    return _ResetPasswordPageState();
  }
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _oldPasswordSecured = true;
  bool _passwordSecured = true;
  bool _rePasswordSecured = true;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _oldPasswordController = TextEditingController();
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

  Future<void> _changePassword() async {
    FocusScope.of(context).unfocus();
    LoadingDialog.showLoadingDialog(context, 'Mengganti...');

    if (_formKey.currentState.validate()) {
      BlocProvider.of<LCPasswordCubit>(context).changePassword(
        authToken: context.read<TokenCubit>().state.token,
        newPassword: _passwordController.text,
        oldPassword: _oldPasswordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LCPasswordCubit, LCPasswordState>(
      listener: (context, state) {
        if (state is LCPasswordErrorState) {
          Navigator.pop(context);
          CustomSnackbar.showDangerSnackbar(context, state.message);
        } else if (state is LCPasswordLoadedState) {
          Navigator.pop(context);
          CustomSnackbar.showSuccessSnackbar(
              context, 'Kata sandi anda berhasil diubah.');
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            color: AppColor.bodyColor,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomHeader(
                    title: 'Ganti Kata Sandi',
                    subTitle: 'Kata sandi baru',
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
                            Text("Kata sandi lama",
                                style: Theme.of(context).textTheme.bodyText1),
                            SizedBox(height: 6),
                            TextFormField(
                              controller: _oldPasswordController,
                              validator: (val) {
                                if (val.trim().isEmpty) {
                                  return 'Kata sandi tidak boleh kosong';
                                }
                                return null;
                              },
                              style: GoogleFonts.poppins(fontSize: 14),
                              obscureText: _oldPasswordSecured,
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
                                    _oldPasswordSecured
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppColor.primaryDarkColor,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _oldPasswordSecured =
                                          !_oldPasswordSecured;
                                    });
                                  },
                                ),
                              ),
                            ),
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
                                    val !=
                                        _passwordController.text.toString()) {
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
                              onPressed: _changePassword,
                              child: Text(
                                "Ganti Kata Sandi",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.textPrimaryColor,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
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
      ),
    );
  }
}
