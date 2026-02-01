import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todolist_app/core/bindings/app_binding.dart';
import 'package:flutter_todolist_app/core/constants/app_strings.dart';
import 'package:flutter_todolist_app/core/models/task.dart';
import 'package:flutter_todolist_app/core/providers/hive_provider.dart';
import 'package:flutter_todolist_app/core/providers/notification_provider.dart';
import 'package:flutter_todolist_app/core/routes/app_routes.dart';
import 'package:flutter_todolist_app/core/routes/route_names.dart';
import 'package:flutter_todolist_app/core/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveProvider.init();
  final tasksBox = await HiveProvider.openTasksBox();
  final prefsBox = await HiveProvider.openPrefsBox();

  final notificationPlugin = await NotificationProvider.init();

  runApp(
    MyApp(
      tasksBox: tasksBox,
      prefsBox: prefsBox,
      notificationPlugin: notificationPlugin,
    ),
  );
}

class MyApp extends StatelessWidget {
  final Box<Task> tasksBox;
  final Box prefsBox;
  final FlutterLocalNotificationsPlugin notificationPlugin;

  const MyApp({
    super.key,
    required this.tasksBox,
    required this.prefsBox,
    required this.notificationPlugin,
  });

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
          initialBinding: AppBinding(
            tasksBox: tasksBox,
            prefsBox: prefsBox,
            notificationPlugin: notificationPlugin,
          ),
          title: AppStrings.appName,
          getPages: AppRoutes.routes,
          initialRoute: RouteNames.home,
          defaultTransition: Transition.native,
        );
      },
    );
  }
}
