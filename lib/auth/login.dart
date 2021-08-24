import 'package:awesome_dialog/awesome_dialog.dart';
import '../component/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var formstate = new GlobalKey<FormState>();

  var passwordInputed, emailInputed;

  //аналогично signUpFunc
  signInFunc() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      print('valid');
      formdata.save();
      try {
        showLoading(context);         // кружок загрузки (alert.dart)

        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailInputed,
            password: passwordInputed
        );

        return userCredential;   //(после return закроет showLoading, как я понимаю)

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();        //закроет showLoading (иначе беск. показ. кружок загрузки)
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("No user found for that email"))..show();
        }
        else if (e.code == 'wrong-password') {
          Navigator.of(context).pop();        //закроет showLoading
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("Wrong password provided for that user"))..show();
        }
      }
    } else {
      print("Not Vaild");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset("images/logo.png")),
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
                key: formstate,
                child: Column(
                  children: [

                    TextFormField(
                      onSaved: (val) {
                        emailInputed = val;
                      },
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
                          prefixIcon: Icon(Icons.person),
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),

                    SizedBox(height: 20),

                    TextFormField(
                      onSaved: (val) {
                        passwordInputed = val;
                      },
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
                          prefixIcon: Icon(Icons.person),
                          hintText: "password",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),

                    Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text("if you haven't account "),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed("signup");
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

                        UserCredential? response = await signInFunc();

                        if (response != null) {
                          Navigator.of(context).pushReplacementNamed("homepage");
                        }
                      },
                      child: Text("Sign in", style: Theme.of(context).textTheme.headline6,),
                    ))
                  ],
                )),
          )
        ],
      ),
    );
  }
}

/*

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Please Wait"),
          content: Container(
              height: 50,
              child: Center(
                child: CircularProgressIndicator(),
              )),
        );
      });
}


*/
