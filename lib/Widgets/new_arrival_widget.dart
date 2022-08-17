import 'package:cannes/Widgets/something_went_wrong_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewArrival extends StatefulWidget {
  const NewArrival({Key? key}) : super(key: key);

  @override
  State<NewArrival> createState() => _NewArrivalState();
}

class _NewArrivalState extends State<NewArrival> {
  final int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newArrivalConstChips.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomRawChip(
                    index: index,
                    isSelected: newArrivalConstChips[index].isSelected,
                    onTapCallback: () {
                      print("Callback called");
                      for (var item in newArrivalConstChips) {
                        setState(() {
                          item.isSelected = false;
                        });
                      }
                      setState(
                        () {
                          newArrivalConstChips[index].isSelected = true;
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('Products')
                  .where("origin_date",
                      isLessThan: Timestamp.fromDate(DateTime.now()))
                  .get(),
              builder: ((BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return const SomethingWentWrong();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: ((BuildContext context, int index) {
                      return Container(
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
                                      snapshot.data.docs[index]['images'][0],
                                      fit: BoxFit.cover,
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
                                snapshot.data.docs[index]['base_text'],
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 3.0, bottom: 3),
                              child: Text(
                                snapshot.data.docs[index]['name'],
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Text(
                              NumberFormat.currency(
                                locale: 'en_IN',
                                symbol: '₹',
                              ).format(snapshot.data.docs[index]['price']),
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      );
                    }),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}

List<CustomRawChipModel> newArrivalConstChips = [
  CustomRawChipModel(title: "Ladies", isSelected: false),
  CustomRawChipModel(title: "Men", isSelected: false),
  CustomRawChipModel(title: "Divided", isSelected: false),
  CustomRawChipModel(title: "Kids", isSelected: false),
  CustomRawChipModel(title: "Baby", isSelected: false),
  CustomRawChipModel(title: "H&M Home", isSelected: false),
];

class CustomRawChipModel {
  String? title;
  bool? isSelected;
  CustomRawChipModel({this.isSelected, this.title});
}

class CustomRawChip extends StatefulWidget {
  const CustomRawChip(
      {Key? key, this.index, required this.onTapCallback, this.isSelected})
      : super(key: key);

  final int? index;
  final Function onTapCallback;
  final bool? isSelected;

  @override
  State<CustomRawChip> createState() => _CustomRawChipState();
}

class _CustomRawChipState extends State<CustomRawChip> {
  @override
  Widget build(BuildContext context) {
    return RawChip(
      side: !widget.isSelected!
          ? const BorderSide(color: Colors.black, width: 1)
          : null,
      onPressed: () {
        widget.onTapCallback();
      },
      elevation: 1,
      backgroundColor: widget.isSelected! ? Colors.red : Colors.white,
      label: Text(
        newArrivalConstChips[widget.index!].title!,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: widget.isSelected! ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
