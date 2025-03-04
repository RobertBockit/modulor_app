import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modulor_app/providers/app_provider.dart'; // Import AppState class
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/colors.dart';
import '../../providers/cart_provider.dart';

class BottomNavBar extends StatefulWidget {
  /// Колбэк, вызываемый при нажатии на иконку Home (индекс 0)
  final VoidCallback? onHomeTap;

  BottomNavBar({Key? key, this.onHomeTap}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _previousIndex = 0; // Track the previous selected index

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 15, end: 15).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant BottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    final appState = Provider.of<AppProvider>(context, listen: false);

    // Set the previous index to the current one before updating to the new one
    int newIndex = appState.selectedIndex;

    // We only update the animation if the index has changed
    if (_previousIndex != newIndex) {
      double start =
          MediaQuery.of(context).size.width / 5 * _previousIndex + 15;
      double end = MediaQuery.of(context).size.width / 5 * newIndex + 15;

      _animation =
          Tween<double>(begin: start, end: end).animate(CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          ));

      _controller.forward(from: 0); // Trigger the animation
      _previousIndex = newIndex; // Update the previous index
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appState, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 5,
            ),
            Stack(
              children: [
                BottomNavigationBar(
                  backgroundColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedIconTheme: IconThemeData(color: AppColor.modulorRed),
                  selectedFontSize: 13,
                  iconSize: 32,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/home.svg',
                        width: 24,
                        height: 24,
                        color: appState.selectedIndex == 0
                            ? AppColor.modulorRed
                            : Colors.black,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Consumer<CartProvider>(
                        builder: (context, cartProvider, child) {
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              // The base shopping cart icon
                              SvgPicture.asset(
                                'assets/icons/shopping-cart.svg',
                                width: 24,
                                height: 24,
                                color: appState.selectedIndex == 1
                                    ? AppColor.modulorRed
                                    : Colors.black,
                              ),
                              // Only show the badge if there are items in the cart
                              if (cartProvider.totalAmount > 0)
                                Positioned(
                                  top: -5,
                                  right: 4,
                                  child: SizedBox(
                                    width: 16,
                                    child: Text(
                                      cartProvider.totalAmount.toString(),
                                      style: TextStyle(
                                        color: appState.selectedIndex == 1
                                            ? AppColor.modulorRed
                                            : Colors.black,
                                        fontSize: cartProvider.totalAmount > 9
                                            ? 12
                                            : 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      label: 'Cart',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/menu.svg',
                        width: 24,
                        height: 24,
                        color: appState.selectedIndex == 2
                            ? AppColor.modulorRed
                            : Colors.black,
                      ),
                      label: 'Categories',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/user.svg',
                        width: 24,
                        height: 24,
                        color: appState.selectedIndex == 3
                            ? AppColor.modulorRed
                            : Colors.black,
                      ),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: appState.selectedIndex,
                  selectedItemColor: const Color.fromRGBO(228, 0, 0, 1),
                  unselectedItemColor: Colors.black,
                  onTap: (index) {
                    // Если нажали на Home (индекс 0)
                    if (index == 0) {
                      // Вызвать колбэк onHomeTap, если он передан
                      widget.onHomeTap?.call();
                    }

                    // Обновляем индекс
                    appState.updateSelectedIndex(index);

                    // Сбрасываем навигационный стек
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
