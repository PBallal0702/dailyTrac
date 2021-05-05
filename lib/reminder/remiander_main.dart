import 'dart:ui';
import 'package:dailyTrac/reminder/remianderScreens/remiander_screen.dart';
import 'package:flutter/material.dart';

class RemianderMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      appBar: AppBar(
        backgroundColor: Color(0xFF2D2F41),
        title: Text(
          'Reminder ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        child: RemianderList(),
      ),
    );
  }
}
