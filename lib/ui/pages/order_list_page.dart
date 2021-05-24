part of 'pages.dart';

class OrderListPage extends StatefulWidget {
  OrderListPage({Key key}) : super(key: key);

  @override
  _OrderListPageState createState() {
    return _OrderListPageState();
  }
}

class _OrderListPageState extends State<OrderListPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title:"Pesanan",
      subtitle: "Daftar pesanan anda",
      headerHeight: 130,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            CustomTabbar(
              titles: ["Dalam Proses", "Selesai"],
              selectedIndex: selectedIndex,
              spreadEven: false,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
            SizedBox(height: 16),
            Builder(
              builder: (_) {
                print("before column");
                return Column(
                  children: Product.mockProducts
                      .map((e) => ProductListItem(product: e))
                      .toList(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}