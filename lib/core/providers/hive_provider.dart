import 'package:flutter_todolist_app/core/models/task.dart';
import 'package:hive_flutter/adapters.dart';

class HiveProvider {
  static const taskBoxName = 'tasks';

  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskAdapter());
    }
  }

  static Future<Box<Task>> openTaskBox() {
    return Hive.openBox<Task>(taskBoxName);
  }
}
