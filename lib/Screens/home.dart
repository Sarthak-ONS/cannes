import 'package:cannes/Widgets/trending_widget.dart';
import 'package:cannes/list_main_categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Widgets/home_page_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
          const SizedBox(
            height: 125,
            child: TrendingWidget(),
          ),
          const SizedBox(
            height: 35,
          ),
          SizedBox(
            height: 450,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listMainCategories.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      listMainCategories[index],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
