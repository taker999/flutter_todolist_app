import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_todolist_app/core/models/task.dart';
import 'package:flutter_todolist_app/core/services/database_service.dart';
import 'package:flutter_todolist_app/core/services/notification_service.dart';
import 'package:flutter_todolist_app/core/services/task_preferences_service.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AppBinding extends Bindings {
  final Box<Task> tasksBox;
  final Box prefsBox;
  final FlutterLocalNotificationsPlugin notificationPlugin;

  AppBinding({
    required this.tasksBox,
    required this.prefsBox,
    required this.notificationPlugin,
  });

  @override
  void dependencies() {
    Get.lazyPut<DatabaseService>(() => DatabaseService(taskBox: tasksBox));

    Get.lazyPut<TaskPreferencesService>(() => TaskPreferencesService(prefsBox));

    Get.putAsync<NotificationService>(() async {
      final service = NotificationService(notificationPlugin);

      // Check overdue tasks
      final tasks = Get.find<DatabaseService>().readAllTasks();
      await service.checkOverdueTasks(tasks);

      return service;
    });
  }
}
