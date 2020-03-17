import 'package:flutter/material.dart';
import 'package:iwas_port/Models/Order.dart';
import 'package:iwas_port/Screens/Authenticate/TextInputForm_decoration.dart';

class Notes extends StatefulWidget {
  final Order transaction;

  Notes({this.transaction});

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  var notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        height: 190,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Notes', style: Theme.of(context).textTheme.body1),
                  ],
                ),
                Divider(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        onChanged: (text) => widget.transaction.note = text,
                        style:
                            Theme.of(context).inputDecorationTheme.labelStyle,
                        controller: notesController,
                        keyboardType: TextInputType.text,
                        maxLines: 3,
                        cursorColor:
                            Theme.of(context).inputDecorationTheme.focusColor,
                        decoration: textFormDecoration(context).copyWith(
                          labelText: 'Notes',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
