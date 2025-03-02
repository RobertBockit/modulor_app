import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/navbar/navbar.dart';
import '../components/top_menu/top_menu.dart';
import '../providers/app_provider.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'cart_page.dart';
import 'menu_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final List<Widget> _pages;
  final ScrollController _scrollController = ScrollController();
  double _topPadding = 246.0;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(scrollController: _scrollController),
      Cart(),
      MenuPage(),
      ProfilePage(),
    ];

    _scrollController.addListener(_updateTopPadding);
  }

  void _updateTopPadding() {
    double newPadding = _scrollController.offset > 30 ? 140.0 : 246.0;
    if (newPadding != _topPadding) {
      setState(() {
        _topPadding = newPadding;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateTopPadding);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFFF5F5F5),
          ),

          // Основной контент
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: _topPadding,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: _pages[appState.selectedIndex],
            ),
          ),

          // Верхний бар
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TopMenu(
              scrollController: _scrollController,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}