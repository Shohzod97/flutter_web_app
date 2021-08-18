import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  var formstate = GlobalKey<FormState>(); //для key в Form

  var usernameInputed, passwordInputed, emailInputed;

  /////////

  var invent7 = 0;
  var invent15 = 0;
  var invent35 = 0;

  var countPeople = 0;
  var rewardRef = 0;
  var pointsMP = 0;

  void setReawrdMP() {
    countPeople = invent7 + invent15 + invent35;
    pointsMP = invent7*50 + invent15*110 + invent35*280;
    rewardRef = invent7*1500 + invent15*4000 + invent35*7000;
  }

  //////
  var rewardPercent = 10;
  var leftB = 0;
  var rightB = 0;
  num rewardTO = 0.0;

  void setTOReward() {
    // var formdata = formstate.currentState;
   var min = leftB<rightB? leftB : rightB;
   print(min);
   rewardTO = (min/50)*7000*rewardPercent*0.01;
   print(rewardTO);

  }

  ///////////

  var currentQual = '';
  var rewardQual = 0;

  void setQualReward() => {

    if(leftB==3000 && rightB==3000) {
      currentQual = 'Серебро',
      rewardQual = 18000,
    },

    if(leftB==6000 && rightB==6000) {
      currentQual = 'Золото',
      rewardQual = 36000,
    },

    if(leftB==12000 && rightB==12000) {
      currentQual = 'Бриллиант',
      rewardQual = 72000,
    },
  };

  ///////////////////

  var premiumPercent = 26.5;

  var premium35 = 0;   //кол-во купленных за 35 т.
  var premium40 = 0;
  num premiumReward = 0.0;

  void setPremiumReward() {
    if((premium35+premium40)>=7)
    premiumReward = (premium35*35000 + premium40*40000)*premiumPercent*0.01;
    else
      premiumReward=0;
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(                    //если бы исп. Column, то при вводе текста вышла бы ошибка границ
        children: [
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
                        SizedBox(height: 20,),

                        //вход
                        buildEnterPay(),
                        SizedBox(height: 20,),

                        //товарооборот
                        buildTO(),
                        SizedBox(height: 20,),

                        buildPremium(),
                        SizedBox(height: 20,),

                        Container(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  setReawrdMP();
                                  setTOReward();
                                  setQualReward();
                                  setPremiumReward();
                                });
                              },
                              child: Text("Рассчитать",),
                            )),

                        //Квалиф. бонус

                        SizedBox(height: 40,),

                        Row(
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
                        ],),


                      ],
                    )),
              ),
              // SizedBox(width: 20),

            ],),




          // levelModel(),
        ],
      ),
    );
  }

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