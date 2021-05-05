import 'package:dailyTrac/drawer/drawer_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'keepNote/backend/database_helper.dart';
import 'keepNote/backend/note_model.dart';
import 'package:sqflite/sqflite.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid =
      AndroidInitializationSettings('codex_logo');

  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});

  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Tracker',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var listcount = 0;
  DatabaseHelper databaseHelper = new DatabaseHelper();
  List<NoteModel> noteList;
  @override
  void initState() {
    super.initState();
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<NoteModel>> noteListFuture = databaseHelper.getNotes();
      noteListFuture.then((noteList) {
        setState(() {
          this.listcount = noteList.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    String getSystemTime() {
      var now = new DateTime.now();
      return new DateFormat("H:m:s").format(now);
    }

    var formattedDate = DateFormat('EEE,d MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!timezoneString.startsWith('-')) {
      offsetSign = '+';
    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      appBar: AppBar(
        title: Text(
          "Daily Tracker",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF2D2F41),
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
        return SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 32,
                      ),
                      CircleAvatar(
                        child: Icon(Icons.track_changes_rounded, size: 60),
                        radius: 40,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Text(
                        "${getSystemTime()}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Text(
                        formattedDate,
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    ));
  }
}
