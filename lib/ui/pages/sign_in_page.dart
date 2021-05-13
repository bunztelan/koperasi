part of 'pages.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends State<SignInPage> {
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
    return GeneralPage(
      title: "Masuk",
      subtitle: "Temukan berbagai produk koperasi",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Alamat Email", style: Theme.of(context).textTheme.bodyText1),
          SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black),
            ),
            child: TextField(
              //todo add controller
              style: GoogleFonts.poppins(fontSize: 14),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.poppins(
                    color: AppColor.softGrayColor,
                    fontSize: 14,
                  ),
                  hintText: "Ketikkan alamat email anda"),
            ),
          ),
          SizedBox(height: 16),
          Text("Kata sandi", style: Theme.of(context).textTheme.bodyText1),
          SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black),
            ),
            child: TextField(
              //todo add controller
              style: GoogleFonts.poppins(fontSize: 14),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.poppins(
                    color: AppColor.softGrayColor,
                    fontSize: 14,
                  ),
                  hintText: "Ketikkan kata sandi anda"),
            ),
          ),
          SizedBox(height: 16),
          GestureDetector(
            child: Text(
              "Lupa password ?",
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ),
          SizedBox(height: 24),
          TextButton(
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
                  EdgeInsets.symmetric(vertical: 16, horizontal: 50)),
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
                  EdgeInsets.symmetric(vertical: 16, horizontal: 50)),
            ),
          ),
        ],
      ),
    );
  }
}
