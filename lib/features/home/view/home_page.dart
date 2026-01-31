import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todolist_app/core/constants/app_colors.dart';
import 'package:flutter_todolist_app/core/constants/app_strings.dart';
import 'package:flutter_todolist_app/core/routes/route_names.dart';
import 'package:flutter_todolist_app/core/utils/priority_color.dart';
import 'package:flutter_todolist_app/features/home/controller/home_controller.dart';
import 'package:flutter_todolist_app/features/home/view/widgets/task_card.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.homeAppBarTitle),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {},
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: 'date',
                    child: Text(AppStrings.sortByDueDate),
                  ),
                  const PopupMenuItem(
                    value: 'priority',
                    child: Text(AppStrings.sortByPriority),
                  ),
                  const PopupMenuItem(
                    value: 'created',
                    child: Text(AppStrings.sortByCreationDate),
                  ),
                ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(12.w),
            child: TextField(
              decoration: InputDecoration(
                hintText: AppStrings.searchTasksHint,
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.lightGrey,
              ),
              onChanged: (value) {
                controller.updateSearchQuery(value);
              },
            ),
          ),

          // Task List
          Expanded(
            child: Obx(() {
              if (controller.filteredTasks.isEmpty) {
                return _buildEmptyState();
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = controller.filteredTasks[index];
                  return TaskCard(
                    task: task,
                    priorityColor: getPriorityColor(task.priority),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(RouteNames.addEditTask),
        icon: const Icon(Icons.add),
        label: const Text(AppStrings.addTaskFloatingActionButtonText),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.task_alt, size: 80.r, color: AppColors.primaryGrey),
          SizedBox(height: 16.h),
          Text(
            'No tasks found',
            style: TextStyle(fontSize: 16.sp, color: AppColors.borderGrey),
          ),
          SizedBox(height: 4.h),
          Text(
            'Tap + to add a new task',
            style: TextStyle(fontSize: 14.sp, color: AppColors.primaryGrey),
          ),
        ],
      ),
    );
  }
}
