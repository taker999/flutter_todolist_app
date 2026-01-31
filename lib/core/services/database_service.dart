import 'package:flutter_todolist_app/core/models/task.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class DatabaseService extends GetxService {
  final Box<Task> taskBox;
  final _uuid = const Uuid();

  DatabaseService({required this.taskBox});

  Future<Task> createTask(Task task) async {
    final id = _uuid.v4();
    final taskWithId = task.copyWith(id: id);

    await taskBox.put(id, taskWithId);
    return taskWithId;
  }

  Task? readTask(String id) {
    return taskBox.get(id);
  }

  List<Task> readAllTasks() {
    return taskBox.values.toList();
  }

  Future<void> updateTask(Task task) async {
    await taskBox.put(task.id, task);
  }

  Future<void> deleteTask(String id) async {
    await taskBox.delete(id);
  }

  bool taskExists(String id) {
    return taskBox.containsKey(id);
  }
}
