import 'package:flutter/material.dart';
import 'package:remainder_application/database/notes_database/models/note.dart';
import 'package:sqflite/sqflite.dart';


class NotesDBHelper{

  static Database? _db;
  static const int _version = 2;
  static const String _tableName = "loliNotes";

  static Future<void> initDb() async{
    print("DBHelper got called");
    if(_db != null){
      return;
    }
    try{
      String _path = await getDatabasesPath() + 'loliNotes';
      _db = await openDatabase(
          _path,
          version: _version,
          onCreate: (db, version){
            print("Creating a new one");
            return db.execute(
                "CREATE TABLE $_tableName("
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                    "title STRING, note TEXT, "
                    "color INTEGER, "
                    "isCompleted INTEGER)"
            );
          }
      );
    }catch(e){
      print(e);
    }
  }
  static Future<int> insert(Note? note) async{
    print("Insert function called");
    return await _db?.insert(_tableName, note!.toJson())??1;
  }

  static Future<List<Map<String, dynamic>>> query() async{
    print("note query function called");
    return await _db!.query(_tableName);
  }

  static delete(Note note) async{
    await _db!.delete(_tableName, where:"id=?", whereArgs: [note.id]);
  }

  static markToComplete(int id) async{
    await _db!.rawUpdate('''
      UPDATE $_tableName
      SET isCompleted = ?
      WHERE id = ?
    ''',[1,id]);
  }
  static statusUpdateToIncomplete(int id) async{
    await _db!.rawUpdate('''
      UPDATE $_tableName
      SET isCompleted = ?
      WHERE id = ?
    ''',[0,id]);
  }

  static editNote(int id, String title, String note, int color) async{
    Map<String, dynamic> data = {
      "title" : title,
      "note" : note,
      "color" : color,
    };
    await _db!.update(_tableName, data, where: 'id = ?', whereArgs: [id]);
  }


}