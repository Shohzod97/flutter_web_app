import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  var formstate = GlobalKey<FormState>(); //для key в Form

  var usernameInputed, passwordInputed, emailInputed;

  /////////
  var choosedPay;

  final enterPayList = [7000, 15500, 35500];
  var rewardRef = 0;
  var pointsMP = 0;
  void setReawrdMP(choosedPay) => {

    if(choosedPay==null){
      rewardRef = 0,
      pointsMP = 0,
    },

    if(choosedPay == 7000) {
      rewardRef = 1500,
      pointsMP = 50,
    },

    if(choosedPay == 15500) {
      rewardRef = 4000,
      pointsMP = 110,
    },

    if (choosedPay == 35500) {
      rewardRef = 7000,
      pointsMP = 50,
    }

  };

  //////
  var choosedTO;

  final toList = ['350/350', '450/450'];
  var rewardTO = 0;
  void setTOReward(choosedTO) => {

    if(choosedTO==null){
      rewardTO = 0,
    },

    if(choosedTO == '350/350') {
      rewardTO = 4500,
    },

    if(choosedTO == '450/450') {
      rewardTO = 5800,
    },

  };

  ///////////
  var choosedQual;

  final qualList = ['3000/3000', '6000/6000', '12000/12000'];
  var currentQual = '';
  var rewardQual = 0;

  void setQualReward(choosedQual) => {

    if(choosedQual==null){
      currentQual = '',
      rewardQual = 0,
    },

    if(choosedQual == '3000/3000') {
      currentQual = 'Серебро',
      rewardQual = 18000,
    },

    if(choosedQual == '6000/6000') {
      currentQual = 'Золото',
      rewardQual = 36000,
    },

    if(choosedQual == '12000/12000') {
      currentQual = 'Бриллиант',
      rewardQual = 72000,
    },
  };



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
                        //Квалиф. бонус
                        buildQual(),

                        SizedBox(height: 20,),

                      ],
                    )),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Личная премия: $rewardRef'),
                  Text('Бонус за ТО: $rewardTO'),
                  Text('Квал. награда: $rewardQual'),
                  Text('Всего: ${rewardRef+rewardTO+rewardQual}'),
                ],),

            ],),

          levelModel(),
        ],
      ),
    );
  }

  Widget buildEnterPay() =>  Row(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Column(children: [
          Text('Вход'),
          // buildDropDown(choosedPay, enterPayList, setReawrdMP),
          Container(
            child:
            DropdownButtonHideUnderline(child:  //это чтобы убрать подчеркивающую линию
            DropdownButton<dynamic>(
              iconSize: 25,     //значок стрекли
              isExpanded: true, //чтобы стрелка в правом углу была
              value: choosedPay,
              items: enterPayList.map((item) => DropdownMenuItem(value: item, child: Text(item.toString()))).toList(),
              onChanged: (value) => setState(() {this.choosedPay = value; setReawrdMP(choosedPay);}),  //
            ),
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(width: 2)),
            width: 170,
            height: 40,
            padding: EdgeInsets.only(left: 30, right: 12, top: 4, bottom: 4), //внутренние отступы от стен
            margin: EdgeInsets.all(5),
          ),

          // SizedBox(height: 20,),

        ],),
        SizedBox(width: 50,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Реферальный бонус'),
            SizedBox(height: 10,),
            Text('Вход: ${choosedPay??0}'),
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
        Text('Товаровоборот'),
        // buildDropDown(choosedTO, toList, setTOReward),
        Container(
          child:
          DropdownButtonHideUnderline(child:  //это чтобы убрать подчеркивающую линию
          DropdownButton<dynamic>(

            iconSize: 25,     //значок стрекли
            isExpanded: true, //чтобы стрелка в правом углу была
            value: choosedTO,
            items: toList.map((item) => DropdownMenuItem(value: item, child: Text(item.toString()))).toList(),

            onChanged: (value) => setState(() {this.choosedTO = value; setTOReward(choosedTO);}),  //

          ),
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(width: 2)),
          width: 170,
          height: 40,
          padding: EdgeInsets.only(left: 30, right: 12, top: 4, bottom: 4), //внутренние отступы от стен
          margin: EdgeInsets.all(5),
        ),

        // SizedBox(height: 20,),
      ],),
      SizedBox(width: 50,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Бонус за Товарооборот'),
          SizedBox(height: 10,),
          Text('Товарооборот: ${choosedTO?? '0/0'}'),
          Text('Бонус за ТО: $rewardTO'),
        ],)

    ],
  );


  Widget buildQual() => Row(
    children: [
      Column(children: [
        Text('Кол-во баллов за мес.'),
        // buildDropDown(choosedTO, toList, setTOReward),
        Container(
          child:
          DropdownButtonHideUnderline(child:  //это чтобы убрать подчеркивающую линию
          DropdownButton<dynamic>(

            iconSize: 25,     //значок стрекли
            isExpanded: true, //чтобы стрелка в правом углу была
            value: choosedQual,
            items: qualList.map((item) => DropdownMenuItem(value: item, child: Text(item.toString(), ))).toList(),

            onChanged: (value) => setState(() {this.choosedQual = value; setQualReward(choosedQual);}),  //

          ),
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(width: 2)),
          width: 170,
          height: 40,
          padding: EdgeInsets.only(left: 30, right: 12, top: 4, bottom: 4), //внутренние отступы от стен
          margin: EdgeInsets.all(5),
        ),

        // SizedBox(height: 20,),
      ],),
      SizedBox(width: 50,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Квалификационный бонус'),
          SizedBox(height: 10,),
          Text('Кол-во баллов: ${choosedQual?? '0/0'}'),
          Text('Квалификация: $currentQual'),
          Text('Квал. награда: $rewardQual'),
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