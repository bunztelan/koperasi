import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:k2ms_v2/blocs/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:k2ms_v2/config/route/route_name.dart';
import 'package:k2ms_v2/ui/widgets/custom_snackbar.dart';
import 'package:k2ms_v2/ui/widgets/loading_dialog.dart';

import '../../../config/color_config.dart';
import '../../../config/route/general_location.dart';
import '../../widgets/custom_header.dart';

class SECPasswordPage extends StatefulWidget {
  SECPasswordPage({Key key}) : super(key: key);

  @override
  SECPasswordPageState createState() {
    return SECPasswordPageState();
  }
}

class SECPasswordPageState extends State<SECPasswordPage> {
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _sendCode() {
    LoadingDialog.showLoadingDialog(context, 'Kirim email...');
    String email = _emailController.text.toString().trim();
    if (_formKey.currentState.validate()) {
      BlocProvider.of<ForgotPasswordCubit>(context).sendCodeToEmail(email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordErrorState) {
              Navigator.pop(context);
              CustomSnackbar.showDangerSnackbar(context, state.message);
            } else if (state is ForgotPasswordLoadedState) {
              Navigator.pop(context);
              Beamer.of(context).beamToNamed(
                  '/${RouteName.authSECPassword}/${RouteName.generalConfirmationMail}/forgot_password');
            }
          },
          child: Container(
            color: AppColor.bodyColor,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomHeader(
                    title: 'Lupa Kata Sandi',
                    subTitle: 'Masukkan email anda',
                    backFunction: () =>
                        Beamer.of(context).beamTo(GeneralLocation()),
                  ),
                  SizedBox(height: 24),
                  Container(
                    padding: EdgeInsets.all(24),
                    color: Colors.white,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
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
                          SizedBox(height: 24),
                          TextButton(
                            onPressed: _sendCode,
                            child: Text(
                              "Konfirmasi",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
