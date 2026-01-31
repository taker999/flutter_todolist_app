import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todolist_app/core/constants/app_colors.dart';
import 'package:flutter_todolist_app/features/add_edit_task/controller/add_edit_task_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DueDateTimeSection extends GetView<AddEditTaskController> {
  const DueDateTimeSection({super.key});

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: controller.selectedDueDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      if (!context.mounted) return;

      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(controller.selectedDueDate.value),
      );

      if (pickedTime != null) {
        final dateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        controller.updateDueDate(dateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Due Date & Time',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.h),
        InkWell(
          onTap: () => _selectDateTime(context),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderGrey),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today),
                SizedBox(width: 12.w),
                Expanded(
                  child: Obx(() {
                    final dateTime = controller.selectedDueDate.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('EEEE, MMMM dd, yyyy').format(dateTime),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          DateFormat('hh:mm a').format(dateTime),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.hintText,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                Icon(Icons.arrow_forward_ios, size: 16.r),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
