
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_flutter/component/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';                 //для file
import 'package:path/path.dart';  //для basename
import 'package:firebase_storage/firebase_storage.dart'; //для работы с фото


class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {

  var title, note, imageurl;
  File? file;

  var formstate = GlobalKey<FormState>();
  late Reference ref;  //для подкл. к пути для изображения
  CollectionReference notesRef = FirebaseFirestore.instance.collection('notes');

  //для кнопки 'Add Notes'
  addNotes(context) async{


    //вернет сообщение (прервет фун.)

    var formdata = formstate.currentState;

    if(formdata!.validate())
    {
      if(file == null) return AwesomeDialog(
        context: context,
        title: 'Not Image',
        body: Text('Please choose image'),
        dialogType: DialogType.ERROR,
      )..show();

      showLoading(context);

      await ref.putFile(file!);
      imageurl = await ref.getDownloadURL();

      formdata.save();
      await notesRef.add({
        'title' : title,
        'note' : note,
        'imageurl' : imageurl,

        'userid': FirebaseAuth.instance.currentUser!.uid,  //т.о. связываем с аккаунтом
      }).then((value) {
        Navigator.of(context).pushNamed('homepage');
      }).catchError((error){
        print(error);
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              key: formstate,
              child: Column(children: [
                TextFormField(
                  onSaved: (val){
                    title = val;
                  },
                  validator: (val) {
                    if (val!.length > 30) {
                      return "Title can't to be larger than 30 letter";
                    }
                    if (val.length < 1) {
                      return "Title can't to be less than 1 letter";
                    }
                    return null;
                  },
                  maxLength: 30,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Title Note',
                    prefixIcon: Icon(Icons.note),
                  ),
                ),

                TextFormField(
                  onSaved: (val){
                    note = val;
                  },
                  validator: (val) {
                    if (val!.length > 255) {
                      return "Note can't to be larger than 255 letter";
                    }
                    if (val.length < 1) {
                      return "Note can't to be less than 1 letter";
                    }
                    return null;
                  },
                  minLines: 1,
                  maxLines: 3,
                  maxLength: 200,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Note',
                    prefixIcon: Icon(Icons.note),
                  ),
                ),

                RaisedButton(
                    onPressed: (){
                      showBottomSheet(context);
                    },
                    textColor: Colors.white,
                    child: Text('Add Image For Note')
                ),

                RaisedButton(
                    onPressed: () async {
                      await addNotes(context);
                    },
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                    child: Text('Add Note', style: Theme.of(context).textTheme.headline6,)
                ),
              ],),
            )
          ],
        ),
      )

    );
  }


  showBottomSheet(context){
    return showModalBottomSheet(      //снизу выйдет Container с заголовком "Please choose image)
        context: context,             //и 2 кликабельными вариантами: 'From Gallery' и 'From Camera'
        builder: (context){
          return Container(
            padding: EdgeInsets.all(20),
            height: 190,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Please choose image', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                InkWell(
                  onTap: () async {

                    var xPicked = await ImagePicker().pickImage(source: ImageSource.gallery);

                    if (xPicked != null) {
                      file = File(xPicked.path);
                      var imageName = basename(xPicked.path); //взяли имя выбранной фотки (basename из 'package:path/path.dart')
                      //подключились к пути
                      ref = await FirebaseStorage.instance.ref('images').child(imageName);

                      // эту часть вынесли в кнопку добавления записи
                      // await ref.putFile(file!);
                      // imageurl = await ref.getDownloadURL();

                      Navigator.of(context).pop();  //закроет всплывающее окошко "Please choose image"
                    }

                    },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: Row(children: [
                      Icon(Icons.photo_outlined, size: 30,),
                      SizedBox(width: 20,),
                      Text('From Gallery', style: TextStyle(fontSize: 20),),
                    ],),
                  ),
                ),

                InkWell(
                  onTap: () async {

                    var xPicked = await ImagePicker().pickImage(source: ImageSource.camera);
                    //Код точно такой же как выше
                    if (xPicked != null){
                      file = File(xPicked.path);
                      var imageName = basename(xPicked.path);
                      ref = await FirebaseStorage.instance.ref('images').child(imageName);

                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: Row(children: [
                      Icon(Icons.camera, size: 30),
                      SizedBox(width: 20,),
                      Text('From Camera', style: TextStyle(fontSize: 20),),
                    ],),
                  ),
                ),
              ],
            ),
          );
        });
  }
}