import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HeroPage(),
    );
  }
}

class HeroPage extends StatefulWidget {
  @override
  _HeroPageState createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {

  @override
  Widget build(BuildContext context) {                  //Страница с героем

    return Scaffold(
        appBar: AppBar(
          title: Text("Герой"),
        ),
        body: Container(
          child: _buildStruct(),
        ));
  }

  Widget _buildStruct() => Container(
    color: Colors.white,
    child: ListView(children: [
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('okey'),
          ],
        ),
      ),
    ]),
  );
}

