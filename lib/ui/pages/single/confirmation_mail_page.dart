import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:k2ms_v2/config/color_config.dart';
import 'package:k2ms_v2/ui/pages/single/illustration_page.dart';
import 'package:k2ms_v2/ui/widgets/custom_snackbar.dart';
import 'package:open_mail_app/open_mail_app.dart';

class ConfirmationMailPage extends StatelessWidget {
  String status;
  TextEditingController _emailController = TextEditingController();

  ConfirmationMailPage({Key key, status}) : super(key: key);

  Future<void> _openMail(BuildContext context) async {
    var result = await OpenMailApp.openMailApp();

    if (!result.didOpen && !result.canOpen) {
      CustomSnackbar.showDangerSnackbar(
          context, 'Aplikasi email tidak ditemukan, buka melalui browser');
    } else if (!result.didOpen && result.canOpen) {
      // For iOS
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          vertical: 26,
          horizontal: 24,
        ),
        child: Form(
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
                'Email Konfirmasi Dikirm',
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
                  hintText: "Kode",
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: null,
                  child: Text(
                    'Konfirmasi',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: AppColor.textPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColor.primaryColor),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 16, horizontal: 50),
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
    );
  }
}
