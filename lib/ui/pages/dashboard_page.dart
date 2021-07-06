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
  void initState() {
    BlocProvider.of<TokenCubit>(context).getTokenLocalData();

    BlocProvider.of<UserCubit>(context).getUserLocalData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: CustomBottomNav(
        selectedIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
          controller.jumpToPage(selectedIndex);
        },
      ),
      body: SafeArea(
        child: BlocListener<TokenCubit, TokenState>(
          listener: (context, state) {
            if (state is TokenLoadedState) {
              BlocProvider.of<CategoryCubit>(context).getCategory(state.token);
              BlocProvider.of<BannerCubit>(context).getBanner(state.token);
            }
          },
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
                      child: Builder(
                        builder: (context) {
                          return OrderListPage();
                        },
                      ),
                    ),
                    Center(child: Builder(
                      builder: (context) {
                        return ProfilePage();
                      },
                    )),
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
