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
    print(Beamer.of(context).currentBeamLocation.state.data['name']);

    return Scaffold(
      body: Container(
        color: AppColor.bodyColor,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24),
              CustomHeader(
                title: 'Alamat',
                subTitle: 'Pastikan alamat anda benar',
              ),
              SizedBox(height: 24),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 24),
                    Text("No Telp",
                        style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(height: 6),
                    TextFormField(
                      validator: (val) {
                        if (val.trim().isEmpty) {
                          return 'Nomor telepon tidak boleh kosong';
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
                        hintText: "0811234567",
                      ),
                    ),
                    SizedBox(height: 16),
                    Text("Alamat",
                        style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(height: 6),
                    TextFormField(
                      validator: (val) {
                        if (val.trim().isEmpty) {
                          return 'Alamat tidak boleh kosong';
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
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Pin lokasi anda pada map",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            '145DA0'.toColor()),
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
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: AppColor.black30),
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
                      onPressed: () {
                        Beamer.of(context)
                            .beamToNamed(RouteName.generalConfirmationMail);
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
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColor.primaryColor),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
