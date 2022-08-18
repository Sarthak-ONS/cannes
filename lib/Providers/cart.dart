import 'package:cannes/Models/cart_product_model.dart';
import 'package:cannes/Providers/product_config_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  List<CartProductModel>? products = [];

  double? calculatePrice;

  addToProductList(CartProductModel cartProduct, BuildContext context) {
    bool isAlreadyPresent = false;

    var selectedSize =
        Provider.of<ProductConfigProvider>(context, listen: false).selectedSize;
    var i = 0;
    for (i = 0; i < products!.length; i++) {
      print(".........");
      if (products![i].product!.pID == cartProduct.product!.pID &&
          products![i].size == selectedSize) {
        isAlreadyPresent = true;
        print(products![i].qunatity);

        products![i].qunatity = products![i].qunatity! + 1;
        print(products![i].qunatity);
        break;
      }
    }
    //products![i].size != selectedSize
    if (!isAlreadyPresent) {
      products!.add(cartProduct);
    }

    notifyListeners();
  }

  removeFromProductList(CartProductModel cartProductModel) {
    products!.remove(cartProductModel);
    notifyListeners();
  }
}
