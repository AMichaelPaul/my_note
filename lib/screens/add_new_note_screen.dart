import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_note/database/database_helper.dart';
import 'package:my_note/models/note.dart';
import 'package:my_note/providers/note_provider.dart';
import 'package:provider/provider.dart';

class AddNewNoteScreen extends StatelessWidget {
  final dbHelper = DatabaseHelper();
  String title;
  String describtion;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.amber,
      child: Icon(
        Icons.add,
        size: 35,
        color: Colors.black,
      ),
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: "Title"),
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                      // move focus to next
                      onChanged: (value) => title = value,
                    ),
                    TextField(
                        decoration: InputDecoration(labelText: "Describtion"),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => FocusScope.of(context).unfocus(),
                        // submit and hide keyboard
                        onChanged: (value) => describtion = value),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                        color: Colors.amber,
                        child: Text(
                          "Add",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          insertNote();
                          Provider.of<NoteProvider>(context, listen: false)
                              .addNote(
                                  Note(title: title, describtion: describtion));
                          Navigator.pop(context);
                        })
                  ],
                ),
              );
            });
      },
    );
  }

  void insertNote() async {
    int res = await dbHelper.insert(title, describtion);
  }
}
