part of 'widgets.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;

  CustomBottomNav({
    this.selectedIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap(0);
              }
            },
            child: Icon(
              FeatherIcons.home,
              color:
                  selectedIndex == 0 ? AppColor.primaryColor : AppColor.black30,
              size: 28,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap(1);
              }
            },
            child: Icon(
              FeatherIcons.shoppingBag,
              color:
                  selectedIndex == 1 ? AppColor.primaryColor : AppColor.black30,
              size: 28,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap(2);
              }
            },
            child: Icon(
              FeatherIcons.user,
              color:
                  selectedIndex == 2 ? AppColor.primaryColor : AppColor.black30,
              size: 28,
            ),
          )
        ],
      ),
    );
  }
}
