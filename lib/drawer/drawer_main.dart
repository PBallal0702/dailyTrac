import 'package:dailyTrac/Expense/expense_main.dart';
import 'package:dailyTrac/reminder/remiander_main.dart';
import 'package:flutter/material.dart';
import 'package:dailyTrac/keepNote/note_keeper_home.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          color: Color(0xFF2D2F41),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: CircleAvatar(
                    child: Icon(Icons.track_changes_rounded, size: 60),
                    radius: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Daily Track',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        ListTile(
          leading: Icon(
            Icons.alarm_add,
            color: Colors.black,
          ),
          title: Text(
            'Reminder',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            print("ontap pressed");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RemianderMain()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.note_add,
            color: Colors.black,
          ),
          title: Text(
            'Keep Note',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            print("ontap pressed");
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.account_balance_wallet_outlined,
            color: Colors.black,
          ),
          title: Text(
            'Expense Tracker',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            print("ontap pressed");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ExpenseMain()));
          },
        )
      ],
    );
  }
}
