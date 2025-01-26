import 'package:flutter/material.dart';
import '../components/navbar/navbar.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'cart_page.dart';
import 'menu_page.dart';
import 'support_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Define your pages
  final List<Widget> _pages = [
    HomePage(),
    ProfilePage(),
    CartPage(),
    MenuPage(),
    SupportPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the current page
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
