import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todolist_app/core/bindings/app_binding.dart';
import 'package:flutter_todolist_app/core/constants/app_strings.dart';
import 'package:flutter_todolist_app/core/models/task.dart';
import 'package:flutter_todolist_app/core/providers/hive_provider.dart';
import 'package:flutter_todolist_app/core/routes/app_routes.dart';
import 'package:flutter_todolist_app/core/routes/route_names.dart';
import 'package:flutter_todolist_app/core/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveProvider.init();
  final taskBox = await HiveProvider.openTaskBox();

  runApp(MyApp(taskBox: taskBox));
}

class MyApp extends StatelessWidget {
  final Box<Task> taskBox;
  const MyApp({super.key, required this.taskBox});

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
          initialBinding: AppBinding(taskBox: taskBox),
          title: AppStrings.appName,
          getPages: AppRoutes.routes,
          initialRoute: RouteNames.home,
          defaultTransition: Transition.native,
        );
      },
    );
  }
}
