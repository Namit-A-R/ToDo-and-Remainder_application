import 'package:get/get.dart';
import 'package:remainder_application/database/notes_database/models/note.dart';
import 'package:remainder_application/database/notes_database/notes_db_helper.dart';


class NoteController extends GetxController{

  Future<int> addNote({Note? note}) async{
    return await NotesDBHelper.insert(note);
  }

  var noteList = <Note>[].obs;

  void getNotes() async{
    print("note get notes called");
    List<Map<String, dynamic>> notes = await NotesDBHelper.query();
    noteList.assignAll(notes.map((data) => Note.fromJson(data)).toList());
  }

  void delete(Note note){
    NotesDBHelper.delete(note);
    getNotes();
  }

  void markToComplete(int id){
    NotesDBHelper.markToComplete(id);
    getNotes();
  }

  void editNote(int id, String title, var note, int color){
    NotesDBHelper.editNote(
      id,
      title,
      note,
      color
    );
    getNotes();
  }

  NoteController(){
    getNotes();
  }

}