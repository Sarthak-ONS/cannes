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
      color: Colors.white,
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
                  child: CustomRawChip(
                    newArrivalChips: newArrivalChips,
                    index: index,
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

class CustomRawChip extends StatefulWidget {
  const CustomRawChip({
    Key? key,
    this.index,
    required this.newArrivalChips,
  }) : super(key: key);

  final List newArrivalChips;
  final int? index;

  @override
  State<CustomRawChip> createState() => _CustomRawChipState();
}

class _CustomRawChipState extends State<CustomRawChip> {
  bool isChippedTapped = false;

  @override
  Widget build(BuildContext context) {
    return RawChip(
      side: !isChippedTapped
          ? const BorderSide(color: Colors.black, width: 0.5)
          : null,
      onPressed: () {
        setState(() {
          isChippedTapped = !isChippedTapped;
        });
      },
      elevation: 1,
      backgroundColor: isChippedTapped ? Colors.red : Colors.white,
      label: Text(
        widget.newArrivalChips[widget.index!],
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: isChippedTapped ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
