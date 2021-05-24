part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage({Key key}) : super(key: key);

  @override
  _CheckoutPageState createState() {
    return _CheckoutPageState();
  }
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: "Pesanan Anda",
      subtitle: "Periksa kembali pesanan anda",
      onBackPressed: () {},
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Daftar Pesanan",
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: AppColor.textPrimaryColor,
                  ),
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              child: ListView.builder(
                itemCount: Product.mockProducts.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    width: double.infinity,
                    child: Row(children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                Product.mockProducts[index].picture),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Product.mockProducts[index].name),
                            Text(
                              NumberFormat.currency(
                                symbol: "IDR ",
                                decimalDigits: 0,
                                locale: "id-ID",
                              ).format(Product.mockProducts[index].price),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.softGrayColor,
                                    fontSize: 14,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "14 item",
                      ),
                    ]),
                  );
                },
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Harga Total",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                ),
                Text(
                  NumberFormat.currency(
                    symbol: "IDR ",
                    decimalDigits: 0,
                    locale: "id-ID",
                  ).format(10000),
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                ),
              ],
            ),
            SizedBox(height: 36),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Diantarkan ke ",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: AppColor.textPrimaryColor,
                        ),
                  ),
                  SizedBox(height:16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nama ",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: AppColor.textHintColor,
                            ),
                      ),
                      Text(
                        "Angga Rizky",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: AppColor.textPrimaryColor,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height:8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "No Telp ",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: AppColor.textHintColor,
                            ),
                      ),
                      Text(
                        "08224556333",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: AppColor.textPrimaryColor,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height:8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Alamat ",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: AppColor.textHintColor,
                            ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 160,
                        child: Text(
                          "Jalan joyo raharjo 281B, RT 04,RW 02, Kelurahan Merjosari, Kecamatan Lowokwaru, Kota Malang Kodepos:65144",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(
                            color: '020202'.toColor(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:36),
                  Container(
                    width:double.infinity,
                    child: TextButton(
                      onPressed: (){
                        Beamer.of(context).beamToNamed(RouteName.generalOrderSuccess);
                      },
                      child: Text(
                        "Pesan Sekarang",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColor.textPrimaryColor,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(AppColor.primaryColor),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
