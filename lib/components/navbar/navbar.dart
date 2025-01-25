import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 15, end: 0).animate(_controller);
  }


  void _onItemTapped(int index) {
    setState(() {
      double start = MediaQuery.of(context).size.width / 5 * _selectedIndex + 15;
      double end = MediaQuery.of(context).size.width / 5 * index + 15;
      _animation = Tween<double>(begin: start, end: end).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
      _controller.forward(from: 0);
      _selectedIndex = index;
    });
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Page ${_selectedIndex + 1}',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min, // Shrink to fit the content
        children: [
          Container(
            height: 1, // Height of the horizontal line
            color: Colors.grey[300], // Line color
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
            currentIndex: _selectedIndex,
            selectedItemColor: Color.fromRGBO(228, 0 , 0, 1),
            unselectedItemColor: Colors.black,
            onTap: _onItemTapped,
          ), AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Positioned(
                    left: _animation.value, // Dynamic animation value for position
                    top: 0,
                    child: Container(
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(228, 0 , 0, 1),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(3.0), bottomRight: Radius.circular(3.0)),
                      ),
                    ),
                  );
                },
              ),
            ]
          ),
        ],
      ),
    );
  }
}
