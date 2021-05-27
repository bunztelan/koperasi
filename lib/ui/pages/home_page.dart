part of 'pages.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 130,
          width: double.infinity,
          color: Colors.white,
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.symmetric(vertical: 26, horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/k2ms_logo.png'),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Koperasi Karyawan",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      Text(
                        "Mitra Sejahtera",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage('assets/default_avatar.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Samidi",
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(height: 200.0),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 160,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: AppColor.softGrayColor,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Banner $i',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        padding: EdgeInsets.all(8),
                        child: Text("Banner Title $i"),
                      )
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 24),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTabbar(
                titles: ["Makanan", "Minuman", "Lainnya", "Sembako"],
                selectedIndex: selectedIndex,
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Beamer.of(context)
                          .beamToNamed(RouteName.userProductDetail);
                    },
                    child: ItemCard('Beras ABC', '75000'),
                  ),
                  ItemCard('Minyak Goreng Bilomi', '23000'),
                  ItemCard('Minyak Goreng Uhuy Badai Bombai', '50000'),
                  ItemCard('Indomie Mie Instant', '1500'),
                  Container(
                    height: 50,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

/// Item Card
class ItemCard extends StatelessWidget {
  final String title;
  final String price;

  ItemCard(this.title, this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        bottom: 24,
        right: 24,
        left: 24,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColor.softGrayColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'IDR $price',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: AppColor.black30),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
