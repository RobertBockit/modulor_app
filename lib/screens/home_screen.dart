import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modulor_app/providers/app_provider.dart';
import '../components/navbar/navbar.dart';
import '../components/top_menu/top_menu.dart';
import 'home_page.dart';
import 'cart_page.dart';
import 'menu_page.dart';
import 'profile_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final List<Widget> _pages;
  final ScrollController _scrollController = ScrollController();
  double _topPadding = 246.0;

  int _previousIndex = 0;

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
    final appState = Provider.of<AppProvider>(context, listen: false);
    if (appState.selectedIndex == 1) return;

    double newPadding = _scrollController.offset > 30 ? 140.0 : 246.0;
    if (newPadding != _topPadding) {
      setState(() {
        _topPadding = newPadding;
      });
    }
  }


  void _goHomeTop() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
    setState(() {
      _topPadding = 246.0;
    });
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
    final currentIndex = appState.selectedIndex;

    final bool forceCollapsed = (currentIndex == 1);

    final double gap = forceCollapsed ? 20.0 : 0.0;

    final double effectiveTopPadding = forceCollapsed ? 140.0 + gap : _topPadding;

    if (_previousIndex == 1 && currentIndex != 1 && _scrollController.hasClients) {
      _scrollController.jumpTo(0);
      setState(() {
        _topPadding = 246.0;
      });
    }
    _previousIndex = currentIndex;

    return Scaffold(
      body: Stack(
        children: [
          Container(color: const Color(0xFFF5F5F5)),

          Positioned(
            top: effectiveTopPadding,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              clipBehavior: Clip.hardEdge,
              child: _pages[currentIndex],
            ),
          ),

          if (forceCollapsed)
            Positioned(
              top: 140,
              left: 0,
              right: 0,
              height: gap,
              child: Container(
                color: const Color(0xFFF5F5F5),
              ),
            ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TopMenu(
              scrollController: _scrollController,
              forceCollapsed: forceCollapsed,
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavBar(
        onHomeTap: _goHomeTop,
      ),
    );
  }
}
