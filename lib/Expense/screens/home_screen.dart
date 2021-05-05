import 'package:dailyTrac/Expense/screens/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:dailyTrac/Expense/model/database_helper.dart';
import 'package:dailyTrac/Expense/model/expense_info.dart';

class ExpenseHome extends StatefulWidget {
  @override
  _ExpenseHomeState createState() => _ExpenseHomeState();
}

class _ExpenseHomeState extends State<ExpenseHome> {
  List<Color> colorList = [
    Colors.green,
    Colors.red,
  ];

  Map<String, double> dataMap = {
    "Income": 0,
    "Expense": 0,
  };

  Future<List<ExpenseInfo>> _expense;
  ExpenseHelper _expenseHelper = ExpenseHelper();

  @override
  void initState() {
    _expenseHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadExpense();
    });
    super.initState();
  }

  void loadExpense() async {
    _expense = _expenseHelper.getExpense();
    if (mounted) setState(() {});

    List<ExpenseInfo> list = new List();

    list = await _expense;
    dataMap["Income"] = 0;
    dataMap["Expense"] = 0;
    for (var i = 0; i < list.length; i++) {
      if (list[i].category == 'Expense') {
        setState(() {
          dataMap["Expense"] = dataMap["Expense"] + list[i].amount;
        });
      }
      if (list[i].category == 'Income') {
        setState(() {
          dataMap["Income"] = dataMap["Income"] + list[i].amount;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = " ";
    int amount = 0;
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: SafeArea(
        child: Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(top: 5, left: 20, right: 10),
                      padding: EdgeInsets.all(5),
                      color: Colors.red[300],
                      child: Column(
                        children: [
                          Text(
                            'Expense',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            dataMap["Expense"].toString(),
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                    )),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(top: 5, left: 10, right: 20),
                      padding: EdgeInsets.all(5),
                      color: Colors.green[300],
                      child: Column(
                        children: [
                          Text(
                            'Income',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            dataMap["Income"].toString(),
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: PieChart(
                      dataMap: dataMap,
                      animationDuration: Duration(milliseconds: 800),
                      chartLegendSpacing: 32,
                      chartRadius: MediaQuery.of(context).size.width / 3.2,
                      colorList: colorList,
                      initialAngleInDegree: 0,
                      ringStrokeWidth: 32,
                      legendOptions: LegendOptions(
                        showLegendsInRow: false,
                        legendPosition: LegendPosition.right,
                        showLegends: true,
                        legendTextStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      chartValuesOptions: ChartValuesOptions(
                        showChartValueBackground: true,
                        showChartValues: true,
                        showChartValuesInPercentage: false,
                        showChartValuesOutside: false,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: FutureBuilder<List<ExpenseInfo>>(
                        future: _expense,
                        builder: (context, snapshot) {
                          if (snapshot.hasData)
                            return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    elevation: 10,
                                    color: Colors.white,
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.account_balance_wallet_sharp,
                                        size: 40,
                                      ),
                                      title: Text(
                                        snapshot.data[index].title,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      subtitle: Text(
                                          snapshot.data[index].category,
                                          style: TextStyle(fontSize: 16)),
                                      trailing: Text(
                                          snapshot.data[index].amount
                                              .toString(),
                                          style: TextStyle(fontSize: 20)),
                                    ),
                                  );
                                });

                          return Center(
                            child: Text(
                              "Loading ...",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            )),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.red,
                child: Text(
                  'Add Expense',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                    useRootNavigator: true,
                    context: context,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setModalState) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Center(
                                child: Text('Add Expense',
                                    style: TextStyle(fontSize: 24)),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Enter Title',
                                ),
                                onChanged: (text) {
                                  setState(() {
                                    title = text;
                                    print(title);
                                  });
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Text("Category : ",
                                      style: TextStyle(fontSize: 18)),
                                  Text("Expense",
                                      style: TextStyle(fontSize: 18))
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Enter Amount',
                                ),
                                onChanged: (amt) {
                                  setState(() {
                                    amount = int.parse(amt);
                                    print(amount);
                                  });
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Center(
                                child: FlatButton(
                                  color: Colors.redAccent,
                                  child: Text(
                                    "Add",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  onPressed: () {
                                    var expenseInfo = ExpenseInfo(
                                        category: 'Expense',
                                        title: title,
                                        amount: amount);
                                    _expenseHelper.insertExpense(expenseInfo);
                                    setState(() {
                                      loadExpense();
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      });
                    });
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.green,
                child: Text(
                  'Add Income',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                    useRootNavigator: true,
                    context: context,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setModalState) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Center(
                                child: Text('Add Income',
                                    style: TextStyle(fontSize: 24)),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Enter Title',
                                ),
                                onChanged: (text) {
                                  setState(() {
                                    title = text;
                                    print(title);
                                  });
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Text("Category : ",
                                      style: TextStyle(fontSize: 18)),
                                  Text("Income", style: TextStyle(fontSize: 18))
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Enter Amount',
                                ),
                                onChanged: (amt) {
                                  setState(() {
                                    amount = int.parse(amt);
                                    print(amount);
                                  });
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Center(
                                child: FlatButton(
                                  color: Colors.green,
                                  child: Text(
                                    "Add",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  onPressed: () {
                                    var expenseInfo = ExpenseInfo(
                                        category: 'Income',
                                        title: title,
                                        amount: amount);
                                    _expenseHelper.insertExpense(expenseInfo);
                                    setState(() {
                                      loadExpense();
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      });
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
