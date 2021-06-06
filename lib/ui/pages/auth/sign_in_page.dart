part of '../pages.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends State<SignInPage> {
  // Initially password is obscure
  bool _passwordSecured = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  SignInCubit _signInCubit = SignInCubit(SignInRepositoryImp());

  /// Login
  void _login(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState.validate()) {
      LoadingDialog.showLoadingDialog(context, 'Konfirmasi...');
      _signInCubit.login(
        _emailController.text.toString(),
        _passwordController.text.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _signInCubit,
      child: BlocListener<SignInCubit, SignInState>(
        listener: (context, state) async {
          if (state is SignInErrorState) {
            Navigator.pop(context);
            CustomSnackbar.showDangerSnackbar(context, state.message);
          } else if (state is SignInLoadedState) {
            Navigator.pop(context);
            Beamer.of(context).clearBeamStateHistory();
            Beamer.of(context).clearBeamLocationHistory();
            Beamer.of(context).beamTo(DashboardLocation());
          }
        },
        child: GeneralPage(
          title: "Masuk",
          subtitle: "Temukan berbagai produk koperasi",
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
                SizedBox(height: 16),
                Text("Kata sandi",
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 18, horizontal: 12),
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
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    child: Text(
                      "Lupa password ?",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 48),
                TextButton(
                  onPressed: () {
                    _login(context);
                  },
                  child: Text(
                    "Masuk",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textPrimaryColor,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColor.primaryColor),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 50,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextButton(
                  child: Text(
                    "Buat Akun Baru",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>('8D92A3'.toColor()),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 50,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Beamer.of(context).beamToNamed('/${RouteName.authSignUp}');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
