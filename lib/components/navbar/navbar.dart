import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modulor_app/providers/app_state.dart'; // Import AppState class

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> with SingleTickerProviderStateMixin {
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

    final appState = Provider.of<AppState>(context, listen: false);

    // Set the previous index to the current one before updating to the new one
    int newIndex = appState.selectedIndex;

    // We only update the animation if the index has changed
    if (_previousIndex != newIndex) {
      double start = MediaQuery.of(context).size.width / 5 * _previousIndex + 15;
      double end = MediaQuery.of(context).size.width / 5 * newIndex + 15;

      _animation = Tween<double>(begin: start, end: end).animate(CurvedAnimation(
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
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 1,
              color: Colors.grey[300],
            ),
            Stack(
              children: [
                BottomNavigationBar(
                  backgroundColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  iconSize: 32,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline),
                      label: 'Search',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart_outlined),
                      label: 'Notifications',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.menu),
                      label: 'Favorites',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.question_mark_rounded),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: appState.selectedIndex, // Pass selectedIndex from appState
                  selectedItemColor: Color.fromRGBO(228, 0, 0, 1),
                  unselectedItemColor: Colors.black,
                  onTap: (index) {
                    appState.updateSelectedIndex(index);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Positioned(
                      left: _animation.value,
                      top: 0,
                      child: Container(
                        width: 60,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(228, 0, 0, 1),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(3.0),
                            bottomRight: Radius.circular(3.0),
                          ),
                        ),
                      ),
                    );
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
