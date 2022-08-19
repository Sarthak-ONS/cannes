import 'package:flutter/cupertino.dart';

class CartScreenUIProvider extends ChangeNotifier {
  bool isScollingUp = false;

  changeScrollingBeahviour(bool value) {
    isScollingUp = value;
    notifyListeners();
  }
}
