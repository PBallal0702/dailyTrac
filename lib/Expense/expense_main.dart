import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:dailyTrac/Expense/screens/home_screen.dart';

class ExpenseMain extends StatefulWidget {
  ExpenseMain({Key key}) : super(key: key);

  @override
  _ExpenseMainState createState() => _ExpenseMainState();
}

class _ExpenseMainState extends State<ExpenseMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Tracker',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF2D2F41),
      ),
      extendBody: true,
      body: ExpenseHome(),
    );
  }
}
