import '../auth/login.dart';
import '../auth/signup.dart';
import '../crud/addnotes.dart';
import '../home/homepage.dart';
// import '../test.dart';
// import '../testtwo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

bool islogin=true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //Проверяем, залогинился ли user
  User? user = FirebaseAuth.instance.currentUser;  //проверяем есть ли signed-in user
  if (user == null)  islogin = false;             //если нет, то говорим, что вход в систему не был (покажем Login)
  else islogin = true;                            //иначе - был (покажем HomePage)

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: islogin == false ? Login() : HomePage(),
      // home: Test(),
      theme: ThemeData(
          fontFamily: "NotoSerif",
          primaryColor: Colors.blue,
          buttonColor: Colors.blue,
          textTheme: TextTheme(
            headline6: TextStyle(fontSize: 20, color: Colors.white),
            headline5: TextStyle(fontSize: 30, color: Colors.blue),
            bodyText2: TextStyle(fontSize: 20, color: Colors.black),
          )),

      routes: {
        "login": (context) => Login(),
        "signup": (context) => SignUp(),
        "homepage": (context) => HomePage(),
        "addnotes": (context) => AddNotes(),
        // "testtwo": (context) => TestTwo()
      },
    );
  }
}
