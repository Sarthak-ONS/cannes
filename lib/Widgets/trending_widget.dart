import 'package:cannes/Widgets/something_went_wrong_widget.dart';
import 'package:cannes/Widgets/trending_widget_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TrendingWidget extends StatelessWidget {
  const TrendingWidget({Key? key}) : super(key: key);

  getTrendingCollections() async {
    final res = await FirebaseFirestore.instance.collection('Trending').get();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
              return TrendingWidgetCard(
                imageUrl: snapshot.data.docs[index]['imageUrl'],
                forGender: snapshot.data.docs[index]['for'],
                type: snapshot.data.docs[index]['type'],
              );
            },
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
