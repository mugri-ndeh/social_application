import 'package:flutter/widgets.dart';

class BaseProvider with ChangeNotifier {
  int currentIndex = 0;

  changeIndex(int newIndex) {
    notifyListeners();
  }
}
