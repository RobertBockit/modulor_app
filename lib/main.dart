import 'package:flutter/material.dart';
import 'package:modulor_app/providers/cart_provider.dart';
import 'package:modulor_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:modulor_app/providers/app_state.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppState()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'AtkinsonHyperlegible',
        scaffoldBackgroundColor: Colors.white,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,

      home: MainScreen(),
    );
  }
}
