import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yummy/base/no_data_page.dart';
import 'package:yummy/pages/cart/cart_history.dart';
import 'package:yummy/pages/cart/cart_page.dart';
import 'package:yummy/pages/home/main_food_page.dart';
import 'package:yummy/widgets/big_text.dart';
import '../../utils/colors.dart';
import 'package:badges/badges.dart' as badges;
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late PersistentTabController _controller;


  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      const MainFoodPage(),
      const NoDataPage(text: "Your Cart is Empty"),
      const CartHistory(),
      Center(child: BigText(text: "Fourth Page")),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.home_filled,
          ),
          activeColorPrimary: AppColors.mainColor,
          inactiveColorPrimary: Colors.grey.shade400,
          ),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.receipt),
          activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.grey.shade400,
          ),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.shopping_cart),
          activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.grey.shade400,
          ),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person_2),
          activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.grey.shade400,
          ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style5, // Choose the nav bar style with this property.
    );
  }


}
