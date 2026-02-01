import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todolist_app/core/constants/app_colors.dart';
import 'package:flutter_todolist_app/core/constants/app_strings.dart';
import 'package:flutter_todolist_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter_todolist_app/core/widgets/custom_text_widget.dart';
import 'package:flutter_todolist_app/features/add_edit_task/controller/add_edit_task_controller.dart';
import 'package:flutter_todolist_app/features/add_edit_task/view/widgets/due_date_time_section.dart';
import 'package:flutter_todolist_app/features/add_edit_task/view/widgets/priority_section.dart';
import 'package:get/get.dart';

class AddEditTaskPage extends GetView<AddEditTaskController> {
  const AddEditTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextWidget(
          controller.isEditing
              ? AppStrings.editTaskAppBarTitle
              : AppStrings.addTaskAppBarTitle,
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12.w),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Field
                CustomTextFormField(
                  controller: controller.titleController,
                  label: AppStrings.taskTitleLabel,
                  hint: AppStrings.taskTitleHint,
                  prefixIcon: Icons.title,
                  maxLines: 3,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppStrings.titleValidationText;
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.h),

                // Description Field
                CustomTextFormField(
                  controller: controller.descriptionController,
                  label: AppStrings.taskDescriptionLabel,
                  hint: AppStrings.taskDescriptionHint,
                  prefixIcon: Icons.description,
                  maxLines: 6,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppStrings.descriptionValidationText;
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20.h),

                // Priority Section
                const PrioritySection(),

                SizedBox(height: 20.h),

                // Due Date Section
                const DueDateTimeSection(),

                SizedBox(height: 20.h),

                // Reminder Section
                _buildReminderSection(),

                SizedBox(height: 25.h),

                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReminderSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.blueBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderBlueLight),
      ),
      child: Row(
        children: [
          const Icon(Icons.notifications_active),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  AppStrings.enableReminderTitle,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                CustomTextWidget(
                  AppStrings.getNotifiedSubtitle,
                  fontSize: 12.sp,
                  color: AppColors.hintText,
                ),
              ],
            ),
          ),
          Obx(
            () => Switch(
              value: controller.hasReminder.value,
              onChanged: (value) {
                controller.updateReminder(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 40.h,
      child: Obx(() {
        final isLoading = controller.isLoading.value;

        return ElevatedButton.icon(
          onPressed:
              isLoading
                  ? null
                  : () async {
                    final isSaved = await controller.saveTask();

                    if (isSaved) {
                      Get.back();
                    }
                  },
          icon: isLoading ? null : const Icon(Icons.save),
          label:
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomTextWidget(
                    controller.isEditing
                        ? AppStrings.updateButtonText
                        : AppStrings.createButtonText,
                  ),
        );
      }),
    );
  }
}
