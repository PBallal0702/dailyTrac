import 'package:flutter/material.dart';
import 'package:dailyTrac/keepNote/backend/database_helper.dart';
import 'package:dailyTrac/keepNote/backend/note_model.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  DatabaseHelper helper = DatabaseHelper();
  String tempTitle;
  String tempDescription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2D2F41),
        centerTitle: true,
        title: Text(
          'Add Notes',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w900),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: TextField(
                  onChanged: (newTitle) {
                    print(newTitle);
                    tempTitle = newTitle;
                  },
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: TextField(
                  onChanged: (newDescription) {
                    print(newDescription);
                    tempDescription = newDescription;
                  },
                  decoration: InputDecoration(
                      labelText: 'Desciption',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      color: Color(0xFF2D2F41),
                      textColor: Colors.white,
                      child: Text(
                        'save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          print('save pressed');
                          save(tempTitle, tempDescription);
                          //save(tempName,tempType);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void save(String title, String description) {
    NoteModel note = NoteModel(title: title, description: description);
    helper.insertIntoDatabase(note);
    Navigator.pop(context);
  }
}
