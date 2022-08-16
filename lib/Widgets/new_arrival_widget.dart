import 'package:flutter/material.dart';

class NewArrival extends StatefulWidget {
  const NewArrival({Key? key}) : super(key: key);

  @override
  State<NewArrival> createState() => _NewArrivalState();
}

class _NewArrivalState extends State<NewArrival> {
  List newArrivalChips = [
    "Ladies",
    "Men",
    "Divided",
    "Kids",
    "Baby",
    "H&M Home"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.red,
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newArrivalChips.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text(newArrivalChips[index]),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
