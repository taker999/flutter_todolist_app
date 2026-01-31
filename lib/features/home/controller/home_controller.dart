import 'package:flutter_todolist_app/core/models/task.dart';
import 'package:flutter_todolist_app/core/services/database_service.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class HomeController extends GetxController {
  final DatabaseService _databaseService;
  HomeController(this._databaseService);

  final tasks = <Task>[].obs;
  final filteredTasks = <Task>[].obs;

  final sortBy = 'date'.obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();

    // Listen to box changes
    _databaseService.taskBox.listenable().addListener(() {
      tasks.assignAll(_databaseService.readAllTasks());
      _applyFiltersAndSort();
    });

    ever(searchQuery, (_) => _applyFiltersAndSort());
    ever(sortBy, (_) => _applyFiltersAndSort());
  }

  void updateSortBy(String value) => sortBy.value = value;
  void updateSearchQuery(String query) => searchQuery.value = query;

  void loadTasks() {
    tasks.value = _databaseService.readAllTasks();
    _applyFiltersAndSort();
  }

  void _applyFiltersAndSort() {
    List<Task> result = List.from(tasks);

    // Apply search filter
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

    // Apply sorting
    switch (sortBy.value) {
      case 'priority':
        result.sort((a, b) => a.priority.compareTo(b.priority));
        break;
      case 'date':
        result.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        break;
      case 'created':
        result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
    }

    filteredTasks.value = result;
  }
}
