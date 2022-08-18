import 'package:flutter/cupertino.dart';

class ProductConfigProvider extends ChangeNotifier {
  String? selectedSize = 'L';
  String? selectedColor;

  chnageSizeOfProduct({String? size}) {
    selectedSize = size;
    notifyListeners();
  }

  changeColorOfProduct({String? color}) {
    selectedColor = color;
    notifyListeners();
  }
}
