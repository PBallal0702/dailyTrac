import 'package:flutter/material.dart';
import 'screens/no_note_screen.dart';
import 'backend/database_helper.dart';
import 'backend/note_model.dart';
import 'package:sqflite/sqflite.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int count = 0;
  DatabaseHelper databaseHelper = new DatabaseHelper();
  List<NoteModel> noteList;
  @override
  Widget build(BuildContext context) {
    updateListView();
    return (count == 0)
        ? NoNote()
        : ListView.builder(
            itemBuilder: (BuildContext context, index) {
              return Container(
                margin: EdgeInsets.only(left: 32, right: 32, top: 15),
                child: Container(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(noteList[index].title),
                    subtitle: Text(noteList[index].description),
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.view_list,
                        color: Colors.white,
                      ),
                      backgroundColor: Color(0xFF2D2F41),
                      radius: 15,
                    ),
                    trailing: GestureDetector(
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onTap: () {
                        setState(() {
                          databaseHelper.deleteNote(noteList[index].title,
                              noteList[index].description);
                          print('delete pressed');
                        });
                      },
                    ),
                  ),
                ),
              );
            },
            itemCount: count,
          );
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<NoteModel>> noteListFuture = databaseHelper.getNotes();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
