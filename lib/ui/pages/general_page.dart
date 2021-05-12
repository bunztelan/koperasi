part of 'pages.dart';

class GeneralPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onBackPressed;
  final Widget child;
  final Color backColor;

  GeneralPage({
    this.title = "Title",
    this.subtitle = "Subtitle",
    this.onBackPressed,
    this.child,
    this.backColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(color: Colors.white),
        SafeArea(
          child: Container(color: backColor ?? "FAFAFC".toColor()),
        ),
        SafeArea(
          child: ListView(children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  margin: EdgeInsets.only(bottom: 24),
                  width: double.infinity,
                  height: 100,
                  color: Colors.white,
                  child: Row(
                    children: [
                      onBackPressed != null
                          ? GestureDetector(
                              onTap: onBackPressed,
                              child: Container(
                                margin: EdgeInsets.only(right: 26),
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/arrow_back.png'),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: "020202".toColor(),
                            ),
                          ),
                          Text(
                            subtitle,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: "8D92A3".toColor(),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  color:Colors.white,
                  padding:EdgeInsets.symmetric(vertical: 26,horizontal: 24),
                  child: child ?? SizedBox(),
                )

              ],
            ),
          ]),
        ),
      ]),
    );
  }
}
