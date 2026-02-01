import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todolist_app/core/constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      elevation: 2,
      titleTextStyle: TextStyle(
        color: AppColors.primaryBLue,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: AppColors.primaryBLue),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColors.primaryBLue, width: 2.w),
      ),
      labelStyle: const TextStyle(color: Colors.blueGrey),
      hintStyle: const TextStyle(color: AppColors.hintText),
    ),
    iconTheme: IconThemeData(color: AppColors.primaryBLue, size: 23.r),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: AppColors.primaryBLue,
        foregroundColor: AppColors.primaryWhite,
        iconColor: AppColors.primaryWhite,
        iconSize: 16.r,
        textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
