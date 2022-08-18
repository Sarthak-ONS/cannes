import 'package:cannes/Models/product_model.dart';

class CartProductModel {
  final Product? product;
  int? qunatity;

  final String size;
  final String color;

  CartProductModel({
    required this.product,
    required this.color,
    required this.size,
    this.qunatity,
  });
}
