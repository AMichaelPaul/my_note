import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;
  static final noteTable = "note_table";

  static final columnId = "id";
  static final noteTitle = "note_title";
  static final noteDescribtion = "note_describtion";
  static final noteDate = "note_date";

  static  Database _database ;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $noteTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $noteTitle TEXT, $noteDescribtion TEXT, $noteDate TEXT)",
    );
  }

 Future<int> insert(String title,String desc)async{
    await database;
    return await _database.insert(noteTable, {
        "note_title":title,
        "note_describtion":desc,
        "note_date":DateTime.now().toString()
    });
 }

 Future<List<Map<String,dynamic>>> getNotesData()async{
    await database;
    return await _database.rawQuery("SELECT * FROM $noteTable");
 }

 Future<int> deleteItem(int id)async{
    await database;
   return await _database.delete(noteTable,where: "id=?",whereArgs: [id]);
 }
}