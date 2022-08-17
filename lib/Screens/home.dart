import 'package:cannes/Services/firestore_api.dart';
import 'package:cannes/Widgets/new_arrival_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Widgets/age_category_widget.dart';
import '../Widgets/home_page_card.dart';
import '../Widgets/trending_widget.dart';

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
      backgroundColor: Colors.white,
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
            FireStoreApi().addProductsToDatabase();
            //_scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        children: const [
          Center(
            child: Text(
              "Free membership for members above 999! Join Now",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          HomePageCardWidget(
            image:
                "https://lp2.hm.com/hmgoepprod?set=quality%5B79%5D%2Csource%5B%2Ff0%2F78%2Ff07833762c686d57abd5526e566f007ccc4f80eb.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BLOOKBOOK%5D%2Cres%5Bm%5D%2Chmver%5B1%5D&call=url[file:/product/main]",
            subHeading: "It is the key perfect layered look.",
            heading: "THE item: Loose Trousers",
            isTextCenter: true,
          ),
          HomePageCardWidget(
            image:
                "https://lp2.hm.com/hmgoepprod?set=width[1920],quality[80],options[limit]&source=url[https://www2.hm.com/content/dam/ladies_s06/july_2022/7406b/7406B-3x2.jpg]&scale=width[global.width],height[15000],options[global.options]&sink=format[jpg],quality[global.quality]",
            heading: "Light Moves",
            subHeading: "Keep It Light",
            isTextCenter: true,
          ),
          SizedBox(
            height: 35,
          ),
          Padding(
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
            child: TrendingWidget(),
          ),
          SizedBox(
            height: 35,
          ),
          AgeCategoryWidget(),
          SizedBox(
            height: 35,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
            child: Text(
              "New Arrivals",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                fontSize: 20,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          NewArrival(),
          HomePageCardWidget(
            image:
                "https://user-images.githubusercontent.com/57105611/184881934-b14ec179-58d4-46a7-b8cc-7c5dbd37c9cf.jpg",
          ),
          HomePageCardWidget(
            image:
                "https://images.pexels.com/photos/934070/pexels-photo-934070.jpeg?auto=compress&cs=tinysrgb&w=600",
            heading: "Press : Fresh",
            subHeading: "",
            isTextCenter: true,
          ),
        ],
      ),
    );
  }
}
