import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import '../../../screen/costumer/Profile/profile_screen.dart';
import '../../../screen/costumer/cart/cart_screen.dart';
import '../../../screen/costumer/menu/menu_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;
  Widget _currentScreen = MenuScreen();

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _currentScreen = MenuScreen();
          break;
        case 1:
          _currentScreen = const CartScreen();
          break;
        case 2:
          _currentScreen = const UserProfileScreen();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentScreen,
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: const Color.fromARGB(255, 235, 132, 64),
        items: const [
          TabItem(icon: Icons.local_pizza, title: "Menu"),
          TabItem(icon: Icons.shopping_bag, title: "Cart"),
          TabItem(icon: Icons.person, title: "Profile"),
        ],
        initialActiveIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}