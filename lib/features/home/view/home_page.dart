import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todolist_app/core/constants/app_strings.dart';
import 'package:flutter_todolist_app/core/routes/route_names.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.homeAppBarTitle),
        elevation: 2,
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) {},
            ),
          ),

          // Task List
          Expanded(child: ListView()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(RouteNames.addEditTask),
        icon: const Icon(Icons.add),
        label: const Text(AppStrings.addTaskFloatingActionButtonText),
      ),
    );
  }
}
