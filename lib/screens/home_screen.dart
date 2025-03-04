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
  double _topPadding = 246.0; // Динамический отступ для Home, Menu, Profile

  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(scrollController: _scrollController), // индекс 0 (Home)
      Cart(),                                       // индекс 1 (Cart)
      MenuPage(),
      ProfilePage(),
    ];
    _scrollController.addListener(_updateTopPadding);
  }

  void _updateTopPadding() {
    final appState = Provider.of<AppProvider>(context, listen: false);
    // Если экран корзины (индекс 1), не обновляем отступ динамически
    if (appState.selectedIndex == 1) return;

    double newPadding = _scrollController.offset > 30 ? 140.0 : 246.0;
    if (newPadding != _topPadding) {
      setState(() {
        _topPadding = newPadding;
      });
    }
  }

  /// Колбэк, вызываемый при нажатии на иконку Home в нижней навигации.
  /// Возвращает список к началу и разворачивает TopMenu.
  void _goHomeTop() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
    setState(() {
      _topPadding = 246.0; // Возвращаем полную высоту шапки (баннер)
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

    // Для экрана корзины (индекс 1) принудительно сжимаем TopMenu
    final bool forceCollapsed = (currentIndex == 1);

    // Если это корзина, добавляем зазор между TopMenu и основным контентом
    final double gap = forceCollapsed ? 20.0 : 0.0;

    // При корзине фиксированный отступ = 140 + gap; для остальных — динамический _topPadding
    final double effectiveTopPadding = forceCollapsed ? 140.0 + gap : _topPadding;

    // Если переключаемся с корзины на другой экран, сбрасываем скролл и возвращаем шапку в полную высоту
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
          // Фон всего экрана
          Container(color: const Color(0xFFF5F5F5)),

          // Основной контент
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

          // Если корзина, рисуем отдельный зазор между TopMenu и контентом
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

          // Верхняя панель TopMenu
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
