import 'package:flutter/widgets.dart';
import 'package:flutter_todolist_app/core/models/task.dart';
import 'package:flutter_todolist_app/core/services/database_service.dart';
import 'package:flutter_todolist_app/core/services/notification_service.dart';
import 'package:get/get.dart';

class AddEditTaskController extends GetxController {
  final DatabaseService databaseService;
  final NotificationService notificationService;
  AddEditTaskController({
    required this.databaseService,
    required this.notificationService,
  });

  final Task? task = Get.arguments is Task ? Get.arguments : null;

  final formKey = GlobalKey<FormState>();

  late final TextEditingController titleController;
  late final TextEditingController descriptionController;

  final selectedPriority = 2.obs;
  final selectedDueDate = Rx<DateTime>(
    DateTime.now().add(const Duration(days: 1)),
  );
  final hasReminder = false.obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController(text: task?.title ?? '');
    descriptionController = TextEditingController(
      text: task?.description ?? '',
    );

    selectedPriority.value = task?.priority ?? 2;
    selectedDueDate.value =
        task?.dueDate ?? DateTime.now().add(const Duration(days: 1));
    hasReminder.value = task?.hasReminder ?? false;
  }

  bool get isEditing => task != null;

  void updatePriority(int priority) => selectedPriority.value = priority;

  void updateReminder(bool value) => hasReminder.value = value;

  void updateDueDate(DateTime date) => selectedDueDate.value = date;

  Future<bool> saveTask() async {
    if (!formKey.currentState!.validate()) return false;

    isLoading.value = true;

    final newTask = Task(
      id: task?.id,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      priority: selectedPriority.value,
      dueDate: selectedDueDate.value,
      hasReminder: hasReminder.value,
    );

    try {
      if (isEditing) {
        await databaseService.updateTask(newTask);
        await notificationService.cancelTaskNotification(newTask.id!);
        if (newTask.hasReminder && !newTask.isCompleted) {
          await notificationService.scheduleTaskNotification(newTask);
        }
      } else {
        final createdTask = await databaseService.createTask(newTask);
        if (newTask.hasReminder) {
          await notificationService.scheduleTaskNotification(createdTask);
        }
      }

      return true;
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
    return false;
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
