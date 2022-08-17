import 'package:cannes/Widgets/product_card.dart';
import 'package:cannes/Widgets/something_went_wrong_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                      return ProductCard(
                        firstImage: snapshot.data.docs[index]['images'][0],
                        baseText: snapshot.data.docs[index]['base_text'],
                        title: snapshot.data.docs[index]['name'],
                        price: double.parse(
                            snapshot.data.docs[index]['price'].toString()),
                        pId: snapshot.data.docs[index]['p_id'],
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
