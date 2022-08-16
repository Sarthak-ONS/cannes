import 'package:flutter/material.dart';

class TrendingWidgetCard extends StatelessWidget {
  const TrendingWidgetCard({
    Key? key,
    this.imageUrl,
    this.forGender,
    this.type,
  }) : super(key: key);

  final String? imageUrl;
  final String? forGender;
  final String? type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: Image.network(
              imageUrl!,
              fit: BoxFit.scaleDown,
              height: 70,
              width: 70,
            ),
          ),
          Text(
            forGender!,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
          ),
          Text(
            type!,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
