// import 'package:cannes/Providers/cart.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';

// import '../Models/cart_product_model.dart';

// class ProductDetailsScreenProvider extends ChangeNotifier {
//   String? pid;
//   bool? isPresent;
//   int qunatity = 0;

//   getProductID({String? productID}) {
//     pid = productID;
//     notifyListeners();
//   }

//   checkIfProductisAlreadyPresentInCart({BuildContext? context}) {
//     List<CartProductModel> productsListInCart =
//         Provider.of<CartProvider>(context!, listen: false).products!;

//     for (var element in productsListInCart) {
//       if (element.product!.pID == pid) {
//         qunatity += 1;
//       }
//     }
//     notifyListeners();
//   }
// }
