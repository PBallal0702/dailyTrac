import 'package:flutter/material.dart';

class NoNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.note_add,
                  size: 88,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Click + to add Note',
                  style: TextStyle(color: Colors.white, fontSize: 32),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
