import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/navbar/navbar.dart';
import '../components/top_menu/top_menu.dart';
import '../providers/app_state.dart';
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
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(),
      Cart(),
      MenuPage(),
      ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 115),
            child: _pages[appState.selectedIndex],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TopMenu(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
