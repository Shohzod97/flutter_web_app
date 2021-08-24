import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_flutter/crud/editnotes.dart';
import 'package:course_flutter/crud/viewnotes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  CollectionReference notesRef = FirebaseFirestore.instance.collection('notes');
  var userID = FirebaseAuth.instance.currentUser!.uid;

  getUser(){
    User? user = FirebaseAuth.instance.currentUser; //даст signed-in user-а
    print(user!.email);
  }

  var fbm = FirebaseMessaging.instance;

  @override
  void initState() {
    fbm.getToken().then((token) {
      print('================');
      print(token);
    });
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        actions: [                        //добавили действие в шапку
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();             //выходим из аккаунта
              Navigator.of(context).pushReplacementNamed('login'); //заменяем стр. на стр. входа

            })
        ],
      ),

      body: Container(
        child: FutureBuilder(
            future: notesRef.where('userid', isEqualTo: userID).get(),  //т.о. получим данные именно этого юзера
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (snapshot.hasData)
              {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index){
                      return  Dismissible(
                        key: UniqueKey(),     //можно просто указать UniqueKey
                        onDismissed: (direction) async {   //оказывается мб любое название здесь

                          await notesRef.doc(snapshot.data!.docs[index].id).delete();  //удалили по id
                          await FirebaseStorage.instance.refFromURL(snapshot.data!.docs[index]['imageurl']).delete();

                          },
                        child: ListNotes(
                          currentNote: snapshot.data!.docs[index],
                          docid: snapshot.data!.docs[index].id,
                        ),
                      ); //snapshot.data!.docs[index].get('item'))
                      //Text('${snapshot.data.docs[index].data()['title']}');
                      //Text('${snapshot.data.docs[index]['title']}');
                    }
                );
              }

              return Center(child: CircularProgressIndicator());

        }),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
       child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).pushNamed('addnotes');
        },),
    );
  }
}



class ListNotes extends StatelessWidget {
  final currentNote;
  final docid;      //для EditTask
  const ListNotes({required this.currentNote, required this.docid});

  @override
  Widget build(BuildContext context) {
    return InkWell(          //обернули Card в InkWell, чтобы сделать его кликабельным (для ViewNote)
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return ViewNote(currentNote: currentNote);
        }));
      },

      child: Card(
        child: Row(       //Card сост. из Row [Image и ListTitle]
          children: [
            Expanded(
                flex: 1,
                child: currentNote['imageurl'] != null
                    ? Image.network(currentNote['imageurl'], fit: BoxFit.fill, height: 80,)
                    : Image.asset('images/logo.png', fit: BoxFit.contain, height: 50,)
            ),
            Expanded(
              flex: 3,
              child: ListTile(
                title: Text(currentNote['title']),
                subtitle: Text(currentNote['note'], style: TextStyle(fontSize: 14),),
                trailing: IconButton(icon: Icon(Icons.edit), onPressed: (){
                  //почему-то такой вариант использовал
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return EditNotes(
                      currentNote: currentNote,
                      docid: docid,);
                  }));

                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
