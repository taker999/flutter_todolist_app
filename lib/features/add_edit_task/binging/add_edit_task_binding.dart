import 'package:flutter_todolist_app/core/services/database_service.dart';
import 'package:flutter_todolist_app/features/add_edit_task/controller/add_edit_task_controller.dart';
import 'package:get/get.dart';

class AddEditTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEditTaskController>(
      () => AddEditTaskController(Get.find<DatabaseService>()),
    );
  }
}
