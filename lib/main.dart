import 'package:cannes/Providers/cart_screen_ui_provider.dart';
import 'package:cannes/Providers/product_config_provider.dart';
import 'package:cannes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Providers/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductConfigProvider()),
        ChangeNotifierProvider(create: (_) => CartScreenUIProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'PoppinsRegular',
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator().generateRoute,
      ),
    );
  }
}
