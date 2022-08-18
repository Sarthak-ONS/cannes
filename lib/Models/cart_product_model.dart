import 'package:cannes/Models/product_model.dart';

class CartProductModel {
  final Product? product;
  final int? quantity;
  final String? size;

  CartProductModel({
    required this.product,
    required this.quantity,
    required this.size,
  });
}
