import 'package:flutter/cupertino.dart';
import 'package:my_note/models/note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _listNotes = [];

  List<Note> get listNotes => _listNotes;

  set listNotes(List<Note> value) {
    _listNotes = value;
    notifyListeners();
  }

  void addNote(Note note) {
    _listNotes.add(note);
    notifyListeners();
  }
}
