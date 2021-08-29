import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:k2ms_v2/blocs/confirmation_email_register/cubit/confirmation_email_register_cubit.dart';
import 'package:k2ms_v2/blocs/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:k2ms_v2/config/color_config.dart';
import 'package:k2ms_v2/config/route/general_location.dart';
import 'package:k2ms_v2/config/route/route_name.dart';
import 'package:k2ms_v2/ui/widgets/custom_header.dart';
import 'package:k2ms_v2/ui/widgets/custom_snackbar.dart';
import 'package:k2ms_v2/ui/widgets/loading_dialog.dart';
import 'package:open_mail_app/open_mail_app.dart';

class RFPasswordPage extends StatefulWidget {
  String email;

  RFPasswordPage({Key key, this.email}) : super(key: key);

  @override
  RFPasswordPageState createState() => RFPasswordPageState();
}

class RFPasswordPageState extends State<RFPasswordPage> {
  TextEditingController _codeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _rePasswordController = TextEditingController();
  bool _passwordSecured = true;
  bool _rePasswordSecured = true;
  final _formKey = GlobalKey<FormState>();
  Timer _timer;
  static const int LIMIT_TIMER = 59;
  int _start;
  bool timerOnProg = false;

  @override
  void initState() {
    _start = LIMIT_TIMER;

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            _start = LIMIT_TIMER;
            timerOnProg = false;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  /// Resend code to email
  Future<void> _resendCode() async {
    if (!timerOnProg) {
      LoadingDialog.showLoadingDialog(context, 'Mengirim...');
      BlocProvider.of<ForgotPasswordCubit>(context)
          .sendCodeToEmail(widget.email);
    }
  }

  /// Open mail
  Future<void> _openMail(BuildContext context) async {
    var result = await OpenMailApp.openMailApp();

    if (!result.didOpen && !result.canOpen) {
      CustomSnackbar.showDangerSnackbar(
          context, 'Aplikasi email tidak ditemukan, buka melalui browser');
    } else if (!result.didOpen && result.canOpen) {
      // For iOS
    }
  }

  Future<void> _resetForgotPassword() async {
    if (_formKey.currentState.validate()) {
      LoadingDialog.showLoadingDialog(context, 'Mengganti...');
      BlocProvider.of<ForgotPasswordCubit>(context).resetForgotPassword(
        password: _passwordController.text,
        passwordToken: _codeController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) async {
              if (state is ForgotPasswordErrorState) {
                CustomSnackbar.showDangerSnackbar(context, state.message);
              } else if (state is ForgotPasswordLoadedState) {
                CustomSnackbar.showSuccessSnackbar(
                    context, 'Kode berhasil dikirim.');
                setState(() {
                  timerOnProg = true;
                });
                _startTimer();
              } else if (state is ForgotPasswordUpdatedState) {
                Navigator.pop(context);

                Beamer.of(context).beamStateHistory.clear();
                Beamer.of(context).beamLocationHistory.clear();
                Beamer.of(context).beamToNamed(
                  '/${RouteName.generalForgotPasswordSuccess}',
                );
              }
            },
          )
        ],
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(
            vertical: 26,
          ),
          color: AppColor.bodyColor,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomHeader(
                    title: 'Kata sandi Baru',
                    subTitle: 'Masukkan kata sandi baru',
                    backFunction: () => Beamer.of(context).popRoute(),
                  ),
                  SizedBox(height: 16),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email Konfirmasi Dikirim',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                              ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        RichText(
                          text: TextSpan(
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: Color(0xFF8D92A3),
                                    ),
                            children: [
                              TextSpan(
                                text:
                                    'Masukkan kode yang telah kami kirim ke email anda. Tidak mendapat kode ?',
                              ),
                              TextSpan(text: ' '),
                              TextSpan(
                                text: timerOnProg
                                    ? 'Kirim lagi (00:$_start)'
                                    : 'Kirim ulang kode',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _resendCode();
                                  },
                                style: timerOnProg
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                          color: Color(0xFF8D92A3),
                                        )
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                          color: AppColor.primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
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
                        SizedBox(
                          height: 16,
                        ),
                        Text("Kode",
                            style: Theme.of(context).textTheme.bodyText1),
                        SizedBox(height: 6),
                        TextFormField(
                          controller: _codeController,
                          validator: (val) {
                            if (val.trim().isEmpty) {
                              return 'Kode tidak boleh kosong';
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
                            hintText: "Kode",
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Container(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: _resetForgotPassword,
                            child: Text(
                              'Reset Kata Sandi',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: AppColor.textPrimaryColor,
                                    fontWeight: FontWeight.w600,
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
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () => _openMail(context),
                            child: Text(
                              'Buka Email',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: AppColor.textPrimaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        )
                      ],
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
