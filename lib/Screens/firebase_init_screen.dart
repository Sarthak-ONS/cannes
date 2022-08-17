import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Widgets/something_went_wrong_widget.dart';
import 'home.dart';

class InitFirebaseScreen extends StatefulWidget {
  const InitFirebaseScreen({Key? key}) : super(key: key);

  @override
  State<InitFirebaseScreen> createState() => _InitFirebaseScreenState();
}

class _InitFirebaseScreenState extends State<InitFirebaseScreen> {
  initializeFirebaseApp() async {
    return await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    );
  }
}
