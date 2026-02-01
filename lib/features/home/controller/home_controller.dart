import 'package:flutter/widgets.dart';
import 'package:flutter_todolist_app/core/enums/sort_by.dart';
import 'package:flutter_todolist_app/core/models/task.dart';
import 'package:flutter_todolist_app/core/services/database_service.dart';
import 'package:flutter_todolist_app/core/services/notification_service.dart';
import 'package:flutter_todolist_app/core/services/task_preferences_service.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class HomeController extends GetxController {
  final DatabaseService databaseService;
  final NotificationService notificationService;
  final TaskPreferencesService taskPreferencesService;

  HomeController({
    required this.databaseService,
    required this.notificationService,
    required this.taskPreferencesService,
  });

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  final tasks = <Task>[].obs;
  final filteredTasks = <Task>[].obs;

  final sortBy = SortBy.dueDate.obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();

    // Listen to box changes
    databaseService.taskBox.listenable().addListener(() {
      tasks.assignAll(databaseService.readAllTasks());
      _applyFilters();
    });

    ever(searchQuery, (_) => _applyFilters());
    ever(sortBy, (_) => _applyFilters());
  }

  bool get isSearching => searchQuery.value.isNotEmpty;
  void updateSortBy(SortBy value) => sortBy.value = value;
  void updateSearchQuery(String query) => searchQuery.value = query;
  void clearSearchQuery() {
    searchController.clear();
    updateSearchQuery('');
    searchFocusNode.unfocus();
  }

  void loadTasks() {
    tasks.value = databaseService.readAllTasks();
    _applyFilters();
  }

  Future<void> toggleTaskCompletion(Task task) async {
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);

    await databaseService.updateTask(updatedTask);

    if (updatedTask.isCompleted) {
      await notificationService.cancelTaskNotification(updatedTask.id!);
    } else {
      await notificationService.scheduleTaskNotification(updatedTask);
    }
  }

  Future<void> deleteTask(int id) async {
    await databaseService.deleteTask(id);
    await notificationService.cancelTaskNotification(id);
  }

  void _applyFilters() {
    List<Task> result = List.from(tasks);

    // Search
    if (searchQuery.value.isNotEmpty) {
      result =
          result
              .where(
                (task) =>
                    task.title.toLowerCase().contains(
                      searchQuery.value.toLowerCase(),
                    ) ||
                    task.description.toLowerCase().contains(
                      searchQuery.value.toLowerCase(),
                    ),
              )
              .toList();
    }

    // Sort
    switch (sortBy.value) {
      case SortBy.priority:
        result.sort((a, b) => a.priority.compareTo(b.priority));
        break;
      case SortBy.dueDate:
        result.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        break;
      case SortBy.creationDate:
        result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
    }

    filteredTasks.value = result;
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }
}
