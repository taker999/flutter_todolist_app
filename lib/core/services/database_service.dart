import 'package:flutter_todolist_app/core/models/task.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DatabaseService extends GetxService {
  final Box<Task> taskBox;

  DatabaseService({required this.taskBox});

  Future<Task> createTask(Task task) async {
    final key = await taskBox.add(task);

    final savedTask = task.copyWith(id: key);
    await taskBox.put(key, savedTask);

    return savedTask;
  }

  List<Task> readAllTasks() {
    return taskBox.values.toList();
  }

  Future<void> updateTask(Task task) async {
    await taskBox.put(task.id, task);
  }

  Future<void> deleteTask(int id) async {
    await taskBox.delete(id);
  }
}
