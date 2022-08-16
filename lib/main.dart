import 'package:cannes/Screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Widgets/something_went_wrong_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  initializeFirebaseApp() async {
    return await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'PoppinsRegular',
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: initializeFirebaseApp(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            if (kDebugMode) {
              print(snapshot..error);
            }
            return const SomethingWentWrong();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return const HomeScreen();
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
