import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key, required this.pid}) : super(key: key);

  final String pid;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    print(widget.pid);
  }

  final double kPadding = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('Products')
            .doc(widget.pid)
            .get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Please try again later!'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  Text('Fetching Product Details')
                ],
              ),
            );
          }
          print(snapshot.data.get("images").length);
          return Container(
            child: Stack(
              children: [
                ListView(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 500,
                      child: PageView.builder(
                        itemCount: snapshot.data.get("images").length,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            snapshot.data.get("images")[index],
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: kPadding, top: kPadding),
                      child: const Text(
                        "H&M",
                        style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 15,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: kPadding),
                      child: Text(
                        snapshot.data.get("name"),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PoppinsRegular',
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: kPadding),
                      child: Text(
                        "${NumberFormat.currency(
                          locale: 'en_IN',
                          symbol: '₹',
                        ).format(snapshot.data.get("price"))} Per Unit",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, left: kPadding),
                      child: const Text(
                        "Choose a Color",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: kPadding),
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.get("colors_available").length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 5, top: 0),
                            decoration: BoxDecoration(
                              color: Color(int.parse(snapshot.data
                                  .get("colors_available")[index])),
                              border: Border.all(
                                color: Color(int.parse(snapshot.data
                                        .get("colors_available")[index]))
                                    .withOpacity(0.5)
                                    .withRed(55),
                              ),
                            ),
                            width: 60,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, left: kPadding),
                      child: const Text(
                        "Choose a Size",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: kPadding),
                      margin: const EdgeInsets.only(top: 5.0),
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.get("sizes").length,
                        itemBuilder: (BuildContext context, int index) {
                          Map x = snapshot.data.get("sizes");
                          print(x.keys.toList());

                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 8),
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.black38,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: Text(
                                  x.keys.toList()[index],
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, left: kPadding),
                      child: Text(
                        snapshot.data.get("description"),
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10, horizontal: kPadding),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      color: const Color(0xff5CB270),
                      child: Column(
                        children: const [
                          Text(
                            "By 2030, we aim to only work with reycled, organic, or other more sustainablity sourced materials.",
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Right now, we are at 80%.",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                              "Curious about what we are doing, check out are work!"),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
