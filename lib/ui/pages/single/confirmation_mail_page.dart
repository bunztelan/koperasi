import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:k2ms_v2/blocs/confirmation_email_register/cubit/confirmation_email_register_cubit.dart';
import 'package:k2ms_v2/config/color_config.dart';
import 'package:k2ms_v2/config/route/route_name.dart';
import 'package:k2ms_v2/ui/widgets/custom_snackbar.dart';
import 'package:k2ms_v2/ui/widgets/loading_dialog.dart';
import 'package:open_mail_app/open_mail_app.dart';

class ConfirmationMailPage extends StatefulWidget {
  ConfirmationMailPage({Key key}) : super(key: key);

  @override
  _ConfirmationMailPageState createState() => _ConfirmationMailPageState();
}

class _ConfirmationMailPageState extends State<ConfirmationMailPage> {
  TextEditingController _codeController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<CERegisterCubit>(context).initState();

    super.initState();
  }

  Future<void> _openMail(BuildContext context) async {
    var result = await OpenMailApp.openMailApp();

    if (!result.didOpen && !result.canOpen) {
      CustomSnackbar.showDangerSnackbar(
          context, 'Aplikasi email tidak ditemukan, buka melalui browser');
    } else if (!result.didOpen && result.canOpen) {
      // For iOS
    }
  }

  /// Open register success page
  Future<void> _openRegisterSuccess() {
    Navigator.pop(context);
    Beamer.of(context).beamStateHistory.clear();
    Beamer.of(context).beamLocationHistory.clear();
    Beamer.of(context).beamToNamed('${RouteName.generalSignUpSuccess}');
  }

  /// Confirmation register code
  Future<void> _confirmRegisterCode() async {
    LoadingDialog.showLoadingDialog(context, 'Konfirmasi...');
    BlocProvider.of<CERegisterCubit>(context)
        .confirmEmailCode(_codeController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<CERegisterCubit, CERegisterState>(
            listener: (context, state) {
              if (state is CERegisterErrorState) {
                Navigator.pop(context);
                CustomSnackbar.showDangerSnackbar(context, state.message);
              } else if (state is CERegisterLoadedState) {
                Navigator.pop(context);
                _openRegisterSuccess();
              }
            },
          )
        ],
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            vertical: 26,
            horizontal: 24,
          ),
          child: Center(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/mail_sent.png'),
                        height: 150,
                        width: 150,
                      ),
                      SizedBox(
                        height: 48,
                      ),
                      Text(
                        'Email Konfirmasi Dikirim',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Masukkan kode yang telah kami kirim ke email anda.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Color(0xFF8D92A3),
                            ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: _codeController,
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
                          hintText: "Kode",
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () => _confirmRegisterCode(),
                          child: Text(
                            'Konfirmasi',
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
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
                      GestureDetector(
                        onTap: () => _openMail(context),
                        child: Text(
                          'Buka Email',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: AppColor.textPrimaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
