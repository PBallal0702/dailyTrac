import 'package:flutter/material.dart';
import 'screens/add_note_screen.dart';
import 'note_keeper_body.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      appBar: AppBar(
        backgroundColor: Color(0xFF2D2F41),
        title: Text(
          'Note Keeper',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.library_add,
          color: Color(0xFF2D2F41),
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddNote();
          }));
        },
      ),
    );
  }
}
