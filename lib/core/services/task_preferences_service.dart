import 'package:flutter_todolist_app/core/constants/hive_key_constants.dart';
import 'package:flutter_todolist_app/core/enums/sort_by.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskPreferencesService extends GetxService {
  final Box prefsBox;

  final sortBy = SortBy.dueDate.obs;

  TaskPreferencesService(this.prefsBox) {
    final String savedValue = prefsBox.get(
      HiveKeyConstants.sortByKey,
      defaultValue: SortBy.dueDate.name,
    );

    sortBy.value = SortBy.values.byName(savedValue);
  }

  Future<void> changeSortBy(SortBy newSortBy) async {
    sortBy.value = newSortBy;
    await prefsBox.put(HiveKeyConstants.sortByKey, newSortBy.name);
  }
}
