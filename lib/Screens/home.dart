import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Widgets/home_page_card.dart';
import '../Widgets/something_went_wrong_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  getTrendingCollections() async {
    final res = await FirebaseFirestore.instance.collection('Trending').get();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              CupertinoIcons.search,
              color: Colors.black87,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              CupertinoIcons.person,
              color: Colors.black87,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              CupertinoIcons.heart,
              color: Colors.black87,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              CupertinoIcons.shopping_cart,
              color: Colors.black87,
            ),
          ),
        ],
        leading: IconButton(
          icon: SvgPicture.asset(
            "Assets/Images/menu.svg",
            height: 24,
            width: 24,
          ),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        children: [
          const Center(
            child: Text(
              "Free membership for members above 999! Join Now",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const HomePageCardWidget(
            image:
                "https://user-images.githubusercontent.com/57105611/184881934-b14ec179-58d4-46a7-b8cc-7c5dbd37c9cf.jpg",
          ),
          const HomePageCardWidget(
            image:
                "https://images.pexels.com/photos/934070/pexels-photo-934070.jpeg?auto=compress&cs=tinysrgb&w=600",
            heading: "Press : Fresh",
            subHeading: "",
            isTextCenter: true,
          ),
          const SizedBox(
            height: 35,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10),
            child: Text(
              "Trending Categories",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                fontSize: 20,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          SizedBox(
            height: 125,
            child: FutureBuilder(
              future: getTrendingCollections(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  print(snapshot..error);

                  return const SomethingWentWrong();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        height: 80,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipOval(
                              child: Image.network(
                                snapshot.data.docs[index]['imageUrl'],
                                fit: BoxFit.scaleDown,
                                height: 70,
                                width: 70,
                              ),
                            ),
                            Text(
                              "${snapshot.data.docs[index]['for']}",
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            //${snapshot.data.docs[index]['type']}
                            Text(
                              "${snapshot.data.docs[index]['type']}",
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          //
        ],
      ),
    );
  }
}
