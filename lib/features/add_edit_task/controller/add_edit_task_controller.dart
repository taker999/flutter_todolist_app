import 'package:flutter/widgets.dart';
import 'package:flutter_todolist_app/core/models/task.dart';
import 'package:get/get.dart';

class AddEditTaskController extends GetxController {
  final Task? task = Get.arguments is Task ? Get.arguments : null;

  final formKey = GlobalKey<FormState>();

  late final TextEditingController titleController;
  late final TextEditingController descriptionController;

  final selectedPriority = 2.obs;
  final selectedDueDate = Rx<DateTime>(
    DateTime.now().add(const Duration(days: 1)),
  );
  final hasReminder = false.obs;

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController(text: task?.title ?? '');
    descriptionController = TextEditingController(text: task?.description ?? '');

    selectedPriority.value = task?.priority ?? 2;
    selectedDueDate.value =
        task?.dueDate ?? DateTime.now().add(const Duration(days: 1));
    hasReminder.value = task?.hasReminder ?? false;
  }

  bool get isEditing => task != null;

  void updatePriority(int priority) => selectedPriority.value = priority;

  void updateReminder(bool value) => hasReminder.value = value;

  void updateDueDate(DateTime date) => selectedDueDate.value = date;

  Future<void> saveTask() async {
    if (formKey.currentState!.validate()) {
      final newTask = Task(
        id: task?.id, // Keep ID if editing
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        priority: selectedPriority.value,
        dueDate: selectedDueDate.value,
        hasReminder: hasReminder.value,
      );
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
