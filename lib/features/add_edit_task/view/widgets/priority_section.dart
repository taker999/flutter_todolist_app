import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todolist_app/core/constants/app_colors.dart';
import 'package:flutter_todolist_app/core/widgets/custom_text_widget.dart';
import 'package:flutter_todolist_app/features/add_edit_task/controller/add_edit_task_controller.dart';
import 'package:get/get.dart';

class PrioritySection extends GetView<AddEditTaskController> {
  const PrioritySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          'Priority Level',
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 12.h),
        Obx(
          () => Row(
            spacing: 8.w,
            children: [
              Expanded(
                child: _buildPriorityChip(
                  label: 'High',
                  priority: 1,
                  color: AppColors.primaryRed,
                  icon: Icons.priority_high,
                  isSelected: controller.selectedPriority.value == 1,
                ),
              ),
              Expanded(
                child: _buildPriorityChip(
                  label: 'Medium',
                  priority: 2,
                  color: AppColors.primaryOrange,
                  icon: Icons.remove,
                  isSelected: controller.selectedPriority.value == 2,
                ),
              ),
              Expanded(
                child: _buildPriorityChip(
                  label: 'Low',
                  priority: 3,
                  color: AppColors.primaryGreen,
                  icon: Icons.arrow_downward,
                  isSelected: controller.selectedPriority.value == 3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriorityChip({
    required String label,
    required int priority,
    required Color color,
    required IconData icon,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        controller.updatePriority(priority);
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Ink(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.2) : AppColors.lightGrey,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? color : AppColors.borderGreyLight,
            width: 2.w,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? color : AppColors.primaryGrey),
            SizedBox(height: 4.h),
            CustomTextWidget(
              label,
              fontSize: 12.sp,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
              color: isSelected ? color : AppColors.borderGrey,
            ),
          ],
        ),
      ),
    );
  }
}
