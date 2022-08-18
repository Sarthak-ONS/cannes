import 'package:flutter/material.dart';

class FloatinCustomIcon extends StatelessWidget {
  const FloatinCustomIcon({
    Key? key,
    this.iconData,
    this.callBack,
  }) : super(key: key);

  final IconData? iconData;
  final Function? callBack;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: GestureDetector(
        onTap: () {
          callBack!();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
          child: Icon(
            iconData!,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
