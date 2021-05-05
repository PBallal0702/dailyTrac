import 'package:flutter/material.dart';

class ExpenseList extends StatefulWidget {
  ExpenseList({Key key}) : super(key: key);

  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Icon(
                  Icons.account_balance_wallet,
                  size: 40,
                ),
                title: Text(
                  'Dmart',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                subtitle: Text('expense',
                    style: TextStyle(color: Colors.black, fontSize: 16)),
                trailing: Text(
                  '50 Rs',
                  style: TextStyle(color: Colors.redAccent, fontSize: 24),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Icon(
                  Icons.account_balance_wallet,
                  size: 40,
                ),
                title: Text(
                  'Dmart',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                subtitle: Text('expense',
                    style: TextStyle(color: Colors.black, fontSize: 16)),
                trailing: Text(
                  '50 Rs',
                  style: TextStyle(color: Colors.redAccent, fontSize: 24),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Icon(
                  Icons.account_balance_wallet,
                  size: 40,
                ),
                title: Text(
                  'Dmart',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                subtitle: Text('expense',
                    style: TextStyle(color: Colors.black, fontSize: 16)),
                trailing: Text(
                  '50 Rs',
                  style: TextStyle(color: Colors.redAccent, fontSize: 24),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Icon(
                  Icons.account_balance_wallet,
                  size: 40,
                ),
                title: Text(
                  'Dmart',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                subtitle: Text('expense',
                    style: TextStyle(color: Colors.black, fontSize: 16)),
                trailing: Text(
                  '50 Rs',
                  style: TextStyle(color: Colors.redAccent, fontSize: 24),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Icon(
                  Icons.account_balance_wallet,
                  size: 40,
                ),
                title: Text(
                  'Dmart',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                subtitle: Text('expense',
                    style: TextStyle(color: Colors.black, fontSize: 16)),
                trailing: Text(
                  '50 Rs',
                  style: TextStyle(color: Colors.redAccent, fontSize: 24),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Icon(
                  Icons.account_balance_wallet,
                  size: 40,
                ),
                title: Text(
                  'Salary',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                subtitle: Text('Income',
                    style: TextStyle(color: Colors.black, fontSize: 16)),
                trailing: Text(
                  '600 Rs',
                  style: TextStyle(color: Colors.green, fontSize: 24),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
