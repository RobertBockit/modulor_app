import 'package:flutter/foundation.dart'; // Make sure to import this for ChangeNotifier

class AppState with ChangeNotifier {
  int _selectedIndex = 0; // Initial selected index

  int get selectedIndex => _selectedIndex; // Getter for selectedIndex

  void updateSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners(); // Notify listeners when the index changes
  }
}