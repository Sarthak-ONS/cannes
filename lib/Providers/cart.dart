import 'package:cannes/Models/cart_product_model.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  List<CartProductModel>? products = [];

  int? totalItems;

  double? calculatePrice;

  addToProductList(CartProductModel cartProduct) {
    products!.add(cartProduct);
    notifyListeners();
  }

  removeFromProductList(CartProductModel cartProductModel) {
    products!.remove(cartProductModel);
    notifyListeners();
  }
}
