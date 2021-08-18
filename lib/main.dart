import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'first_page.dart';
import 'second_page.dart';



void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SecondPage(),

      routes: {
        'home': (context) => HomePage(),
        "first": (context) => FirstPage(),
        "second": (context) => SecondPage(),
      },
    );
  }
}
