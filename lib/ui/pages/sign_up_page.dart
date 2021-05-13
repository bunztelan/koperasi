part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
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
      onBackPressed: () {
        print("back");
      },
      title: "Buat Akun",
      subtitle: "Daftar dan Pesan",
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Nama Lengkap", style: Theme.of(context).textTheme.bodyText1),
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
                    hintText: "Ketikkan nama lengkap anda"),
              ),
            ),
            SizedBox(height: 16),
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
            Text("Konfirmasi Kata sandi",
                style: Theme.of(context).textTheme.bodyText1),
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
                    hintText: "Ketikkan kembali kata sandi anda"),
              ),
            ),
            SizedBox(height: 16),
            Text("NIP", style: Theme.of(context).textTheme.bodyText1),
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
                    hintText: "Ketikkan Nomor Induk Pegawai anda"),
              ),
            ),
            SizedBox(height: 16),
            Text("Plant", style: Theme.of(context).textTheme.bodyText1),
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
                    hintText: "Pilih plant"),
              ),
            ),
            SizedBox(height: 24),
            TextButton(
              onPressed: () {},
              child: Text(
                "Lanjutkan",
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
                  EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
