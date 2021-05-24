part of 'widgets.dart';

class CustomTabbar extends StatelessWidget {
  final int selectedIndex;
  final List<String> titles;
  final Function(int) onTap;
  final bool spaceEvenly;

  CustomTabbar(
      {this.selectedIndex,
      @required this.titles,
      this.onTap,
      this.spaceEvenly});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 48),
            height: 1,
            color: 'F2f2f2'.toColor(),
          ),
          Row(
            mainAxisAlignment: spaceEvenly == null || spaceEvenly
                ? MainAxisAlignment.spaceEvenly
                : MainAxisAlignment.start,
            children: titles
                .map((e) => Padding(
                      padding: EdgeInsets.only(
                        left: spaceEvenly != null && !spaceEvenly ? 24 : 16,
                        top: 10,
                      ),
                      child: GestureDetector(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (onTap != null) {
                                  onTap(titles.indexOf(e));
                                }
                              },
                              child: Text(
                                e,
                                style: (titles.indexOf(e) == selectedIndex)
                                    ? Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          color: AppColor.textPrimaryColor,
                                          fontWeight: FontWeight.w700,
                                        )
                                    : Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          color: AppColor.softGrayColor,
                                        ),
                              ),
                            ),
                            Container(
                              width: 40,
                              height: 3,
                              margin: EdgeInsets.only(top: 13),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1.5),
                                color: (titles.indexOf(e) == selectedIndex)
                                    ? '020202'.toColor()
                                    : Colors.transparent,
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
