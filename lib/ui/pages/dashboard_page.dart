part of 'pages.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() {
    return _DashboardPageState();
  }
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0;
  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(color: Colors.white),
            SafeArea(
                child: Container(
              color: 'FAFAFC'.toColor(),
            )),
            SafeArea(
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                children: [
                  Center(
                    child: HomePage(),
                  ),
                  Center(
                    child: Text("order area"),
                  ),
                  Center(
                    child: Text("profile area"),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomNav(
                selectedIndex: selectedIndex,
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                  controller.jumpToPage(selectedIndex);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
