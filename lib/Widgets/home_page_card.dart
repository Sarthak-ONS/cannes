import 'package:flutter/material.dart';

class HomePageCardWidget extends StatelessWidget {
  const HomePageCardWidget(
      {Key? key,
      required this.image,
      this.isTextCenter = false,
      this.heading,
      this.subHeading})
      : super(key: key);

  final String image;
  final bool? isTextCenter;
  final String? heading;
  final String? subHeading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Tapping Card");
      },
      child: Card(
        child: Container(
          height: 400,
          child: Center(
            child: Column(
              mainAxisAlignment: isTextCenter!
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.end,
              children: [
                Text(
                  heading ?? "Bold and Beautiful",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  subHeading ??
                      "Switch your look to Dark mode \nbecause bold is the new black this season",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            image: DecorationImage(
              image: NetworkImage(
                image,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
