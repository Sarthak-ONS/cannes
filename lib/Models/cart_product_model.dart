import 'package:cannes/Models/product_model.dart';

class CartProductModel {
  final Product? product;
  final Map<String, String>? configurationOfProduct;

  CartProductModel({
    required this.product,
    this.configurationOfProduct,
  });
}
