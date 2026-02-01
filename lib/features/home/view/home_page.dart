import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todolist_app/core/constants/app_colors.dart';
import 'package:flutter_todolist_app/core/constants/app_strings.dart';
import 'package:flutter_todolist_app/core/enums/sort_by.dart';
import 'package:flutter_todolist_app/core/routes/route_names.dart';
import 'package:flutter_todolist_app/core/utils/get_priority_color.dart';
import 'package:flutter_todolist_app/core/widgets/custom_text_widget.dart';
import 'package:flutter_todolist_app/features/home/controller/home_controller.dart';
import 'package:flutter_todolist_app/features/home/view/widgets/task_card.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(AppStrings.homeAppBarTitle),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              SortBy sortBy = SortBy.values.byName(value);
              controller.updateSortBy(sortBy);
            },
            itemBuilder:
                (context) => [
                  _buildPopupMenuItem(
                    value: SortBy.dueDate.name,
                    text: AppStrings.sortByDueDate,
                    isSelected: controller.sortBy.value == SortBy.dueDate,
                  ),
                  _buildPopupMenuItem(
                    value: SortBy.priority.name,
                    text: AppStrings.sortByPriority,
                    isSelected: controller.sortBy.value == SortBy.priority,
                  ),
                  _buildPopupMenuItem(
                    value: SortBy.creationDate.name,
                    text: AppStrings.sortByCreationDate,
                    isSelected: controller.sortBy.value == SortBy.creationDate,
                  ),
                ],
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => controller.searchFocusNode.unfocus(),
        child: Obx(
          () => Column(
            children: [
              // Search Bar
              Padding(
                padding: EdgeInsets.all(12.w),
                child: TextField(
                  controller: controller.searchController,
                  focusNode: controller.searchFocusNode,
                  decoration: InputDecoration(
                    hintText: AppStrings.searchTasksHint,
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: AppColors.lightGrey,
                    suffixIcon:
                        controller.isSearching
                            ? IconButton(
                              onPressed: () {
                                controller.clearSearchQuery();
                                FocusScope.of(context).unfocus();
                              },
                              icon: const Icon(Icons.close),
                            )
                            : null,
                  ),
                  onChanged: (value) {
                    controller.updateSearchQuery(value);
                  },
                ),
              ),

              // Task List
              Expanded(
                child:
                    controller.filteredTasks.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          itemCount: controller.filteredTasks.length,
                          itemBuilder: (context, index) {
                            final task = controller.filteredTasks[index];
                            return TaskCard(
                              key: ValueKey(task.id),
                              task: task,
                              priorityColor: getPriorityColor(task.priority),
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.searchFocusNode.unfocus();
          Get.toNamed(RouteNames.addEditTask);
        },
        icon: const Icon(Icons.add),
        label: const CustomTextWidget(
          AppStrings.addTaskFloatingActionButtonText,
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem({
    required String value,
    required String text,
    required bool isSelected,
  }) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          if (isSelected) ...[const Icon(Icons.done), SizedBox(width: 4.w)],
          CustomTextWidget(text),
        ],
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
          CustomTextWidget(
            AppStrings.noTasks,
            fontSize: 16.sp,
            color: AppColors.borderGrey,
          ),
          SizedBox(height: 4.h),
          CustomTextWidget(
            AppStrings.addNewTask,
            fontSize: 14.sp,
            color: AppColors.primaryGrey,
          ),
        ],
      ),
    );
  }
}
