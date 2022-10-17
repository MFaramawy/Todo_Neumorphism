import 'package:flutter/material.dart';
import 'injection_container.dart' as di;
import 'package:todo_app/app.dart';
import 'package:todo_app/core/db_helper/db_helper.dart';
import 'package:todo_app/core/notification_helper/notification_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await DBHelper.initDb();
  NotifyHelper.initializeNotification();
  runApp(const Todo());
}
