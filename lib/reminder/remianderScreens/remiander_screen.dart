import 'package:flutter/material.dart';
import 'package:dailyTrac/reminder/model/remiander_info.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dailyTrac/main.dart';
import 'package:dailyTrac/reminder/model/database_helper.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

class RemianderList extends StatefulWidget {
  RemianderList({Key key}) : super(key: key);

  @override
  _RemianderListState createState() => _RemianderListState();
}

class _RemianderListState extends State<RemianderList> {
  DateTime _remianderTime;
  String title = 'some work to do';
  String _alarmTimeString = DateFormat('HH:mm').format(DateTime.now());
  String _remianderTimeString;
  RemianderHelper _remianderHelper = RemianderHelper();
  Future<List<Remianderinfo>> _reimanders;
  var hourSche;
  var minuteSche = 0;
  @override
  void initState() {
    _remianderTime = DateTime.now();
    _remianderHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadAlarms();
    });
    super.initState();
  }

  void loadAlarms() {
    _reimanders = _remianderHelper.getRemiander();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Remianderinfo>>(
          future: _reimanders,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return ListView(
                children: snapshot.data.map<Widget>((remiander) {
                  var remianderTime = DateFormat('hh:mm aa')
                      .format(remiander.remianderDateTime);
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.purple, Colors.red],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.red.withOpacity(0.4),
                            blurRadius: 8,
                            offset: Offset(4, 4))
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.label,
                                  color: Colors.white,
                                  size: 26,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  remiander.title,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 23),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  remianderTime,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.white,
                                  onPressed: () {
                                    _remianderHelper.delete(remiander.id);
                                    loadAlarms();
                                  },
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }).followedBy([
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.blue[300], Colors.red],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    child: FlatButton(
                      onPressed: () {
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
                            return StatefulBuilder(
                              builder: (context, setModalState) {
                                return Container(
                                  padding: const EdgeInsets.all(32),
                                  child: Column(
                                    children: [
                                      FlatButton(
                                        onPressed: () async {
                                          var selectedTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          );
                                          if (selectedTime != null) {
                                            final now = DateTime.now();
                                            var selectedDateTime = DateTime(
                                                now.year,
                                                now.month,
                                                now.day,
                                                selectedTime.hour,
                                                selectedTime.minute);

                                            setModalState(() {
                                              _remianderTime = selectedDateTime;
                                              _remianderTimeString =
                                                  selectedTime.toString();
                                              hourSche = selectedTime.hour -
                                                  DateTime.now().hour;
                                              minuteSche = selectedTime.minute -
                                                  DateTime.now().minute;
                                            });
                                            setState(() {
                                              _alarmTimeString =
                                                  DateFormat('HH:mm')
                                                      .format(selectedDateTime);
                                            });
                                          }
                                        },
                                        child: Text(
                                          _alarmTimeString,
                                          style: TextStyle(fontSize: 32),
                                        ),
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
                                        height: 25,
                                      ),
                                      FloatingActionButton.extended(
                                        onPressed: () async {
                                          if (minuteSche < 0) {
                                            var h = hourSche + 24;
                                            var m = -minuteSche;
                                            scheduleAlarm(h, m);
                                          } else {
                                            scheduleAlarm(hourSche, minuteSche);
                                          }
                                          var remianderInfo = Remianderinfo(
                                            remianderDateTime: _remianderTime,
                                            title: title,
                                          );
                                          _remianderHelper
                                              .insertReminader(remianderInfo);
                                          setState(() {
                                            loadAlarms();
                                          });
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.alarm),
                                        label: Text('Save'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                            size: 40,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Add Reminder",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )
                ]).toList(),
              );
            return Center(
              child: Text(
                "Loading ...",
                style: TextStyle(color: Colors.white),
              ),
            );
          }),
    );
  }

  void scheduleAlarm(var hourSchedule, var minuteSchedule) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Reminder',
        title,
        tz.TZDateTime.now(tz.local).add(
            Duration(hours: hourSchedule, minutes: minuteSchedule, seconds: 0)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
