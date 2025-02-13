import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/navbar/navbar.dart';
import '../components/top_menu/top_menu.dart';
import '../providers/app_state.dart';
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
  double _topPadding = 200.0;

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
    double newPadding = _scrollController.offset > 30 ? 80.0 : 200.0;
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
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      body: PrimaryScrollController(
        controller: _scrollController,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: _topPadding),
              child: _pages[appState.selectedIndex],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: TopMenu(scrollController: _scrollController),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
