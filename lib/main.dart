import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todolist_app/core/constants/app_strings.dart';
import 'package:flutter_todolist_app/core/routes/app_routes.dart';
import 'package:flutter_todolist_app/core/routes/route_names.dart';
import 'package:flutter_todolist_app/core/theme/app_theme.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          title: AppStrings.appName,
          getPages: AppRoutes.routes,
          initialRoute: RouteNames.home,
          defaultTransition: Transition.native,
        );
      },
    );
  }
}
