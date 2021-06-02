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

  UserCubit _userCubit;

  @override
  void initState() {
    _userCubit = UserCubit();
    _userCubit.getUserLocalData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<UserCubit>(create: (context) => _userCubit)],
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(color: Colors.white),
              SafeArea(
                child: Container(
                  color: 'FAFAFC'.toColor(),
                ),
              ),
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
                      child: OrderListPage(),
                    ),
                    Center(child: Builder(
                      builder: (context) {
                        return ProfilePage();
                      },
                    )),
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
      ),
    );
  }
}
