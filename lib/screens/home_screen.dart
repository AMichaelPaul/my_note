import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_note/database/database_helper.dart';
import 'package:my_note/models/note.dart';
import 'package:my_note/providers/note_provider.dart';
import 'package:my_note/screens/add_new_note_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbHelper = DatabaseHelper();
  List<Note> myNotes = [];

  @override
  void initState() {
    super.initState();
    getDataFromSql();
  }

  @override
  Widget build(BuildContext context) {
    myNotes = Provider.of<NoteProvider>(context).listNotes;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.amber));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 5,
        title: Text(
          "My Note",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: AddNewNoteScreen(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(myNotes[index].title.toString()),
            subtitle: Text(myNotes[index].describtion.toString()),
            trailing: InkWell(
                onTap: () async {
                  await dbHelper.deleteItem(myNotes[index].id);
                  setState(() {
                    myNotes.removeAt(index);
                  });
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 35,
                )),
          );
        },
        itemCount: myNotes.length,
      ),
    );
  }

  void getDataFromSql() async {
    List<Map<String, dynamic>> notes = await dbHelper.getNotesData();
    List<Note> temp = [];
    for (int i = 0; i < notes.length; i++) {
      temp.add(Note(
          id: notes[i]["id"],
          title: notes[i]["note_title"],
          describtion: notes[i]["note_describtion"],
          date: notes[i]["note_date"]));
    }

    Provider.of<NoteProvider>(context, listen: false).listNotes = temp;
  }
}
