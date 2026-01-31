import 'dart:ui';

import 'package:flutter_todolist_app/core/constants/app_colors.dart';

Color getPriorityColor(int priority) {
  switch (priority) {
    case 1:
      return AppColors.primaryRed;
    case 2:
      return AppColors.primaryOrange;
    case 3:
      return AppColors.primaryGreen;
    default:
      return AppColors.primaryOrange;
  }
}
