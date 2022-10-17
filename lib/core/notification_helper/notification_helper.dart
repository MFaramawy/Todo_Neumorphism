import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:todo_app/features/task/data/models/task_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotifyHelper {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String selectedNotificationPayload = '';
  static final BehaviorSubject<String> selectNotificationSubject =
      BehaviorSubject<String>();

  // Initialize Notifications
  static initializeNotification() async {
    tz.initializeTimeZones();
    _configureSelectNotificationSubject();
    await _configureLocalTimeZone();
    requestIOSPermissions();
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('appicon');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );

    final details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      selectNotificationSubject.add(details.payload ?? 'Default Payload');
    }
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }
        selectNotificationSubject.add(payload!);
      },
    );
  }

  // Display Notifications
  static displayNotification(
      {required String title, required String body}) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  // Cancel Notifications
  static Future<void> cancelNotification(TaskModel task) async {
    await flutterLocalNotificationsPlugin.cancel(task.id!);
  }

  // Cancel All Notifications
  static Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  // Scheduled Notifications
  static scheduledNotification(TaskModel task) async {
    final int hour = int.parse(task.startTime.split(':')[0]);
    final int minutes = int.parse(task.startTime.split(':')[1].split(' ')[0]);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      task.title,
      task.note,
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
      _nextInstanceOfTenAM(
          hour, minutes, task.reminder, task.repeat, task.date),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
        ),
        iOS: IOSNotificationDetails(),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: '${task.title}|${task.note}|${task.startTime}|',
    );
  }

  static tz.TZDateTime _nextInstanceOfTenAM(
    int hour,
    int minutes,
    int remind,
    String repeat,
    String date,
  ) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final formattedDate = DateFormat.yMMMMd().parse(date);
    final tz.TZDateTime fd = tz.TZDateTime.from(formattedDate, tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, fd.year, fd.month, fd.day, hour, minutes);
    scheduledDate = afterRemind(remind, scheduledDate);
    if (scheduledDate.isBefore(now)) {
      if (repeat == 'Daily') {
        scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
            (formattedDate.day) + 1, hour, minutes);
      }
      if (repeat == 'Weekly') {
        scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
            (formattedDate.day) + 7, hour, minutes);
      }
      if (repeat == 'Monthly') {
        scheduledDate = tz.TZDateTime(tz.local, now.year,
            (formattedDate.month) + 1, formattedDate.day, hour, minutes);
      }
      scheduledDate = afterRemind(remind, scheduledDate);
    }
    return scheduledDate;
  }

  static tz.TZDateTime afterRemind(int remind, tz.TZDateTime scheduledDate) {
    if (remind == 5) {
      scheduledDate = scheduledDate.add(const Duration(minutes: -5));
    }
    if (remind == 10) {
      scheduledDate = scheduledDate.add(const Duration(minutes: -10));
    }
    if (remind == 15) {
      scheduledDate = scheduledDate.add(const Duration(minutes: -15));
    }
    if (remind == 20) {
      scheduledDate = scheduledDate.add(const Duration(minutes: -20));
    }
    return scheduledDate;
  }

  static void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  static Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  static Future onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    // display a dialog with the notification details, tap ok to go to another page
    Builder(builder: (context) {
      showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Title'),
          content: const Text('Body'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Container(color: Colors.white),
                  ),
                );
              },
            )
          ],
        ),
      );
      return const SizedBox();
    });
  }

  static void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      // await Get.to(() => NotificationScreen(payload: payload));
    });
  }
}
