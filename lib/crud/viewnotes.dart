import 'package:flutter/material.dart';

class ViewNote extends StatefulWidget {
  final currentNote;
  ViewNote({Key? key, this.currentNote}) : super(key: key);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Notes'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
                child: widget.currentNote['imageurl'] != null
                    ? Image.network(widget.currentNote['imageurl'], width: double.infinity, height: 300, fit: BoxFit.fill,)
                    : Image.asset('images/logo.png', width: double.infinity,  height: 100,  fit: BoxFit.contain,)
            ),

            Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Text("${widget.currentNote['title']}", style: Theme.of(context).textTheme.headline5,)),

            Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Text("${widget.currentNote['note']}", style: Theme.of(context).textTheme.bodyText2,)),
          ],
        ),
      ),
    );
  }
}
