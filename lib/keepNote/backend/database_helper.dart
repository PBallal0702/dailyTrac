import 'dart:io';
import 'note_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper{

  static Database _database;
  static DatabaseHelper _databaseHelper;

  DatabaseHelper._createInstance();
  factory DatabaseHelper(){
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async{
    if(_database==null){
      _database = await initializeDatabase();
    }
    return _database;
  }
  Future <Database> initializeDatabase()async{
    Directory directory = await getApplicationDocumentsDirectory();
    var path = directory.path +'notekeeper.db';
    var dogDatabase = await openDatabase(path,version: 1 ,onCreate: (db,version){
      return db.execute('''
        CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT, description TEXT )
      ''');
    });
    return dogDatabase;
  }

  Future<int> insertIntoDatabase(NoteModel note) async{
    Database db = await database;
    var result = db.insert('notes', note.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,);
    return result;
  }
  Future<List<NoteModel>> getNotes() async {

    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM notes');

    return List.generate(maps.length, (i) {
      return NoteModel(
        title: maps[i]['title'],
        description: maps[i]['description'],

      );
    });
  }
  Future<void> deleteNote(String id ,String id2) async {
    final db = await database;
    await db.delete(
      'notes',
      where: "title = ? and description =?",
      whereArgs: [id,id2],
    );
  }





}





