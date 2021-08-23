import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(                    //если бы исп. Column, то при вводе текста вышла бы ошибка границ
        children: [
          ElevatedButton(
            child: Text('Первый вариант'),
            onPressed: (){Navigator.of(context).pushNamed("first");}, ),

          ElevatedButton(
            child: Text('Второй вариант'),
            onPressed: (){Navigator.of(context).pushNamed("second");}, ),




          // levelModel(),
        ],
      ),
    );
  }
}