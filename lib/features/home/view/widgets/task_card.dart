import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todolist_app/core/constants/app_colors.dart';
import 'package:flutter_todolist_app/core/models/task.dart';
import 'package:flutter_todolist_app/core/routes/route_names.dart';
import 'package:flutter_todolist_app/core/widgets/custom_text_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, required this.priorityColor});

  final Task task;
  final Color priorityColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(
          color:
              task.isOverdue ? AppColors.primaryRed : AppColors.borderBlueLight,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(RouteNames.addEditTask, arguments: task);
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Task Title
                  Expanded(
                    child: CustomTextWidget(
                      task.title,
                      maxLines: 1,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      decoration:
                          task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),

                  // Priority Chip
                  _buildChip(
                    label: task.priorityText,
                    fontSize: 12.sp,
                    borderColor: priorityColor,
                  ),

                  // More Options
                  _buildPopupMenuOptions(),
                ],
              ),

              // Task Description
              CustomTextWidget(
                task.description,
                maxLines: 2,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),

              SizedBox(height: 8.h),

              // Due Date and Reminder Info
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 14.sp,
                    color: task.isOverdue ? Colors.red : Colors.grey,
                  ),
                  SizedBox(width: 4.w),
                  CustomTextWidget(
                    DateFormat('MMM dd, yyyy HH:mm').format(task.dueDate),
                    fontSize: 12.sp,
                    color:
                        task.isOverdue
                            ? AppColors.primaryRed
                            : AppColors.hintText,
                    fontWeight: task.isOverdue ? FontWeight.bold : null,
                  ),
                  SizedBox(width: 8.w),
                  if (task.isOverdue)
                    _buildChip(
                      label: 'OVERDUE',
                      fontSize: 10.sp,
                      textColor: AppColors.primaryWhite,
                      backgroundColor: AppColors.primaryRed,
                    ),
                  if (task.isDueSoon)
                    _buildChip(
                      label: 'DUE SOON',
                      fontSize: 10.sp,
                      textColor: AppColors.primaryWhite,
                      backgroundColor: AppColors.primaryOrange,
                    ),
                  if (task.hasReminder)
                    Padding(
                      padding: EdgeInsets.only(left: 15.h),
                      child: Icon(
                        Icons.notifications_active,
                        size: 16.r,
                        color: Colors.blue[700],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip({
    required String label,
    required double fontSize,
    Color? borderColor,
    Color? textColor,
    Color? backgroundColor,
  }) {
    return Chip(
      label: CustomTextWidget(label),
      visualDensity: VisualDensity.compact,
      labelStyle: TextStyle(color: textColor, fontSize: fontSize),
      padding: backgroundColor == null ? EdgeInsets.all(2.w) : EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      side:
          borderColor != null
              ? BorderSide(color: borderColor, width: 2.w)
              : null,
      backgroundColor: backgroundColor,
    );
  }

  Widget _buildPopupMenuOptions() {
    return PopupMenuButton(
      itemBuilder:
          (context) => [
            PopupMenuItem(
              child: Row(
                children: [
                  Icon(Icons.edit, size: 20.r),
                  SizedBox(width: 8.w),
                  const CustomTextWidget('Edit'),
                ],
              ),
              onTap: () {},
            ),
            PopupMenuItem(
              child: Row(
                children: [
                  Icon(Icons.delete, size: 20.r, color: AppColors.primaryRed),
                  SizedBox(width: 8.w),
                  const CustomTextWidget('Delete', color: AppColors.primaryRed),
                ],
              ),
              onTap: () {},
            ),
          ],
    );
  }
}
