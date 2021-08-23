import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  var formstate = GlobalKey<FormState>(); //для key в Form

  /////////

  var gPackage = 6998;
  var gLevel = 5;
  num gPercent = 10;

  num gReward = 0.0;
  num gPeople = 0;
  num gProfit = 0;
  num gExpense = 0;
  num gDiffer = 0;

  num perProfit = 60;

  num gPerProfit = 0;
  num gPerDiffer = 0;
  num gK = 0.0;
  num gkCheck = 0;
  num gShoudExpense = 0;

  void setGeneral() {

    gReward = 4*gPackage*gPercent*0.01;
    gPeople = pow(2, gLevel);
    gProfit = gPackage*gPeople;
    gExpense = gReward*(gLevel-1)*pow(2,gLevel-2);
    gDiffer = gProfit-gExpense;

    gPerProfit = gProfit*perProfit*0.01;
    gPerDiffer = gPerProfit-gExpense;
    gK = gPerProfit/gExpense;
    gkCheck = gPerProfit-(gK*gExpense);
    gShoudExpense = gPerDiffer>=0 ? gExpense : gExpense*gK;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(                    //если бы исп. Column, то при вводе текста вышла бы ошибка границ
        children: [
          SizedBox(height: 20,),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Form(
                    key: formstate,           //key - хранит состояние формы
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        buildGeneralculc(),

                        //вход
                        // buildEnterPay(),
                        // SizedBox(height: 20,),
                        //
                        // //товарооборот
                        // buildTO(),
                        // SizedBox(height: 20,),
                        //
                        // buildPremium(),

                        SizedBox(height: 20,),
                        Container(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {

                                  setGeneral();

                                  // setReawrdMP();
                                  // setTOReward();
                                  // setQualReward();
                                  // setPremiumReward();
                                });
                              },
                              child: Text("Рассчитать",),
                            )),

                        //Квалиф. бонус

                        SizedBox(height: 40,),
                        // buildQualAndAll(),



                      ],
                    )),
              ),
              // SizedBox(width: 20),

            ],),

        ],
      ),
    );
  }


  Widget buildGeneralculc() => Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Общие расчеты'),
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Text('Вход:'),
                SizedBox(width: 85),
                SizedBox(
                  width: 100,
                  child:TextFormField(
                    initialValue: '7000',
                    onChanged: (val){ gPackage = int.parse(val); },

                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))
                    ),
                  ),),],
            ),
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Text('Уровень'),
                SizedBox(width: 63),
                SizedBox(
                  width: 50,
                  child:TextFormField(
                    initialValue: '5',
                    onChanged: (val){ gLevel = int.parse(val); },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))
                    ),
                  ),),
              ],
            ),

            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Text('% награды'),
                SizedBox(width: 48),
                SizedBox(
                  width: 50,
                  child:TextFormField(
                    initialValue: '10',
                    onChanged: (val){ gPercent = double.parse(val); },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))
                    ),
                  ),),
              ],
            ),

            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Text('В сеть пойдет %:'),
                SizedBox(width: 10),
                SizedBox(
                  width: 50,
                  child:TextFormField(
                    initialValue: '60',
                    onChanged: (val){ perProfit = double.parse(val); },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))
                    ),
                  ),),
              ],
            ),



          ],),
        SizedBox(width: 165,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Общие рассчеты:'),
            SizedBox(height: 10,),
            Text('Награда за цикл (4 чел): $gReward'), SizedBox(height: 5,),
            Text('Клиентов на уровне: $gPeople'), SizedBox(height: 5,),
            Text('Доход с ур.: $gProfit'), SizedBox(height: 5,),
            Text('Расход с ур.: $gExpense'), SizedBox(height: 5,),
            Text('Доход-расход: $gDiffer'),
          ],
        ),

        SizedBox(width: 165,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Расчеты с коэффициентом:'),
            SizedBox(height: 10,),
            Text('$perProfit% дохода это: $gPerProfit'), SizedBox(height: 5,),
            Text('$perProfit% дохода - расход: $gPerDiffer'), SizedBox(height: 5,),
            Text('Уравнивающий коэфф.: $gK'), SizedBox(height: 5,),
            Text('Проверка: $gkCheck'), SizedBox(height: 5,),
            Text('Расход дол. быть: $gShoudExpense'),
          ],
        ),
      ]
  );

  Widget buildQualAndAll() => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Квалификационный бонус'),
          SizedBox(height: 10,),
          Text('Кол-во баллов: '),
          Text('Квалификация: $currentQual'),
          Text('Квал. награда: $rewardQual'),
        ],),
      SizedBox(width: 130,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Всего: ${rewardRef+rewardTO+rewardQual+premiumReward}'),
          SizedBox(height: 10,),
          Text('Личная премия: $rewardRef'),
          Text('Бонус за ТО: $rewardTO'),
          Text('Квал. награда: $rewardQual'),
          Text('Премиальный бонус: $premiumReward'),

        ],),
    ],);


  Widget buildEnterPay() => Row(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text('Лично приглашенных'),
          SizedBox(height: 10,),
          Row(
            children: <Widget>[
              Text('По 7000'),
              SizedBox(width: 16),
              SizedBox(
                width: 50,
                child:TextFormField(
                  initialValue: '0',
                  onChanged: (val){ invent7 = int.parse(val); },
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1))
                  ),
                ),),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: <Widget>[
              Text('По 15500'),
              SizedBox(width: 10),
              SizedBox(
                width: 50,
                child:TextFormField(
                  initialValue: '0',
                  onChanged: (val){ invent15 = int.parse(val); },
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1))
                  ),
                ),),
            ],
          ),
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Text('По 35500'),
                SizedBox(width: 10),
                SizedBox(
                  width: 50,
                  child:TextFormField(
                    initialValue: '0',
                    onChanged: (val){ invent35 = int.parse(val); },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))
                    ),
                  ),),
              ],
            ),



        ],),
        SizedBox(width: 165,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Реферальный бонус'),
            SizedBox(height: 10,),
            Text('Пакетов: $countPeople'),
            Text('Личная премия: $rewardRef'),
            Text('Баллы в МП: $pointsMP'),
          ],
        ),
      ]
  );

  Widget buildTO() => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Column(children: [
        Text('Товарооборот'),
        SizedBox(height: 10),
        SizedBox(
          width: 80,
          child: TextFormField(
            initialValue: '10',
            onChanged: (val){ rewardPercent = int.parse(val); },
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
                labelText: "% награды",

                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1))

            ),
            style: Theme.of(context).textTheme.body1,
          ),),
        SizedBox(height: 10),

        Row(
          children: <Widget>[
            SizedBox(
              width: 110,
              child: TextFormField(
                onChanged: (val){ leftB = int.parse(val); },
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    labelText: "Левая ветвь",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1))

                ),
                style: Theme.of(context).textTheme.body1,
              ),),

            SizedBox(width: 10),

            SizedBox(
              width: 110,
              child:TextFormField(
                onChanged: (val){ rightB = int.parse(val); },
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    labelText: "Правая ветвь",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1))

                ),
                style: Theme.of(context).textTheme.body1,
              ),),

          ],
        ),

        // SizedBox(height: 20,),
      ],
      ),

      SizedBox(width: 80,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Бонус за Товарооборот'),
          SizedBox(height: 10,),
          Text('Товарооборот: $leftB/$rightB'),
          Text('Бонус за ТО: $rewardTO'),
        ],)

    ],
  );


  Widget buildPremium() => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Column(children: [
        Text('Премиальная система'),
        SizedBox(height: 10),

        // SizedBox(
        //   width: 150,
        //   child: TextFormField(
        //     initialValue: '10',
        //     onChanged: (val){ rewardPercent = int.parse(val); },
        //     keyboardType: TextInputType.number,
        //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        //     decoration: const InputDecoration(
        //         labelText: "% награды",
        //
        //         border: OutlineInputBorder(
        //             borderSide: BorderSide(width: 1))
        //
        //     ),
        //     style: Theme.of(context).textTheme.body1,
        //   ),
        // ),

        SizedBox(height: 10),

        Row(
          children: <Widget>[
            Text('% награды'),
            SizedBox(width: 15),
            SizedBox(
              width: 60,
              child:TextFormField(
                initialValue: '25.6',
                onChanged: (val){ premiumPercent = double.parse(val); },
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1))
                ),
              ),),
          ],
        ),

        SizedBox(height: 10),

        Row(
          children: <Widget>[
            Text('По 35000'),
            SizedBox(width: 25),
            SizedBox(
              width: 60,
              child:TextFormField(
                initialValue: '0',
                onChanged: (val){ premium35 = int.parse(val); },
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1))
                ),
              ),),
          ],
        ),
        SizedBox(height: 10,),

        Row(
          children: <Widget>[
            Text('По 40000'),
            SizedBox(width: 25),
            SizedBox(
              width: 60,
              child:TextFormField(
                initialValue: '0',
                onChanged: (val){ premium40 = int.parse(val); },
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1))
                ),
              ),),
          ],
        ),
        SizedBox(height: 10,),

        // SizedBox(height: 20,),
      ],
      ),

      SizedBox(width: 80,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Премильная система'),
          SizedBox(height: 10,),
          Text('Кол-во контрактов: ${premium35+premium40}'),
          Text('Премиальный бонус: $premiumReward'),
        ],)

    ],
  );



  Widget userBlock(name) => Container(
    child: Text(name),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border.all(
        width: 2,
        color: Colors.black,
      ),
    ),
  );
  Widget levelModel() => Column(children: [
    SizedBox(height: 20,),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        userBlock('0-ой уровень')
      ],),
    SizedBox(height: 20,),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

        userBlock('1-ый уровень'),
        userBlock('1-ый уровень')


      ],),
    SizedBox(height: 20,),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        userBlock('2-ой уровень'),
        userBlock('2-ой уровень'),
        userBlock('2-ой уровень'),
        userBlock('2-ой уровень'),

      ],),
    SizedBox(height: 20,),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        userBlock('3-ий уровень'),
        userBlock('3-ий уровень'),
        userBlock('3-ий уровень'),
        userBlock('3-ий уровень'),
        userBlock('3-ий уровень'),
        userBlock('3-ий уровень'),
        userBlock('3-ий уровень'),
        userBlock('3-ий уровень'),

      ],),
  ],);
}