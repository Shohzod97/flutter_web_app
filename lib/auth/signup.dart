import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../component/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var formstate = GlobalKey<FormState>(); //для key в Form

  var usernameInputed, passwordInputed, emailInputed;

  signUpFunc() async{

    var formdata = formstate.currentState; //сохр. текущее сост. (данные) формы в formdata
    if (formdata!.validate())    //если данные прошли проверку валидации (которую мы вставили в TextField)
      {
        print('valid');
        formdata.save();  //сохранит текущие данные из формы (email, password, username)
        //пробуем зарегистрировать пользователя
        try {
          UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailInputed,
              password: passwordInputed,
          );
          return userCredential;                //если успешно, то signUpFunc() = userCredential

        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {         //если пароль слабы
            AwesomeDialog(                        //то выйдет диалг. окно
                context: context,
                title: 'Error',
                body: Text('Password is to weak'))..show();  //без ..show() не покажет
          }
          else if (e.code == 'email-already-in-use') {
            AwesomeDialog(
                context: context,
                title: 'Error',
                body: Text('The account already exists for that email'))..show();
          }
        } catch (e) {
          print(e);
        }

      }
    else print('Not valid');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(                    //если бы исп. Column, то при вводе текста вышла бы ошибка границ
        children: [
          SizedBox(height: 100),
          Center(child: Image.asset("images/logo.png")),
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: formstate,           //key - хранит состояние формы
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (val){ usernameInputed = val; },  //сохр. знач. в username
                      validator: (val) {
                        if (val!.length > 100) {    //если длина текста > 100
                          return "username can't to be larger than 100 letter";
                        }
                        if (val.length < 2) {      //если длина текста < 2
                          return "username can't to be less than 2 letter";
                        }
                        return null;              //если всё ок, то ниче не даст
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),   //иконка слева
                          hintText: "username",
                          border: OutlineInputBorder(      //обводка для поля
                              borderSide: BorderSide(width: 1))),
                    ),

                    SizedBox(height: 20),

                    TextFormField(
                      onSaved: (val){ emailInputed = val; },

                      validator: (val) {
                        if (val!.length > 100) {
                          return "Email can't to be larger than 100 letter";
                        }
                        if (val.length < 2) {
                          return "Email can't to be less than 2 letter";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail_outline),
                          hintText: "email",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),

                    SizedBox(height: 20),

                    TextFormField(
                      onSaved: (val){ passwordInputed = val; },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "Password can't to be larger than 100 letter";
                        }
                        if (val.length < 4) {
                          return "Password can't to be less than 4 letter";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          hintText: "password",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),

                    Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text("if you have Account "),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed("login");
                              },
                              child: Text(
                                "Click Here",
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        )),

                    Container(
                        child: RaisedButton(
                      textColor: Colors.white,
                      onPressed: () async {
                        //signUpFunc() - зарегает и вернет userCredential, если успешно зарегает или null
                        //т.е. это отклик от сервера(response)
                        UserCredential? response = await signUpFunc();

                        if (response != null) {       //если отклик успешный
                          await FirebaseFirestore.instance.collection("users").add({  //то дополнительно доб. в колл. 'users'
                                "username": usernameInputed,                          //док. с username, email
                                "email": emailInputed
                          });
                          Navigator.of(context).pushReplacementNamed("homepage");    //и покажем главную страницу
                        }
                        else {
                          print("===================");
                          print("Sign Up Faild");
                        }
                      },
                      child: Text(
                        "Sign Up",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ))

                  ],
                )),
          )
        ],
      ),
    );
  }
}
