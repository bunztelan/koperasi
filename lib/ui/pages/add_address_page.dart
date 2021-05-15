part of 'pages.dart';

class AddAddressPage extends StatefulWidget {
  AddAddressPage({Key key}) : super(key: key);

  @override
  _AddAddressPageState createState() {
    return _AddAddressPageState();
  }
}

class _AddAddressPageState extends State<AddAddressPage> {
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
        Beamer.of(context).popBeamLocation();
      },
      title: "Alamat",
      subtitle: "Pastikan alamat anda benar",
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("No Telp", style: Theme.of(context).textTheme.bodyText1),
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
                    hintText: "Masukkan no telp anda"),
              ),
            ),
            SizedBox(height: 16),
            Text("Alamat", style: Theme.of(context).textTheme.bodyText1),
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
                    hintText: "Masukkan Alamat Lengkap Anda"),
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: (){},
              child: Text(
                "Pin lokasi anda pada map",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>('145DA0'.toColor()),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 8, horizontal: 50),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  border: Border.all(color: AppColor.softGrayColor),
                ),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.placemark_fill,
                        color: AppColor.primaryColor),
                    SizedBox(width: 8),
                    Text("Jalan Joyo Raharjo 281 B")
                  ],
                )),
            SizedBox(height: 32),
            TextButton(
              onPressed:(){
                Beamer.of(context).beamToNamed(RouteName.generalConfirmationMail);
              },
              child: Text(
                "Daftar",
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
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
