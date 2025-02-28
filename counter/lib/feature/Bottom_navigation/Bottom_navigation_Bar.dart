import 'package:counter/core/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../search/presentation/saerch.dart';
import '../cart/presentation/cart_screen.dart';
import '../home/presentation/home_screen.dart';
import '../profile/presentation/profile_Screen.dart';
import '../wishlist/wishlist.dart';

class Bottom_Navigation_Bar extends StatefulWidget {
  final String title1;
  final String title2;
  final String title3;
  final String title4;
  final String title5;

  Bottom_Navigation_Bar({
    required this.title1,
    required this.title2,
    required this.title3,
    required this.title4,
    required this.title5,
  });

  @override
  State<Bottom_Navigation_Bar> createState() => _TabbarStateState();
}

class _TabbarStateState extends State<Bottom_Navigation_Bar> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColor.buttonColor,
        unselectedItemColor: Colors.black38,
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: _onItemTapped,

        items: [
          _buildNavItem("assets/svgs/homeicone.svg", widget.title1, 0),
          _buildNavItem("assets/svgs/browse_icon.svg", widget.title2, 1),
          _buildNavItem("assets/svgs/wishlist.svg", widget.title3, 2),
          _buildNavItem("assets/svgs/cart_icon.svg", widget.title4, 3),
          _buildNavItem("assets/svgs/profile_icon.svg", widget.title5, 4),
        ],
      ),
    );
  }

  // Function to build navigation bar items with filled icon effect
  BottomNavigationBarItem _buildNavItem(String assetPath, String label, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selectedIndex == index ? AppColor.buttonColor : Colors.transparent, // Fill background if selected
        ),
        padding: EdgeInsets.all(8), // Padding inside the circle
        child: SvgPicture.asset(
          assetPath,
          height: 20, // Adjust the size as needed
          color: selectedIndex == index ? Colors.white : Colors.black38, // Change icon color
        ),
      ),
      label: label,
    );
  }

  Widget buildBody() {
    switch (selectedIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return SearchScreen();
      case 2:
        return WishlistScreen();
      case 3:
        return CartScreen();
      case 4:
        return ProfileScreen();
      default:
        return Center(child: Text('No screen found for this tab'));
    }
  }
}
