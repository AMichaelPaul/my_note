class Note {
  final int id;
  final String title;
  final String describtion;
  final String date;

  Note({this.id, this.title, this.describtion, this.date});

  Map<String, dynamic> toMap() {
    return {
      'note_title': title,
      'note_describtion': describtion,
      "note_date": DateTime.now().toString()
    };
  }

}
