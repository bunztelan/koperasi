part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: 'f2f2f2'.toColor(),
          height: double.infinity,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/default_avatar.png"),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "User Name",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: AppColor.textPrimaryColor,
                            fontSize: 18,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text("UserEmail@email.com",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: '8D92A3'.toColor(),
                              fontSize: 14,
                            ),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
              Container(
                color:Colors.white,
                margin: EdgeInsets.only(top:16),
                padding:EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap:(){},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Ubah profil"),
                          IconButton(
                            icon:Icon(CupertinoIcons.chevron_right),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap:(){},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Ubah Alamat"),
                          IconButton(
                            icon:Icon(CupertinoIcons.chevron_right),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap:(){
                        Beamer.of(context).beamToNamed(RouteName.authSignIn);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Keluar"),
                          IconButton(
                            icon:Icon(CupertinoIcons.chevron_right),
                          )
                        ],
                      ),
                    )
                  ],
                )
              )
            ],

          ),
        ),
      ),
    );
  }
}
