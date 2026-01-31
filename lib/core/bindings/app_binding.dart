import 'package:flutter_todolist_app/core/models/task.dart';
import 'package:flutter_todolist_app/core/services/database_service.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AppBinding extends Bindings {
  final Box<Task> taskBox;
  AppBinding({required this.taskBox});

  @override
  void dependencies() {
    Get.lazyPut<DatabaseService>(() => DatabaseService(taskBox: taskBox));
  }
}
