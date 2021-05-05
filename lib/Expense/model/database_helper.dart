import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'expense_info.dart';

final String tableExpense = 'expense';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnAmount = 'amount';
final String columnCategory = 'category';

class ExpenseHelper {
  static Database _database;
  static ExpenseHelper _expenseHelper;

  ExpenseHelper._createInstance();
  factory ExpenseHelper() {
    if (_expenseHelper == null) {
      _expenseHelper = ExpenseHelper._createInstance();
    }
    return _expenseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "expense.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
           create table $tableExpense ( 
          $columnId integer primary key autoincrement,
          $columnTitle text not null,
          $columnCategory text not null,
          $columnAmount integer not null)
        ''');
      },
    );
    return database;
  }

  void insertExpense(ExpenseInfo expenseInfo) async {
    var db = await this.database;
    var result = await db.insert(tableExpense, expenseInfo.toMap());
    print('result : $result');
  }

  Future<List<ExpenseInfo>> getExpense() async {
    List<ExpenseInfo> _expense = [];

    var db = await this.database;
    var result = await db.query(tableExpense);
    result.forEach((element) {
      var expanseInfo = ExpenseInfo.fromMap(element);
      _expense.add(expanseInfo);
    });

    return _expense;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db
        .delete(tableExpense, where: '$columnId = ?', whereArgs: [id]);
  }
}
