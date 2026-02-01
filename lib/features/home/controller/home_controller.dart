import 'package:flutter_todolist_app/core/enums/sort_by.dart';
import 'package:flutter_todolist_app/core/models/task.dart';
import 'package:flutter_todolist_app/core/services/database_service.dart';
import 'package:flutter_todolist_app/core/services/task_preferences_service.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class HomeController extends GetxController {
  final DatabaseService databaseService;
  final TaskPreferencesService taskPreferencesService;

  HomeController({
    required this.databaseService,
    required this.taskPreferencesService,
  });

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
      _applySortFilter();
    });

    ever(searchQuery, (_) => _applySearchFilter());
    ever(sortBy, (_) => _applySortFilter());
  }

  void updateSortBy(SortBy value) => sortBy.value = value;
  void updateSearchQuery(String query) => searchQuery.value = query;

  void loadTasks() {
    tasks.value = databaseService.readAllTasks();
    _applySortFilter();
  }

  void _applySearchFilter() {
    List<Task> result = List.from(tasks);

    if (searchQuery.value.isNotEmpty) {
      result =
          result.where((task) {
            return task.title.toLowerCase().contains(
                  searchQuery.value.toLowerCase(),
                ) ||
                task.description.toLowerCase().contains(
                  searchQuery.value.toLowerCase(),
                );
          }).toList();
    }

    filteredTasks.value = result;
  }

  Future<void> _applySortFilter() async {
    List<Task> result = List.from(tasks);

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

    await taskPreferencesService.changeSortBy(sortBy.value);

    filteredTasks.value = result;
  }
}
