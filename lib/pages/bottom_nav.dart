
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_commerce/pages/home_page.dart';
import 'package:e_commerce/pages/order_page.dart';
import 'package:e_commerce/pages/profile_page.dart';
import 'package:e_commerce/pages/wallet_page.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentTabIndex = 0;

  late List<Widget> _pages;
  late Widget _currentPage;

  late HomePage _homePage;
  late ProfilePage _profile;
  late OrderPage _order;
  late WalletPage _wallet;

  void initState() {
    super.initState();
    _homePage = const HomePage();
    _profile = const ProfilePage();
    _order = const OrderPage();
    _wallet = const WalletPage();

    _pages = [_homePage, _order, _wallet, _profile];
    _currentPage = _homePage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Color(0xFFff5c30),
        animationDuration: Duration(milliseconds: 500),
        onTap: (value) {
          setState(() {
             _currentTabIndex = value;
          });
        },
        items: [
        Icon(
          Icons.home_outlined,
          color: Colors.white,
        ),
        Icon(
          Icons.shopping_bag_outlined,
          color: Colors.white
        ),
        Icon(
          Icons.wallet_rounded,
          color: Colors.white,
        ),
        Icon(
          Icons.person_outline,
          color: Colors.white,
        ),
      ]),
      body: _pages[_currentTabIndex],
    );
  }
}