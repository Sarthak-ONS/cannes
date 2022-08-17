import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    this.title,
    this.baseText,
    this.firstImage,
    this.pId,
    this.price,
  }) : super(key: key);

  final String? title;
  final String? baseText;
  final String? firstImage;
  final String? pId;
  final double? price;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(widget.pId);
        Navigator.pushNamed(context, '/productDetails', arguments: widget.pId);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15, bottom: 10),
        padding: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Material(
                  color: Colors.transparent,
                  elevation: 2.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.firstImage!,
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                      errorBuilder: (BuildContext x, Object? y, StackTrace? z) {
                        return const SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                        );
                      },
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 5,
                  right: 5,
                  child: Icon(
                    CupertinoIcons.heart_fill,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                widget.baseText!,
                maxLines: 2,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0, bottom: 3),
              child: Text(
                widget.title!,
                maxLines: 2,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
            Text(
              NumberFormat.currency(
                locale: 'en_IN',
                symbol: '₹',
              ).format(widget.price),
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
