import 'package:flutter_todolist_app/core/services/database_service.dart';
import 'package:flutter_todolist_app/core/services/task_preferences_service.dart';
import 'package:flutter_todolist_app/features/home/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        databaseService: Get.find<DatabaseService>(),
        taskPreferencesService: Get.find<TaskPreferencesService>(),
      ),
    );
  }
}
