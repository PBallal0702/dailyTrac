import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'remiander_info.dart';

final String tableRemiander = 'remiander';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDateTime = 'remianderDateTime';
final String columnPending = 'isPending';

class RemianderHelper {
  static Database _database;
  static RemianderHelper _remianderHelper;

  RemianderHelper._createInstance();
  factory RemianderHelper() {
    if (_remianderHelper == null) {
      _remianderHelper = RemianderHelper._createInstance();
    }
    return _remianderHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "remiander.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
           create table $tableRemiander ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnDateTime text not null,
          $columnPending integer)
        ''');
      },
    );
    return database;
  }

  void insertReminader(Remianderinfo remianderInfo) async {
    var db = await this.database;
    var result = await db.insert(tableRemiander, remianderInfo.toMap());
    print('result : $result');
  }

  Future<List<Remianderinfo>> getRemiander() async {
    List<Remianderinfo> _remiander = [];

    var db = await this.database;
    var result = await db.query(tableRemiander);
    result.forEach((element) {
      var remianderInfo = Remianderinfo.fromMap(element);
      _remiander.add(remianderInfo);
    });

    return _remiander;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db
        .delete(tableRemiander, where: '$columnId = ?', whereArgs: [id]);
  }
}
