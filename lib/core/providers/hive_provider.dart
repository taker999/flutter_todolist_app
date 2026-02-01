import 'package:flutter_todolist_app/core/constants/hive_boxes.dart';
import 'package:flutter_todolist_app/core/models/task.dart';
import 'package:hive_flutter/adapters.dart';

class HiveProvider {
  HiveProvider._();

  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskAdapter());
    }
  }

  static Future<Box<Task>> openTasksBox() {
    return Hive.openBox<Task>(HiveBoxes.tasksBox);
  }

  static Future<Box> openPrefsBox() {
    return Hive.openBox(HiveBoxes.prefsBox);
  }
}
